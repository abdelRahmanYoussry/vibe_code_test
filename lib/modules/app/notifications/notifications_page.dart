import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/modules/app/notifications/widgets/notification_item/notification_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/di/di.dart';
import '../../../core/localization/gen/loc.dart';
import '../../../core/theme/extensions/spacing_theme.dart';
import '../../../core/widgets/empty/empty_widget.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import 'bloc/notifications_bloc.dart';
import 'bloc/notifications_state.dart';
import 'model/notification_model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  // Define the demo notification data
  final Map<String, List<NotificationModel>> demoNotificationData = _createDemoNotificationData();

  // Flag to toggle between demo and API data
  final bool _useDemoData = false;

  @override
  void initState() {
    super.initState();
  }

  // Create demo data as NotificationModel objects
  static Map<String, List<NotificationModel>> _createDemoNotificationData() {
    // Original JSON structure
    final Map<String, dynamic> rawData = {
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
    };

    // Convert to proper model objects
    final Map<String, List<NotificationModel>> result = {};
    rawData.forEach((key, value) {
      if (key != "message") {
        result[key] = (value as List).map((item) =>
            NotificationModel.fromJson(item as Map<String, dynamic>),
        ).toList();
      }
    });

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final spacing = SpacingTheme.of(context);

    return CustomScaffold(
      appBar: CustomAppbar(
        title: Text(Loc.of(context).notifications),
      ),
      body: BlocProvider(
        create: (context) => _useDemoData
            ? di<NotificationsBloc>()
            : di<NotificationsBloc>()..getNotifications(),
        child: BlocSelector<NotificationsBloc, NotificationsState, GetNotificationsState>(
          selector: (state) => state.getNotificationsState,
          builder: (context, state) {
            // Use demo data if flag is true, otherwise use API data
            final list = _useDemoData
                ? demoNotificationData
                : state.notifications;

            if (state.loadingState.loading && !_useDemoData) {
              return const Center(child: CircularLoadingWidget());
            }
            if ((list == null || list.isEmpty) && !state.loadingState.loading) {
              return Center(
                child: EmptyWidget(
                  title: Loc.of(context).no_recorded_data_found,
                ),
              );
            }

            return ListView.builder(
              padding: spacing.pagePadding,
              itemCount: list!.entries.length,
              itemBuilder: (context, groupIndex) {
                final entry = list.entries.elementAt(groupIndex);
                final groupTitle = entry.key;
                final groupItems = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      child: Text(
                        groupTitle,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ...groupItems.map((notification) => NotificationItem(model: notification,bloc: context.read<NotificationsBloc>() ,)),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
