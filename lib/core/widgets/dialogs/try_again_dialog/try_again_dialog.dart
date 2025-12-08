import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../localization/gen/loc.dart';
import '../../../utils/data_utils.dart';
import '../custom_alert_dialog/custom_alert_dialog_theme.dart';
import '../custom_dialog/custom_dialog.dart';

class SingleButtonAlertDialog extends StatelessWidget {
  const SingleButtonAlertDialog({
    super.key,
    required this.title,
    this.subtitle,
    this.buttonText,
    this.icon,
  });

  final String title;
  final String? subtitle;
  final String? buttonText;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    final myTheme = CustomAlertDialogTheme.of(context);
    return CustomDialog(
      title: Text(title),
      icon: icon ?? Icon(Icons.info_outline),
      builder: (context) => Column(
        children: [
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
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: Text(buttonText ?? Loc.of(context).confirm),
          ),
        ],
      ),
    );
  }
}
