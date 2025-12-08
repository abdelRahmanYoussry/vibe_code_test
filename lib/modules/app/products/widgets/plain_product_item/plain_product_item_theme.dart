import 'package:flutter/material.dart';

class PlainProductItemTheme extends ThemeExtension<PlainProductItemTheme> {
  static PlainProductItemTheme of(BuildContext context) => Theme.of(context).extension<PlainProductItemTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle priceTextStyle;
  final BorderSide borderSide;
  final BorderRadius borderRadius;

  const PlainProductItemTheme({
    required this.titleTextStyle,
    required this.priceTextStyle,
    required this.borderSide,
    required this.borderRadius,
  });

  @override
  ThemeExtension<PlainProductItemTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? priceTextStyle,
    BorderSide? borderSide,
    BorderRadius? borderRadius,
  }) =>
      PlainProductItemTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        priceTextStyle: priceTextStyle ?? this.priceTextStyle,
        borderSide: borderSide ?? this.borderSide,
        borderRadius: borderRadius ?? this.borderRadius,
      );

  @override
  ThemeExtension<PlainProductItemTheme> lerp(covariant ThemeExtension<PlainProductItemTheme>? other, double t) {
    if (other is! PlainProductItemTheme) {
      return this;
    }
    return PlainProductItemTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      priceTextStyle: TextStyle.lerp(priceTextStyle, other.priceTextStyle, t)!,
      borderSide: BorderSide.lerp(borderSide, other.borderSide, t),
      borderRadius: BorderRadius.lerp(borderRadius, other.borderRadius, t)!,
    );
  }
}
