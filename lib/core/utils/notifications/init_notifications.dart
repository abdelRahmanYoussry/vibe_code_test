import 'dart:convert';
import 'dart:io';

import 'package:test_vibe/core/navigation/nav.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../modules/app/root/bloc/root_bloc.dart';
import '../../di/di.dart';
import '../../navigation/nav_obs.dart';


FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

Future initNotifications() async {
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // iOS-specific settings with better configuration
  const iOSSettings = DarwinInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    requestProvisionalPermission: false,
    requestCriticalPermission: false,
  );

  await flutterLocalNotificationsPlugin!.initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: iOSSettings,
      macOS: DarwinInitializationSettings(),
    ),
    onDidReceiveNotificationResponse: (details) => onNotificationTapped(details.payload),
  );

  // For iOS, explicitly request notification permissions with better error handling
  if (Platform.isIOS) {
    try {
      final bool? result = await flutterLocalNotificationsPlugin!
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );

      debugPrint('iOS notification permissions granted: $result');

      // Also request Firebase messaging permissions
      final settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
        provisional: false,
        criticalAlert: false,
      );

      debugPrint('Firebase notification permission status: ${settings.authorizationStatus}');
    } catch (e) {
      debugPrint('Error requesting iOS notification permissions: $e');
    }
  }
}

Future<void> requestPermissions() async {
  await [
    Permission.notification,
  ].request();
  handleBackgroundMessageInteractions();
}

void onNotificationTapped(String? payload) async {
  debugPrint('onNotificationTapped $payload');
  if (payload != null && payload.isNotEmpty) {
      final data = jsonDecode(payload);
      if (data['type'] == 'order') {
        final navObs = di<NavObs>();
        final currentRoute = navObs.current;

        if (currentRoute == Nav.root) {
          // If we're already on root, just change the page
          RootBloc.of(Nav.mainNavKey.currentState!.context).changePage(RootIndex.orders);
        } else {
          Nav.root.popUntil(Nav.mainNavKey.currentState!.context);
          RootBloc.of(Nav.mainNavKey.currentState!.context).changePage(RootIndex.orders);
          // If we're on any other page, replace all and navigate to root with orders index
        }
      }
      if(data['type'] == 'points') {
        Nav.points.push(Nav.mainNavKey.currentState!.context);
      }
      // if (data['type'] == 'badge') {
      //   AppBloc().getUser();
      //   final context = Nav.mainNavKey.currentState!.context;
      //   if (context.mounted) {
      //     final badgeModel = BadgeModel.fromJson(data);
      //     Nav.levelUpPage(Nav.mainNavKey.currentState!.context, badgeModel);
      //   }
      // }
      // if (data['type'] == 'ticket') {
      //   final context = Nav.mainNavKey.currentState!.context;
      //   if (context.mounted) {
      //     Nav.allTicketsScreen(Nav.mainNavKey.currentState!.context);
      //     final id = data['id'];
      //     if (validString(id)) {
      //       final r = await di<SupportRepo>().getSingleTicket(id.toString());
      //       r.fold(
      //         (l) {},
      //         (r) {
      //           if (Nav.mainNavKey.currentState!.context.mounted) {
      //             Nav.singleTicketScreen(Nav.mainNavKey.currentState!.context, r);
      //           }
      //         },
      //       );
      //     }
      //   }
      // }
      // if (data['type'] == 'event') {
      //   final context = Nav.mainNavKey.currentState!.context;
      //   if (context.mounted) {
      //     final id = data['id'];
      //     if (validString(id)) {
      //       if (Nav.mainNavKey.currentState!.context.mounted) {
      //         Nav.singleEventScreen(Nav.mainNavKey.currentState!.context, id.toString());
      //       }
      //     }
      //   }
      // }
      // if (data['type'] == 'discovery_category' || data['type'] == 'can_retake_discovery') {
      //   if (Nav.mainNavKey.currentState!.context.mounted) {
      //     Nav.knowYourself(Nav.mainNavKey.currentState!.context);
      //   }
      // }
      // if (data['type'] == 'specialty') {
      //   if (Nav.mainNavKey.currentState!.context.mounted) {
      //     Nav.specialtiesSuitableToMe(Nav.mainNavKey.currentState!.context, isMoreSpecialty: false);
      //   }
      // }
      // if (data['type'] == 'post' && isIktshaf) {
      //   if (Nav.mainNavKey.currentState!.context.mounted) {
      //     Nav.profile(Nav.mainNavKey.currentState!.context, SubProfilePages.counselor_posts);
      //   }
      // }

  }else{
    debugPrint('Notification payload is null or empty');
  }
}

Future<void> handleBackgroundMessageInteractions() async {
  RemoteMessage? initialMessage = await FirebaseMessaging.instance.getInitialMessage();

  if (initialMessage != null) {
    onNotificationTapped(jsonEncode(initialMessage.data));
  }
}
