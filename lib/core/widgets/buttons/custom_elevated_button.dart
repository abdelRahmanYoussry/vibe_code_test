import 'package:test_vibe/core/widgets/loading/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.loading = false,
    this.style,
    this.enabled = true,
  });

  final VoidCallback? onPressed;
  final bool loading;
  final Widget child;
  final ButtonStyle? style;
  final bool enabled;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeStyle = ElevatedButtonTheme.of(context).style;
    var adjustedStyle = themeStyle;
    if (loading) {
      adjustedStyle = themeStyle?.copyWith(
        backgroundColor: WidgetStatePropertyAll(
          themeStyle.backgroundColor?.resolve({
            if (onPressed == null) WidgetState.disabled,
          }),
        ),
      );
    }
    final mergedStyle = style?.merge(adjustedStyle) ?? adjustedStyle;
    return ElevatedButton(
      onPressed: (loading || !enabled) ? null : onPressed,
      style: mergedStyle,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: loading ? 0 : 1,
            child: child,
          ),
          // if (loading)
          //   CircularLoadingWidget(
          //     size: 20.sp,
          //     color: onPressed == null ? theme.colorScheme.primary : (themeStyle?.iconColor?.resolve({WidgetState.focused}) ?? theme.colorScheme.onPrimary),
          //   ),
          if (loading)
            CircularLoadingWidget(
              size: 20.sp,
              color: onPressed == null
                  ? theme.colorScheme.primary
                  : (themeStyle?.iconColor?.resolve({WidgetState.focused}) ??
                  theme.colorScheme.onPrimary),
            ),
        ],
      ),
    );
  }
}
