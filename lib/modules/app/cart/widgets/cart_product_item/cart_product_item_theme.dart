import 'package:flutter/material.dart';

class CartProductItemTheme extends ThemeExtension<CartProductItemTheme> {
  static CartProductItemTheme of(BuildContext context) => Theme.of(context).extension<CartProductItemTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle bodyTextStyle;
  final TextStyle priceTextStyle;
  final ButtonStyle deleteButtonStyle;
  final BoxDecoration backgroundDecoration;

  const CartProductItemTheme({
    required this.titleTextStyle,
    required this.bodyTextStyle,
    required this.priceTextStyle,
    required this.deleteButtonStyle,
    required this.backgroundDecoration,
  });

  @override
  ThemeExtension<CartProductItemTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? bodyTextStyle,
    TextStyle? priceTextStyle,
    ButtonStyle? deleteButtonStyle,
    BoxDecoration? backgroundDecoration,
  }) =>
      CartProductItemTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
        priceTextStyle: priceTextStyle ?? this.priceTextStyle,
        deleteButtonStyle: deleteButtonStyle ?? this.deleteButtonStyle,
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
      );

  @override
  ThemeExtension<CartProductItemTheme> lerp(covariant ThemeExtension<CartProductItemTheme>? other, double t) {
    if (other is! CartProductItemTheme) {
      return this;
    }
    return CartProductItemTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      bodyTextStyle: TextStyle.lerp(bodyTextStyle, other.bodyTextStyle, t)!,
      priceTextStyle: TextStyle.lerp(priceTextStyle, other.priceTextStyle, t)!,
      deleteButtonStyle: ButtonStyle.lerp(deleteButtonStyle, other.deleteButtonStyle, t)!,
      backgroundDecoration: BoxDecoration.lerp(backgroundDecoration, other.backgroundDecoration, t)!,
    );
  }
}
