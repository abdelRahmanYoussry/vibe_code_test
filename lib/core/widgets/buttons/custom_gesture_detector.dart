import 'package:test_vibe/core/widgets/loading/circular_loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class CustomGestureDetector extends StatelessWidget {
  const CustomGestureDetector({
    super.key,
    required this.child,
    required this.onPressed,
    this.loading = false,
    this.padding,
    this.behavior = HitTestBehavior.opaque,
  });

  final VoidCallback? onPressed;
  final bool loading;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final HitTestBehavior behavior ;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: loading ? null : onPressed,
      behavior: behavior ,
      child: Padding(
        padding: padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
      ),
    );
  }
}
