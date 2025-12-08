import 'notification_model.dart';

class NotificationResponseModel {
  final Map<String, List<NotificationModel>> notifications;
  final String message;
  final String unreadCount; // Added to track unread notifications

  NotificationResponseModel({
    required this.notifications,
    required this.message,
   required this.unreadCount ,
  });

  factory NotificationResponseModel.fromJson(Map<String, dynamic> json) {
    final Map<String, List<NotificationModel>> notificationsMap = {};

    // Access the 'data' field which contains notification categories
    final data = json['data'];
    if (data is Map<String, dynamic>) {
      data.forEach((key, value) {
        if (value is List) {
          notificationsMap[key] = value
              .map((item) => NotificationModel.fromJson(item))
              .toList();
        }
      });
    }
    int unreadCount = 0;
    if (data is Map<String, dynamic> && data.containsKey('unread_count')) {
      unreadCount = data['unread_count'] ?? 0;
    }
    return NotificationResponseModel(
      notifications: notificationsMap,
      message: json['message'] ?? '',
      unreadCount: unreadCount.toString(),
    );
  }
}

Map<String, dynamic> demoNotificationData = {
  "today": [
    {
      "id": 1,
      "read": 0,
      "notified": "1",
      "title": "New offer available!",
      "body": "Check out our latest coffee discounts.",
      "eventable_id": 5,
      "eventable_type": "offer",
      "created_at": "2023-07-15 09:23:45",
      "time_diff": "today",
    },
    {
      "id": 2,
      "read": 1,
      "notified": "1",
      "title": "Order #12345 confirmed",
      "body": "Your order has been confirmed and is being prepared.",
      "eventable_id": 12345,
      "eventable_type": "order",
      "created_at": "2023-07-15 07:15:22",
      "time_diff": "today",
    }
  ],
  "yesterday": [
    {
      "id": 3,
      "read": 0,
      "notified": "1",
      "title": "Payment successful",
      "body": "Your payment for order #12340 was successful.",
      "eventable_id": 12340,
      "eventable_type": "payment",
      "created_at": "2023-07-14 16:45:11",
      "time_diff": "yesterday",
    }
  ],
  "this_week": [
    {
      "id": 4,
      "read": 1,
      "notified": "1",
      "title": "New coffee blend available",
      "body": "Try our new Ethiopian blend - now available in all stores!",
      "eventable_id": 28,
      "eventable_type": "product",
      "created_at": "2023-07-12 10:30:00",
      "time_diff": "this_week",
    },
    {
      "id": 5,
      "read": 0,
      "notified": "1",
      "title": "Weekend special offer",
      "body": "Get 20% off on all signature drinks this weekend.",
      "eventable_id": 7,
      "eventable_type": "promotion",
      "created_at": "2023-07-11 08:15:33",
      "time_diff": "this_week",
    }
  ],
  "last_month": [
    {
      "id": 6,
      "read": 1,
      "notified": "1",
      "title": "Loyalty points updated",
      "body": "You've earned 50 points from your recent purchases.",
      "eventable_id": null,
      "eventable_type": "loyalty",
      "created_at": "2023-06-28 14:22:17",
      "time_diff": "last_month",
    }
  ],
  "20d": [
    {
      "id": 7,
      "read": 0,
      "notified": "1",
      "title": "Welcome to Coffee Driver!",
      "body": "Thank you for joining our coffee community.",
      "eventable_id": null,
      "eventable_type": "welcome",
      "created_at": "2023-06-25 11:45:00",
      "time_diff": "20d",
    }
  ],
  "message": "success",
};
