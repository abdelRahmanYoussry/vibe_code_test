import 'package:flutter/material.dart';

class SpinnerTheme extends ThemeExtension<SpinnerTheme> {
  static SpinnerTheme of(BuildContext context) => Theme.of(context).extension<SpinnerTheme>()!;

  final TextStyle labelTextStyle;
  final List<Color> colors;
  final Color outerBorderColor;
  final Color outerBorderCirclesColor;
  final Color innerBorderColor;
  final Color innerBorderCircleColor;
  final Color arrowOuterBorderColor;
  final Color arrowInnerBorderColor;
  final Color textColorLight;
  final Color textColorDark;

  const SpinnerTheme({
    required this.labelTextStyle,
    required this.colors,
    required this.outerBorderColor,
    required this.outerBorderCirclesColor,
    required this.innerBorderColor,
    required this.innerBorderCircleColor,
    required this.arrowOuterBorderColor,
    required this.arrowInnerBorderColor,
    required this.textColorLight,
    required this.textColorDark,
  });

  @override
  ThemeExtension<SpinnerTheme> copyWith({
    TextStyle? labelTextStyle,
    List<Color>? colors,
    Color? outerBorderColor,
    Color? outerBorderCirclesColor,
    Color? innerBorderColor,
    Color? innerBorderCircleColor,
    Color? arrowOuterBorderColor,
    Color? arrowInnerBorderColor,
    Color? textColorLight,
    Color? textColorDark,
  }) =>
      SpinnerTheme(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        colors: colors ?? this.colors,
        outerBorderColor: outerBorderColor ?? this.outerBorderColor,
        outerBorderCirclesColor: outerBorderCirclesColor ?? this.outerBorderCirclesColor,
        innerBorderColor: innerBorderColor ?? this.innerBorderColor,
        innerBorderCircleColor: innerBorderCircleColor ?? this.innerBorderCircleColor,
        arrowOuterBorderColor: arrowOuterBorderColor ?? this.arrowOuterBorderColor,
        arrowInnerBorderColor: arrowInnerBorderColor ?? this.arrowInnerBorderColor,
        textColorLight: textColorLight ?? this.textColorLight,
        textColorDark: textColorDark ?? this.textColorDark,
      );

  @override
  ThemeExtension<SpinnerTheme> lerp(covariant ThemeExtension<SpinnerTheme>? other, double t) {
    if (other is! SpinnerTheme) {
      return this;
    }
    return SpinnerTheme(
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      colors: other.colors,
      outerBorderColor: other.outerBorderColor,
      outerBorderCirclesColor: other.outerBorderCirclesColor,
      innerBorderColor: other.innerBorderColor,
      innerBorderCircleColor: other.innerBorderCircleColor,
      arrowOuterBorderColor: other.arrowOuterBorderColor,
      arrowInnerBorderColor: other.arrowInnerBorderColor,
      textColorLight: other.textColorLight,
      textColorDark: other.textColorDark,
    );
  }
}
