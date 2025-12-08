import 'package:flutter/material.dart';

class ProductItemWithAddButtonTheme extends ThemeExtension<ProductItemWithAddButtonTheme> {
  static ProductItemWithAddButtonTheme of(BuildContext context) => Theme.of(context).extension<ProductItemWithAddButtonTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final TextStyle priceTextStyle;

  const ProductItemWithAddButtonTheme({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.priceTextStyle,
  });

  @override
  ThemeExtension<ProductItemWithAddButtonTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    TextStyle? priceTextStyle,
  }) =>
      ProductItemWithAddButtonTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        priceTextStyle: priceTextStyle ?? this.priceTextStyle,
      );

  @override
  ThemeExtension<ProductItemWithAddButtonTheme> lerp(covariant ThemeExtension<ProductItemWithAddButtonTheme>? other, double t) {
    if (other is! ProductItemWithAddButtonTheme) {
      return this;
    }
    return ProductItemWithAddButtonTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subtitleTextStyle: TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t)!,
      priceTextStyle: TextStyle.lerp(priceTextStyle, other.priceTextStyle, t)!,
    );
  }
}
