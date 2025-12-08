import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class FieldLabel extends StatelessWidget {
  const FieldLabel({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: Theme.of(context).inputDecorationTheme.labelStyle,
        ),
        SizedBox(height: 8.h),
        child,
      ],
    );
  }
}
