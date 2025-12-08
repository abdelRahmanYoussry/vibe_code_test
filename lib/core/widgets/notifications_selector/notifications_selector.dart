import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/notification_count/notifications_count_bloc.dart';
import '../../utils/notification_count/notifications_count_state.dart';

class NotificationsSelector extends StatelessWidget {
  const NotificationsSelector({super.key, required this.builder});
  final Widget Function(BuildContext context, int notificationsCount) builder;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<NotificationsCountBloc, NotificationsCountState, int>(
        bloc: NotificationsCountBloc(),
        selector: (state) => state.notificationsCount,
        builder: (context, notificationsCount)=> builder(context,notificationsCount),);
  }
}
