import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/buttons/custom_gesture_detector.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'custom_container_button_theme.dart';

class CustomContainerButton extends StatelessWidget {
  const CustomContainerButton({
    super.key,
    required this.onPressed,
    this.label,
    this.icon,
  });

  final VoidCallback? onPressed;
  final String? label;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    final customContainerButtonTheme = CustomContainerButtonTheme.of(context);
    return CustomGestureDetector(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Container(
        decoration: customContainerButtonTheme.containerDecoration,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          spacing: 7.w,
          children: [
            if (validString(icon))
              Pic(
                icon!,
                size: customContainerButtonTheme.iconThemeData.size,
                color: customContainerButtonTheme.iconThemeData.color,
              ),
            if (validString(label))
              Text(
                label!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: customContainerButtonTheme.labelStyle,
              ),
          ],
        ),
      ),
    );
  }
}
