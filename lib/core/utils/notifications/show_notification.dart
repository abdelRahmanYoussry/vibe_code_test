import 'dart:convert';
import 'dart:io';

import 'package:test_vibe/core/utils/notifications/setup_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../data_utils.dart';
import '../remote/api_app_config.dart';
import 'init_notifications.dart';

// Future<void> showNotification(RemoteMessage message, [SilentNotificationHandler? handler]) async {
//   final title = message.notification?.title ?? '';
//   final body = message.notification?.body ?? '';
//   final data = message.data;
//
//   debugPrint('NOTIFICATIONDATA $title $body data= $data');
//
//   if (data.isNotEmpty) {
//     debugPrint('showNotification: data is not empty');
//     handler?.call(data);
//     // Handle order notifications differently
//     if (data['type'] == 'order') {
//       debugPrint('showNotification: order notification received, skipping regular notification');
//       // Don't show regular notification for orders, let the persistent service handle it
//       return;
//     }
//   }
//
//   if (!validString(body) && !validString(title)) {
//     debugPrint('showNotification: title and body are empty');
//     return;
//   }
//
//   final context = Nav.mainNavKey.currentState?.context;
//   if (context == null) {
//     debugPrint('showNotification: context is null');
//     return;
//   }
//
//   showLocalNotifications(title, body, 1, data: data);
// }

showLocalNotifications(String title, String body, int id, {Map<String, dynamic>? data}) async {
  if (flutterLocalNotificationsPlugin == null) {
    await initNotifications();
  }

  if (kDebugMode) {
    print('showNotificationnnnn : $title $body');
  }

  final channelId = AppConfig.packageName;
  await flutterLocalNotificationsPlugin?.cancel(id);
  try {
    await flutterLocalNotificationsPlugin?.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          'Claro',
          channelDescription: 'Notification channel for Claro',
          importance: Importance.max,
          priority: Priority.high,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: 'default',
          badgeNumber: null,
          attachments: null,
          subtitle: null,
          threadIdentifier: null,
        ),
      ),
      payload: jsonEncode(data),
    );
    debugPrint('Notification display attempted for ${Platform.isIOS ? 'iOS' : 'Android'}');
  } on Exception catch (e) {
    if (kDebugMode) {
      print('showLocalNotifications : $e');
    }
  }
}


Future<void> showNotification(RemoteMessage message, [SilentNotificationHandler? handler]) async {
  final data = message.data;

  // Extract title and body from notification OR data field
  String title = message.notification?.title ?? '';
  String body = message.notification?.body ?? '';

  // If notification field is null, try to get from data
  if (!validString(title) && data.containsKey('title')) {
    title = data['title']?.toString() ?? '';
  }
  if (!validString(body) && data.containsKey('body')) {
    body = data['body']?.toString() ?? '';
  }

  debugPrint('NOTIFICATIONDATA title=$title body=$body data=$data');

  if (data.isNotEmpty) {
    debugPrint('showNotification: data is not empty');
    handler?.call(data);

    // Handle order notifications differently
    if (data['type'] == 'order') {
      debugPrint('showNotification: order notification received, skipping regular notification');
      return;
    }
  }

  // Check if both title and body are empty
  if (!validString(body) && !validString(title)) {
    debugPrint('body is $body title is $title');
    debugPrint('showNotification: title and body are empty');
    return;
  }

  // final context = Nav.mainNavKey.currentState?.context;
  // if (context == null) {
  //   debugPrint('showNotification: context is null');
  //   return;
  // }

  showLocalNotifications(title, body, 1, data: data);
}
