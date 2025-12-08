import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/dialogs/custom_dialog/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:size_config/size_config.dart';

import '../../../../modules/app/live_tracking/live_tracking_repo.dart';
import '../../../di/di.dart';
import '../../buttons/custom_elevated_button.dart';
import 'custom_alert_dialog_theme.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final myTheme = CustomAlertDialogTheme.of(context);
    return CustomDialog(
      title: Text(Loc.of(context).are_you_sure),
      icon: Icon(Icons.warning_amber_rounded),
      builder: (context) => Column(
        children: [
          AutoSizeText(
            title,
            textAlign: TextAlign.center,
            maxLines: 2,
            minFontSize: 4.sp,
            stepGranularity: 1.sp,
            style: myTheme.titleTextStyle,
          ),
          if (validString(subtitle)) ...[
            SizedBox(height: 4.h),
            AutoSizeText(
              subtitle!,
              textAlign: TextAlign.center,
              maxLines: 2,
              minFontSize: 4.sp,
              stepGranularity: 1.sp,
              style: myTheme.subtitleTextStyle,
            ),
          ],
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(Loc.of(context).cancel),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: Text(Loc.of(context).confirm),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CustomChangeBranchDialog extends StatelessWidget {
  const CustomChangeBranchDialog({
    super.key,
    required this.storeName,
    required this.storeAddress,
  });

  final String storeName;
  final String storeAddress;

  @override
  Widget build(BuildContext context) {
    final myTheme = CustomAlertDialogTheme.of(context);
    final autoAssignEnabled = di<LiveTrackingRepo>().autoAssignBranchEnabled;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Theme.of(context).dialogBackgroundColor,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Animated location icon with gradient background
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).primaryColor.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Icon(
                Icons.location_on_rounded,
                size: 40.w,
                color: Colors.white,
              ),
            ),

            SizedBox(height: 24.h),

            // Title with better typography
            Text(
              Loc.of(context).nearest_branch_updated,
              style: myTheme.titleTextStyle.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 8.h),

            // Subtitle
            Text(
              Loc.of(context).the_nearest_branch_is,
              style: myTheme.subtitleTextStyle.copyWith(
                color: Colors.grey[600],
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 20.h),

            // Branch info card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: Theme.of(context).primaryColor.withOpacity(0.1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.store_rounded,
                        size: 20.w,
                        color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          storeName,
                          maxLines: 2,
                          style: myTheme.subtitleTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 15.sp,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.place_rounded,
                        size: 16.w,
                        color: Colors.grey[600],
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          storeAddress,
                          maxLines: 3,
                          style: myTheme.subtitleTextStyle.copyWith(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),
            // Action buttons with better spacing
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                    child: Text(
                      Loc.of(context).ok,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TextButton(
                      onPressed: () {
                        Nav.settings.replace(context);
                      },
                      child: Text(Loc.of(context).modify_feature),),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
