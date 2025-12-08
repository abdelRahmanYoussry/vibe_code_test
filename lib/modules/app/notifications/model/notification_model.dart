import 'package:equatable/equatable.dart';

import '../../../../core/assets/gen/assets.gen.dart';
import '../../../../core/utils/data_utils.dart';

class NotificationModel extends Equatable {
  final int id;
  final int read;
  final String notified;
  final String title;
  final String? body;
  final dynamic eventableId;
  final dynamic eventableType;
  final String createdAt;
  final String timeDiff;
  final String? icon; // Keep for UI display

  const NotificationModel({
    required this.id,
    required this.read,
    required this.notified,
    required this.title,
    this.body,
    this.eventableId,
    this.eventableType,
    required this.createdAt,
    required this.timeDiff,
    this.icon,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
        id: json['id'],
        read: json['read'],
        notified: validateString(json['notified']),
        title: validateString(json['title']),
        body: json['body'],
        eventableId: json['eventable_id'],
        eventableType: json['eventable_type'],
        createdAt: validateString(json['created_at']),
        timeDiff: validateString(json['time_diff']),
        icon: json['icon'] ?? Assets.icons.notification.path,
      );

  @override
  List<Object?> get props => [
        id,
        read,
        notified,
        title,
        body,
        eventableId,
        eventableType,
        createdAt,
        timeDiff,
        icon,
      ];
}
