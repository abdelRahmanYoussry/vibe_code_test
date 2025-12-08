import 'package:flutter/material.dart';

class PointItemTheme extends ThemeExtension<PointItemTheme> {
  static PointItemTheme of(BuildContext context) => Theme.of(context).extension<PointItemTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle priceUpTextStyle;
  final TextStyle priceDownTextStyle;
  final TextStyle dateTextStyle;
  final TextStyle pointsTextStyle;

  const PointItemTheme({
    required this.titleTextStyle,
    required this.priceUpTextStyle,
    required this.priceDownTextStyle,
    required this.dateTextStyle,
    required this.pointsTextStyle,
  });

  @override
  ThemeExtension<PointItemTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? priceUpTextStyle,
    TextStyle? priceDownTextStyle,
    TextStyle? dateTextStyle,
    TextStyle? pointsTextStyle,
  }) =>
      PointItemTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        priceUpTextStyle: priceUpTextStyle ?? this.priceUpTextStyle,
        priceDownTextStyle: priceDownTextStyle ?? this.priceDownTextStyle,
        dateTextStyle: dateTextStyle ?? this.dateTextStyle,
        pointsTextStyle: pointsTextStyle ?? this.pointsTextStyle,
      );

  @override
  ThemeExtension<PointItemTheme> lerp(covariant ThemeExtension<PointItemTheme>? other, double t) {
    if (other is! PointItemTheme) {
      return this;
    }
    return PointItemTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      priceUpTextStyle: TextStyle.lerp(priceUpTextStyle, other.priceUpTextStyle, t)!,
      priceDownTextStyle: TextStyle.lerp(priceDownTextStyle, other.priceDownTextStyle, t)!,
      dateTextStyle: TextStyle.lerp(dateTextStyle, other.dateTextStyle, t)!,
      pointsTextStyle: TextStyle.lerp(pointsTextStyle, other.pointsTextStyle, t)!,
    );
  }
}
