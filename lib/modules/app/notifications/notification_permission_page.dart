import 'dart:io';

import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/buttons/custom_text_button.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/notifications/widgets/notification_permission/notification_permission_theme.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../core/assets/gen/assets.gen.dart';
import '../../../core/di/di.dart';
import '../../../core/utils/device_info/device_info.dart';
import '../../../core/utils/notifications/init_notifications.dart';
import '../../../core/widgets/buttons/custom_elevated_button.dart';

class NotificationPermissionPage extends StatelessWidget {
  const NotificationPermissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = NotificationPermissionTheme.of(context);

    return Scaffold(
      appBar: CustomAppbar(),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.greyE8,
                  radius: 120.w,
                  child: Pic(
                    Assets.icons.notification.path,
                    height: 110.w,
                    color: AppColors.red6E,
                  ),
                ),
                SizedBox(height: 32.h),
                Text(
                  Loc.of(context).enableNotificationAccess,
                  style: myTheme.titleTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16.h),
                Text(
                  Loc.of(context).enableNotificationsToStayUpToDate,
                  style: myTheme.subTitleTextStyle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48.h),
                CustomElevatedButton(
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      final sdkVersion = await di<DeviceInfoClass>().getAndroidSdkVersion();
                      if (sdkVersion < 33) {
                        if (context.mounted) {
                          // Skip permission request for older devices
                          Nav.root.replaceAll(context);
                          Nav.notifications.push(context);
                        }
                        return;
                      }
                    }
                    requestPermissions();
                    if (context.mounted) {
                      Nav.root.replaceAll(context);
                      Nav.notifications.push(context);
                    }
                  },
                  child: Text(Loc.of(context).allowNotifications),
                ),
                SizedBox(height: 16.h),
                CustomTextButton(
                  onPressed: () {
                    Nav.root.replaceAll(context);
                  },
                  child: Text(Loc.of(context).maybeLater),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
