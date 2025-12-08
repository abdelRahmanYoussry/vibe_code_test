import 'package:flutter/material.dart';

class ProductInfoWidgetTheme extends ThemeExtension<ProductInfoWidgetTheme> {
  static ProductInfoWidgetTheme of(BuildContext context) => Theme.of(context).extension<ProductInfoWidgetTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle bodyTextStyle;

  const ProductInfoWidgetTheme({
    required this.titleTextStyle,
    required this.bodyTextStyle,
  });

  @override
  ThemeExtension<ProductInfoWidgetTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? bodyTextStyle,
  }) =>
      ProductInfoWidgetTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
      );

  @override
  ThemeExtension<ProductInfoWidgetTheme> lerp(covariant ThemeExtension<ProductInfoWidgetTheme>? other, double t) {
    if (other is! ProductInfoWidgetTheme) {
      return this;
    }
    return ProductInfoWidgetTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      bodyTextStyle: TextStyle.lerp(bodyTextStyle, other.bodyTextStyle, t)!,
    );
  }
}
