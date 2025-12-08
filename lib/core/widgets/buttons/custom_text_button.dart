import 'package:test_vibe/core/widgets/loading/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.loading = false,
    this.style,
  });

  final VoidCallback? onPressed;
  final bool loading;
  final Widget child;
  final ButtonStyle? style;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeStyle = TextButtonTheme.of(context).style;
    var adjustedStyle = themeStyle;
    final mergedStyle = style?.merge(adjustedStyle) ?? adjustedStyle;
    return TextButton(
      onPressed: loading ? null : onPressed,
      style: mergedStyle,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: loading ? 0 : 1,
            child: child,
          ),
          if (loading)
            CircularLoadingWidget(
              size: 20.sp,
              color: onPressed == null ? theme.colorScheme.primary : theme.colorScheme.primary,
            ),
        ],
      ),
    );
  }
}
