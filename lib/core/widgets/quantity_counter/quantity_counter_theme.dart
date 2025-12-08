import 'package:flutter/material.dart';

class QuantityCounterTheme extends ThemeExtension<QuantityCounterTheme> {
  static QuantityCounterTheme of(BuildContext context) => Theme.of(context).extension<QuantityCounterTheme>()!;

  final Size size;
  final TextStyle counterTextStyle;
  final IconThemeData counterIconStyle;
  final BoxDecoration counterDecorationStyle;

  const QuantityCounterTheme({
    required this.size,
    required this.counterTextStyle,
    required this.counterIconStyle,
    required this.counterDecorationStyle,
  });

  @override
  QuantityCounterTheme copyWith({
    Size? size,
    TextStyle? counterTextStyle,
    IconThemeData? counterIconStyle,
    BoxDecoration? counterDecorationStyle,
  }) =>
      QuantityCounterTheme(
        size: size ?? this.size,
        counterTextStyle: counterTextStyle ?? this.counterTextStyle,
        counterIconStyle: counterIconStyle ?? this.counterIconStyle,
        counterDecorationStyle: counterDecorationStyle ?? this.counterDecorationStyle,
      );

  @override
  QuantityCounterTheme lerp(covariant ThemeExtension<QuantityCounterTheme>? other, double t) {
    if (other is! QuantityCounterTheme) {
      return this;
    }
    return QuantityCounterTheme(
      size: Size.lerp(size, other.size, t)!,
      counterTextStyle: TextStyle.lerp(counterTextStyle, other.counterTextStyle, t)!,
      counterIconStyle: IconThemeData.lerp(counterIconStyle, other.counterIconStyle, t),
      counterDecorationStyle: BoxDecoration.lerp(counterDecorationStyle, other.counterDecorationStyle, t)!,
    );
  }
}
