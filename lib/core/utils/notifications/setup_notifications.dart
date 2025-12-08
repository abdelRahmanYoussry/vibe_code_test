import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:test_vibe/core/utils/notifications/presistent_order_notification_service.dart';
import 'package:test_vibe/core/utils/notifications/show_notification.dart';
import 'package:test_vibe/core/utils/order_count/order_count_bloc.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/app/live_tracking/live_tracking_repo.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../../cache/cache_helper.dart';
import '../../di/di.dart';
import '../../models/user_model.dart';
import '../../repos/lang_repo.dart';
import '../../theme/constants/app_strings.dart';
import '../data_utils.dart';
import '../debouncer.dart';
import '../notification_count/notifications_count_bloc.dart';
import '../remote/api_helper.dart';
import 'init_notifications.dart';
import 'supports_firebase.dart';

typedef SilentNotificationHandler = void Function(Map<String, dynamic> data);

class SetupFCM {
  SetupFCM({
    required this.apiHelper,
    required this.langRepo,
    required this.cacheHelper,
  });

  static SetupFCM get i => di();

  final Debouncer _debouncer = Debouncer();

  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;

  String? _fcmToken;

  Future<String?> getFcmToken() async {
    if (validString(_fcmToken)) {
      return _fcmToken!;
    }
    await initFcmToken();
    return _fcmToken;
  }

  Future _sendFCMToServer(String? fcmToken) async {
    log('SetupFCM._sendFCMToServer');

    if (fcmToken == null) return;

    _fcmToken = fcmToken;

    try {
      final token =
          await cacheHelper.get(kUserKey).then((json) => json == null ? null : UserModel.fromJson(json).userData.token);
      if (!validString(token)) {
        return;
      }
      // final String? savedToken = await cacheHelper.get(kUserToken);
      await cacheHelper.put(kUserToken, fcmToken);

      await apiHelper.postData(
        AppConfig.updateDeviceToken(),
        typeJSON: true,
        signOutOn: false,
        token: token,
        lang: langRepo.lang,
        data: {
          "new_device_token": _fcmToken!,
        },
      );
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
    }
  }

  final List<StreamSubscription> _subs = [];

  void init() {
    log('SetupFCM.init');
    if (supportsFirebase) {
      _debouncer.run(() async => _initFCM(), 2000);
    }
  }

  void _initFCM() async {
    log('SetupFCM._initFCM');
    if (flutterLocalNotificationsPlugin == null) {
      await initNotifications();
    }

    final details = await flutterLocalNotificationsPlugin?.getNotificationAppLaunchDetails();
    if (details?.notificationResponse != null) {
      onNotificationTapped(details!.notificationResponse!.payload);
    }
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await initFcmToken();

    _subs.add(FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) => _sendFCMToServer(fcmToken)));

    _subs.add(
      FirebaseMessaging.onMessage.listen((event) {
        debugPrint('SetupFCM._initFCM.onMessage ${event.toMap().toString()}');
        NotificationsCountBloc().getNotificationsCount();
        final data = event.data;

        _messageHandler(data);
        if (data['type'] == 'order') {
          debugPrint('Order notification: skipping regular notification display');
          _handleOrderNotificationForForeground(data, event);
          return;
        }

        showNotification(event, _handler);
      }),
    );
    FirebaseMessaging.onBackgroundMessage(onbackgroundMessage);
    NotificationsCountBloc().getNotificationsCount();
    _subs.add(
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        NotificationsCountBloc().getNotificationsCount();
        onNotificationTapped(jsonEncode(event.data));
      }),
    );
  }

  // initFcmToken() async {
  //   // final fcmToken = Platform.isAndroid ? await FirebaseMessaging.instance.getToken() : await FirebaseMessaging.instance.getAPNSToken();
  //   final fcmToken = await FirebaseMessaging.instance.getToken() ;
  //   log('FCM : $fcmToken');
  //
  //   _sendFCMToServer(fcmToken);
  // }
  Future<void> initFcmToken() async {
    if (Platform.isIOS) {
      // Check for notification permissions
      final NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
      );
      if (settings.authorizationStatus != AuthorizationStatus.authorized) {
        debugPrint('User declined notification permissions: ${settings.authorizationStatus}');
        return;
      }

      String? apnsToken;
      int retries = 0;
      const maxRetries = 5;
      const retryDelay = Duration(seconds: 2);

      // Retry mechanism to wait for APNS token to be set
      while (apnsToken == null && retries < maxRetries) {
        apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        if (apnsToken == null) {
          debugPrint('APNS token not set yet, retrying...');
          await Future.delayed(retryDelay);
          retries++;
        }
      }

      if (apnsToken == null) {
        debugPrint('Failed to get APNS token after $maxRetries retries');
        return;
      }
    }

    final fcmToken = await FirebaseMessaging.instance.getToken();
    debugPrint('FCM : $fcmToken');

    _sendFCMToServer(fcmToken);
  }

  SilentNotificationHandler? _handler;

  set dataHandler(SilentNotificationHandler handler) {
    _handler = handler;
  }

  void loggedIn() async {
    log('SetupFCM.loggedIn');
    if (supportsFirebase) {
      FirebaseMessaging.instance.subscribeToTopic('all');
    }
  }

  void logout() async {
    log('SetupFCM.logout');
    if (supportsFirebase) {
      FirebaseMessaging.instance.unsubscribeFromTopic('all');
    }
  }

  void dispose() async {
    log('SetupFCM.dispose');
    for (final sub in _subs) {
      await sub.cancel();
    }
  }

  void _messageHandler(Map<String, dynamic> data) {
    if (data.isNotEmpty) {
      if (data['type'] == 'order') {
        di<LiveTrackingRepo>().checkOrdersAndDetermineTracking();
        debugPrint('orderrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
       OrderCountBloc().getOrdersCount();
        if(data['buy_x_get_y']=='1'){
          debugPrint('rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr');
          eventBus.fire(RefreshBuyXGetYEvent());
        }
       eventBus.fire(GetUserOrdersEvent());
        _handleOrderNotification(data);
      }
    }
  }
}

