import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/system_colors_widget.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'custom_dialog_theme.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    this.title,
    this.icon,
    required this.builder,
  });

  final Widget? title;
  final Widget? icon;
  final WidgetBuilder builder;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    final myTheme = CustomDialogTheme.of(context);
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(style: myTheme.elevatedButtonStyle.merge(theme.elevatedButtonTheme.style)),
        outlinedButtonTheme: OutlinedButtonThemeData(style: myTheme.outlinedButtonStyle.merge(theme.outlinedButtonTheme.style)),
      ),
      child: SystemColorsWidget(
        child: Dialog(
          child: Padding(
            padding: SpacingTheme.of(context).dialogPagePadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.title != null || widget.icon != null) ...[
                  SizedBox(height: 24.h),
                  Row(
                    spacing: 8.w,
                    children: [
                      if (widget.icon != null)
                        IconTheme(
                          data: myTheme.iconThemeData,
                          child: widget.icon!,
                        ),
                      if (widget.title != null)
                        DefaultTextStyle(
                          style: myTheme.titleTextStyle,
                          child: widget.title!,
                        ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Divider(),
                  SizedBox(height: 24.h),
                ],
                widget.builder(context),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
