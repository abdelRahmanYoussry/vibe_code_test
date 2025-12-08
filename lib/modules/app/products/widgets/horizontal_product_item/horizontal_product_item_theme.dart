import 'package:flutter/material.dart';

class HorizontalProductItemTheme extends ThemeExtension<HorizontalProductItemTheme> {
  static HorizontalProductItemTheme of(BuildContext context) => Theme.of(context).extension<HorizontalProductItemTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final TextStyle priceTextStyle;

  const HorizontalProductItemTheme({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.priceTextStyle,
  });

  @override
  ThemeExtension<HorizontalProductItemTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    TextStyle? priceTextStyle,
  }) =>
      HorizontalProductItemTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        priceTextStyle: priceTextStyle ?? this.priceTextStyle,
      );

  @override
  ThemeExtension<HorizontalProductItemTheme> lerp(covariant ThemeExtension<HorizontalProductItemTheme>? other, double t) {
    if (other is! HorizontalProductItemTheme) {
      return this;
    }
    return HorizontalProductItemTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subtitleTextStyle: TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t)!,
      priceTextStyle: TextStyle.lerp(priceTextStyle, other.priceTextStyle, t)!,
    );
  }
}
