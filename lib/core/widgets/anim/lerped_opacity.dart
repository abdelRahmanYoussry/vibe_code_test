import 'package:flutter/material.dart';

class LerpedOpacity extends StatelessWidget {
  const LerpedOpacity({
    super.key,
    required this.child,
    required this.opacity,
  });

  final Widget child;
  final double? opacity;

  @override
  Widget build(BuildContext context) {
    final opacity = this.opacity ?? 0.0;
    final ignore = opacity < 0.1;
    return ExcludeFocus(
      excluding: ignore,
      child: IgnorePointer(
        ignoring: ignore,
        child: Opacity(
          opacity: opacity.clamp(0, 1),
          child: child,
        ),
      ),
    );
  }
}
