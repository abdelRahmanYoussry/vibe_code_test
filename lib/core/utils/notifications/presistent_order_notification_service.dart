import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../functions.dart';
import 'init_notifications.dart';

class PersistentOrderNotificationService {
  static const String _orderChannelId = 'order_tracking_channel';
  static const String _orderChannelName = 'Order Tracking';
  static const String _orderChannelDescription = 'Persistent notifications for order tracking';

  static PersistentOrderNotificationService? _instance;

  static PersistentOrderNotificationService get instance => _instance ??= PersistentOrderNotificationService._();

  PersistentOrderNotificationService._();

  final Map<String, Map<String, dynamic>> _activeOrders = {};

  Future<void> initialize() async {
    if (flutterLocalNotificationsPlugin == null) {
      await initNotifications();
    }

    // Create notification channel for Android with sound
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        _orderChannelId,
        _orderChannelName,
        description: _orderChannelDescription,
        importance: Importance.high,
        enableVibration: true,
        playSound: true,
        showBadge: true,
        enableLights: true,
      );

      await flutterLocalNotificationsPlugin!
          .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  Future<void> showOrderNotification({
    required String orderId,
    required String status,
    required String title,
    required String body,
    String? estimatedTime,
    String? readyTime,
    String? confirmTime,
    String? preparationAt,
    String? estimatedPreparationMinutes,
  }) async {
    await initialize();

    final notificationId = _getNotificationId(orderId);

    // Store order data
    _activeOrders[orderId] = {
      'status': status,
      'title': title,
      'body': body,
      'estimatedTime': estimatedTime,
      'estimated_ready_time': readyTime,
      'confirmed_time': confirmTime,
      'preparation_at': preparationAt,
      'estimated_preparation_minutes': estimatedPreparationMinutes,
    };

    final customContent = _buildCustomNotificationContent(
      status: status,
      title: title,
      body: body,
      estimatedTime: estimatedTime,
      readyTime: readyTime,
      confirmTime: confirmTime,
      preparationAt: preparationAt,
      estimatedPreparationMinutes: estimatedPreparationMinutes,
    );

    await flutterLocalNotificationsPlugin?.show(
      notificationId,
      title,
      customContent,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _orderChannelId,
          _orderChannelName,
          channelDescription: _orderChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          ongoing: true,
          autoCancel: false,
          enableVibration: true,
          playSound: true,
          // Enable sound for Android
          showProgress: false,
          indeterminate: false,
          styleInformation: BigTextStyleInformation(
            customContent,
            contentTitle: title,
            summaryText: 'Tap to view details',
          ),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          // Enable sound for iOS
          sound: 'default',
          threadIdentifier: 'order_$orderId',
          categoryIdentifier: 'ORDER_CATEGORY',
        ),
      ),
      payload: jsonEncode({
        'type': 'order',
        'orderId': orderId,
        'status': status,
      }),
    );
  }

  String _buildCustomNotificationContent({
    required String status,
    required String title,
    required String body,
    String? estimatedTime,
    String? readyTime,
    String? confirmTime,
    String? preparationAt,
    String? estimatedPreparationMinutes,
  }) {
    final bool isProcessing = status.toLowerCase() == 'processing';
    final bool isPreparing = status.toLowerCase() == 'preparing';
    final bool isReady = status.toLowerCase() == 'ready';
    bool isCompleted = status.toLowerCase() == 'completed' || status.toLowerCase() == 'delivered';

    // Step indicators
    final step1Icon = isProcessing || isPreparing || isReady || isCompleted ? '✅' : '⭕';
    final step2Icon = isPreparing || isReady || isCompleted ? '✅' : '⭕';
    final step3Icon = isReady || isCompleted ? '✅' : '⭕';
    debugPrint('title: $title body: $body status: $status, Icons: $step1Icon $step2Icon $step3Icon');
    // Time calculations
    String step1Time = '';
    String step2Time = '';
    String step3Time = '';
    // Step 1 (Confirmed) - show confirmed time
    if (confirmTime != null) {
      step1Time = convertUtcToLocalTime(confirmTime, 'h:mm a');
    }
    // Step 2 (Preparing) - use preparation_at if active, estimated_preparation_minutes if inactive
    if (isPreparing || isReady || isCompleted) {
      // Step 2 is active, use preparation_at
      if (preparationAt != null) {
        step2Time = convertUtcToLocalTime(preparationAt, 'h:mm a');
      }
    } else {
      // Step 2 is inactive, show estimated minutes
      if (estimatedPreparationMinutes != null) {
        step2Time = '${estimatedPreparationMinutes}m';
      }
    }
    // Step 3 (Ready) - show ready time
    if (readyTime != null) {
      step3Time = convertUtcToLocalTime(readyTime, 'h:mm a');
    }
    // Build progress display with times under icons
    String progressDisplay;
    if (Platform.isIOS) {
      // Compact vertical layout for iOS
      progressDisplay = '''
  $step1Icon Confirm--$step2Icon Preparing-- $step3Icon Ready
  ${step1Time.padRight(8)}             ${step2Time.padRight(8)}             $step3Time''';
    } else {
      // Extended layout for Android with better spacing
      progressDisplay = ''' $step1Icon Confirm  -------  $step2Icon  Preparing  ------- $step3Icon Ready
  ${step1Time.padRight(8)}                    ${step2Time.padRight(8)}               $step3Time''';
    }
    return '$body\n$progressDisplay';
  }

  Future<void> updateOrderStatus({
    required String orderId,
    required String newStatus,
    String? estimatedTime,
    String? readyTime,
    String? confirmTime,
    String? preparationAt,
    String? estimatedPreparationMinutes,
  }) async {
    final orderData = _activeOrders[orderId];
    if (orderData == null) return;

    await showOrderNotification(
      orderId: orderId,
      status: newStatus,
      title: orderData['title'],
      body: orderData['body'],
      estimatedTime: estimatedTime ?? orderData['estimatedTime'],
      readyTime: readyTime ?? orderData['estimated_ready_time'],
      confirmTime: confirmTime ?? orderData['confirmed_time'],
      preparationAt: preparationAt ?? orderData['preparation_at'],
      estimatedPreparationMinutes: estimatedPreparationMinutes ?? orderData['estimated_preparation_minutes'],
    );
  }

  Future<void> removeOrderNotification(String orderId) async {
    final notificationId = _getNotificationId(orderId);
    await flutterLocalNotificationsPlugin?.cancel(notificationId);
    _activeOrders.remove(orderId);
  }

  int _getNotificationId(String orderId) {
    return int.tryParse(orderId) ?? orderId.hashCode.abs();
  }

  bool hasActiveOrder(String orderId) => _activeOrders.containsKey(orderId);

  List<String> get activeOrderIds => _activeOrders.keys.toList();
}
