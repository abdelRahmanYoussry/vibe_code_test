import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/notifications/model/notification_model.dart';
import 'package:test_vibe/modules/app/notifications/widgets/notification_item/notification_item_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/navigation/nav.dart';
import '../../../root/bloc/root_bloc.dart';
import '../../bloc/notifications_bloc.dart';
import '../../bloc/notifications_state.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({
    super.key,
    required this.model,
    required this.bloc,
  });

  final NotificationModel model;
  final NotificationsBloc bloc;

  @override
  State<NotificationItem> createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    final myTheme = NotificationItemTheme.of(context);
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocListener<NotificationsBloc, NotificationsState>(
        listener: (context, state) {
        if(state.markAsReadState.success!=null && state.markAsReadState.success!) {
          if (widget.model.eventableType.toString().toLowerCase() == 'order') {
            Nav.root.replaceAll(context, args: RootIndex.orders);

          }
          }
        },
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () async {
            widget.bloc.markNotificationAsRead(notificationId: widget.model.id.toString());
            debugPrint('NotificationItem onTap: ${widget.model.eventableType} - ${widget.model.eventableId}');

          },
          child: Column(
            children: [
              Row(
                children: [
                  Pic(
                    widget.model.icon ?? '',
                    size: myTheme.iconStyle.size,
                    color: myTheme.iconStyle.color,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      widget.model.title,
                      style: myTheme.bodyTextStyle,
                    ),
                  ),
                  // if (dateTime != null)
                  //   Text(
                  //     FuzzyTime.formatShortMessages(context, dateTime),
                  //     style: myTheme.dateTextStyle,
                  //   ),
                  Text(
                    widget.model.timeDiff,
                    style: myTheme.dateTextStyle,
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(),
              SizedBox(height: 16.h),
            ],
          ),
        ),
      ),
    );
  }
}
