import 'package:flutter/material.dart';

class TotalPointsOverviewTheme extends ThemeExtension<TotalPointsOverviewTheme> {
  static TotalPointsOverviewTheme of(BuildContext context) => Theme.of(context).extension<TotalPointsOverviewTheme>()!;

  final BoxDecoration backgroundDecoration;
  final IconThemeData iconStyle;
  final TextStyle titleTextStyle;
  final TextStyle pointsTextStyle;
  final TextStyle descTextStyle;
  final TextStyle priceTextStyle;

  const TotalPointsOverviewTheme({
    required this.backgroundDecoration,
    required this.iconStyle,
    required this.titleTextStyle,
    required this.pointsTextStyle,
    required this.descTextStyle,
    required this.priceTextStyle,
  });

  @override
  ThemeExtension<TotalPointsOverviewTheme> copyWith({
    BoxDecoration? backgroundDecoration,
    IconThemeData? iconStyle,
    TextStyle? titleTextStyle,
    TextStyle? pointsTextStyle,
    TextStyle? descTextStyle,
    TextStyle? priceTextStyle,
  }) =>
      TotalPointsOverviewTheme(
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        iconStyle: iconStyle ?? this.iconStyle,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        pointsTextStyle: pointsTextStyle ?? this.pointsTextStyle,
        descTextStyle: descTextStyle ?? this.descTextStyle,
        priceTextStyle: priceTextStyle ?? this.priceTextStyle,
      );

  @override
  ThemeExtension<TotalPointsOverviewTheme> lerp(covariant ThemeExtension<TotalPointsOverviewTheme>? other, double t) {
    if (other is! TotalPointsOverviewTheme) {
      return this;
    }
    return TotalPointsOverviewTheme(
      backgroundDecoration: BoxDecoration.lerp(backgroundDecoration, other.backgroundDecoration, t)!,
      iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      pointsTextStyle: TextStyle.lerp(pointsTextStyle, other.pointsTextStyle, t)!,
      descTextStyle: TextStyle.lerp(descTextStyle, other.descTextStyle, t)!,
      priceTextStyle: TextStyle.lerp(priceTextStyle, other.priceTextStyle, t)!,
    );
  }
}
