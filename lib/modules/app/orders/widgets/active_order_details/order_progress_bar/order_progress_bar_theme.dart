import 'package:flutter/material.dart';

class OrderProgressBarTheme extends ThemeExtension<OrderProgressBarTheme> {
  static OrderProgressBarTheme of(BuildContext context) => Theme.of(context).extension<OrderProgressBarTheme>()!;

  final IconThemeData checkIconStyle;
  final BoxDecoration checkBackgroundDecoration;
  final BoxDecoration distanceBackgroundDecoration;
  final TextStyle readyTextStyle;
  final BoxDecoration readyBackgroundDecoration;
  final TextStyle distanceLabelTextStyle;
  final TextStyle timeLabelTextStyle;
  final Color progressDashColor;

  const OrderProgressBarTheme({
    required this.checkIconStyle,
    required this.checkBackgroundDecoration,
    required this.distanceBackgroundDecoration,
    required this.readyTextStyle,
    required this.readyBackgroundDecoration,
    required this.distanceLabelTextStyle,
    required this.timeLabelTextStyle,
    required this.progressDashColor,
  });

  @override
  ThemeExtension<OrderProgressBarTheme> copyWith({
    IconThemeData? checkIconStyle,
    BoxDecoration? checkBackgroundDecoration,
    BoxDecoration? distanceBackgroundDecoration,
    TextStyle? readyTextStyle,
    BoxDecoration? readyBackgroundDecoration,
    TextStyle? distanceLabelTextStyle,
    TextStyle? timeLabelTextStyle,
    Color? progressDashColor,
  }) =>
      OrderProgressBarTheme(
        checkIconStyle: checkIconStyle ?? this.checkIconStyle,
        checkBackgroundDecoration: checkBackgroundDecoration ?? this.checkBackgroundDecoration,
        distanceBackgroundDecoration: distanceBackgroundDecoration ?? this.distanceBackgroundDecoration,
        readyTextStyle: readyTextStyle ?? this.readyTextStyle,
        readyBackgroundDecoration: readyBackgroundDecoration ?? this.readyBackgroundDecoration,
        distanceLabelTextStyle: distanceLabelTextStyle ?? this.distanceLabelTextStyle,
        timeLabelTextStyle: timeLabelTextStyle ?? this.timeLabelTextStyle,
        progressDashColor: progressDashColor ?? this.progressDashColor,
      );

  @override
  ThemeExtension<OrderProgressBarTheme> lerp(covariant ThemeExtension<OrderProgressBarTheme>? other, double t) {
    if (other is! OrderProgressBarTheme) {
      return this;
    }
    return OrderProgressBarTheme(
      checkIconStyle: IconThemeData.lerp(checkIconStyle, other.checkIconStyle, t),
      checkBackgroundDecoration: BoxDecoration.lerp(checkBackgroundDecoration, other.checkBackgroundDecoration, t)!,
      distanceBackgroundDecoration: BoxDecoration.lerp(distanceBackgroundDecoration, other.distanceBackgroundDecoration, t)!,
      readyTextStyle: TextStyle.lerp(readyTextStyle, other.readyTextStyle, t)!,
      readyBackgroundDecoration: BoxDecoration.lerp(readyBackgroundDecoration, other.readyBackgroundDecoration, t)!,
      distanceLabelTextStyle: TextStyle.lerp(distanceLabelTextStyle, other.distanceLabelTextStyle, t)!,
      timeLabelTextStyle: TextStyle.lerp(timeLabelTextStyle, other.timeLabelTextStyle, t)!,
      progressDashColor: Color.lerp(progressDashColor, other.progressDashColor, t)!,
    );
  }
}
