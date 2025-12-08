import 'package:flutter/material.dart';

class HomeAppbarActionsTheme extends ThemeExtension<HomeAppbarActionsTheme> {
  static HomeAppbarActionsTheme of(BuildContext context) => Theme.of(context).extension<HomeAppbarActionsTheme>()!;

  final Color backgroundColor;
  final Color foregroundColor;

  const HomeAppbarActionsTheme({
    required this.backgroundColor,
    required this.foregroundColor,
  });

  @override
  ThemeExtension<HomeAppbarActionsTheme> copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
  }) =>
      HomeAppbarActionsTheme(
        backgroundColor: backgroundColor ?? this.backgroundColor,
        foregroundColor: foregroundColor ?? this.foregroundColor,
      );

  @override
  ThemeExtension<HomeAppbarActionsTheme> lerp(covariant ThemeExtension<HomeAppbarActionsTheme>? other, double t) {
    if (other is! HomeAppbarActionsTheme) {
      return this;
    }
    return HomeAppbarActionsTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
    );
  }
}
