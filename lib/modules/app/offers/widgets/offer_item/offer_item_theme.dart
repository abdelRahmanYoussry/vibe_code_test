import 'package:flutter/material.dart';

class OfferItemTheme extends ThemeExtension<OfferItemTheme> {
  static OfferItemTheme of(BuildContext context) => Theme.of(context).extension<OfferItemTheme>()!;

  final BoxDecoration backgroundDecoration;
  final TextStyle labelTextStyle;
  final BoxDecoration labelDecoration;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final ButtonStyle buttonStyle;

  const OfferItemTheme({
    required this.backgroundDecoration,
    required this.labelTextStyle,
    required this.labelDecoration,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.buttonStyle,
  });

  @override
  ThemeExtension<OfferItemTheme> copyWith({
    BoxDecoration? backgroundDecoration,
    TextStyle? labelTextStyle,
    BoxDecoration? labelDecoration,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    ButtonStyle? buttonStyle,
  }) =>
      OfferItemTheme(
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        labelDecoration: labelDecoration ?? this.labelDecoration,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        buttonStyle: buttonStyle ?? this.buttonStyle,
      );

  @override
  ThemeExtension<OfferItemTheme> lerp(covariant ThemeExtension<OfferItemTheme>? other, double t) {
    if (other is! OfferItemTheme) {
      return this;
    }
    return OfferItemTheme(
      backgroundDecoration: BoxDecoration.lerp(backgroundDecoration, other.backgroundDecoration, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      labelDecoration: BoxDecoration.lerp(labelDecoration, other.labelDecoration, t)!,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subtitleTextStyle: TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t)!,
      buttonStyle: ButtonStyle.lerp(buttonStyle, other.buttonStyle, t)!,
    );
  }
}