@pragma('vm:entry-point')
Future<void> onbackgroundMessage(RemoteMessage message) async {
  debugPrint('Background message received: ${message.data}');
  if (message.notification == null && message.data.isNotEmpty) {
    final data = message.data;
    // if (data['type'] == 'order') {
    //   await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform,
    //   );
    //   await initDI();
    //   try {
    //     final prefs = await SharedPreferences.getInstance();
    //     final userJson = prefs.getString(kUserKey);
    //     if (userJson != null) {
    //       final Map<String, dynamic> userMap = jsonDecode(userJson);
    //       final UserModel userModel = UserModel.fromJson(userMap);
    //       // Set the token in AuthRepo
    //       di<AuthRepo>().token = userModel.userData.token;
    //       di<AuthRepo>().user = userModel.userData;
    //     }
    //   } catch (e) {
    //     debugPrint('Error loading user data in background: $e');
    //   }
    //   _handleOrderNotification(data);
    //   di<LiveTrackingRepo>().checkOrdersAndDetermineTracking();
    //
    //   return;
    // }
    if (data['type'] == 'order') {
      _handleOrderNotification(data);
      di<LiveTrackingRepo>().checkOrdersAndDetermineTracking();

      return;
    }
  }

  showNotification(message);
}


Future<void> _handleOrderNotification(Map<String, dynamic> data) async {
  final orderId = data['id']?.toString();
  final status = data['status']?.toString();

  if (orderId == null || status == null) return;

  final title = data['title'] ?? 'Order #$orderId';
  final body = data['body'] ?? 'Order status updated to $status';

  // Check if the order is canceled/cancelled
  if (status.toLowerCase() == 'canceled' || status.toLowerCase() == 'cancelled') {
    // Remove existing persistent notification if any
    await PersistentOrderNotificationService.instance.removeOrderNotification(orderId);

    // Show normal notification for canceled orders
    showLocalNotifications(
        title,
        body,
        int.tryParse(orderId) ?? orderId.hashCode.abs(),
        data: data,
    );
    return;
  }

  // For all other statuses, show persistent notification
  await PersistentOrderNotificationService.instance.showOrderNotification(
    orderId: orderId,
    status: status,
    title: title,
    body: body,
    estimatedTime: data['estimated_time'],
    readyTime: data['estimated_ready_time'],
    confirmTime: data['confirmed_time'],
    preparationAt: data['preparation_at'],
    estimatedPreparationMinutes: data['estimated_preparation_minutes']?.toString(),
  );

  // Auto-remove notification when order is completed or delivered
  if (status.toLowerCase() == 'completed' || status.toLowerCase() == 'delivered') {
    Future.delayed(const Duration(seconds: 4), () {
      PersistentOrderNotificationService.instance.removeOrderNotification(orderId);
    });
  }
}

Future<void> _handleOrderNotificationForForeground(Map<String, dynamic> data, RemoteMessage event) async {
  // Create a proper notification message for orders when app is in foreground
  final title = data['title'] ?? 'Order Update';
  final body = data['body'] ?? 'Your order #${data['id']} is ${data['status']}';

  // Create a synthetic RemoteMessage with notification payload
  final syntheticMessage = RemoteMessage(
    messageId: event.messageId,
    data: data,
    notification: RemoteNotification(
      title: title,
      body: body,
    ),
  );

  // Now show the notification normally
  showNotification(syntheticMessage);
}
