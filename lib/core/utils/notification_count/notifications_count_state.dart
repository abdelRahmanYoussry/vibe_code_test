import 'package:equatable/equatable.dart';

import '../data_utils.dart';

class NotificationsCountState extends Equatable {
  final int notificationsCount;

  const NotificationsCountState({
    this.notificationsCount = 0 ,
  });

  NotificationsCountState copyWith({
    int? notificationsCount,
    bool notificationNull = false,
  }) =>
      NotificationsCountState(
        notificationsCount: notificationNull ? validateInt(notificationsCount) : notificationsCount ?? this.notificationsCount,
      );


  @override
  List<Object?> get props => [notificationsCount];
}
