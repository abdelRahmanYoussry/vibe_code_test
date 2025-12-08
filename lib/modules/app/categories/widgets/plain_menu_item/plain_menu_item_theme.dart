import 'package:flutter/material.dart';

class PlainMenuItemTheme extends ThemeExtension<PlainMenuItemTheme> {
  static PlainMenuItemTheme of(BuildContext context) => Theme.of(context).extension<PlainMenuItemTheme>()!;

  final TextStyle titleTextStyle;
  final BorderSide borderSide;
  final BorderRadius borderRadius;

  const PlainMenuItemTheme({
    required this.titleTextStyle,
    required this.borderSide,
    required this.borderRadius,
  });

  @override
  ThemeExtension<PlainMenuItemTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? priceTextStyle,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
  }) =>
      PlainMenuItemTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        borderSide: borderSide ?? this.borderSide,
        borderRadius: borderRadius ?? this.borderRadius,
      );

  @override
  ThemeExtension<PlainMenuItemTheme> lerp(covariant ThemeExtension<PlainMenuItemTheme>? other, double t) {
    if (other is! PlainMenuItemTheme) {
      return this;
    }
    return PlainMenuItemTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      borderSide: BorderSide.lerp(borderSide, other.borderSide, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
    );
  }
}
