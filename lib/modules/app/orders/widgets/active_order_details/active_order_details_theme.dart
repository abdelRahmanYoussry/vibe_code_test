import 'package:flutter/material.dart';

class ActiveOrderDetailsTheme extends ThemeExtension<ActiveOrderDetailsTheme> {
  static ActiveOrderDetailsTheme of(BuildContext context) => Theme.of(context).extension<ActiveOrderDetailsTheme>()!;

  final BoxDecoration backgroundDecoration;
  final TextStyle timeTextStyle;
  final TextStyle timeHintTextStyle;
  final TextStyle delayHintTextStyle;
  final ButtonStyle activeDelayButtonStyle;
  final ButtonStyle unActiveDelayButtonStyle;
  final TextStyle selectTimeTextStyle;
  final IconThemeData selectTimeIconStyle;

  const ActiveOrderDetailsTheme({
    required this.backgroundDecoration,
    required this.timeTextStyle,
    required this.timeHintTextStyle,
    required this.delayHintTextStyle,
    required this.activeDelayButtonStyle,
    required this.selectTimeTextStyle,
    required this.selectTimeIconStyle,
    required this.unActiveDelayButtonStyle,
  });

  @override
  ThemeExtension<ActiveOrderDetailsTheme> copyWith({
    BoxDecoration? backgroundDecoration,
    TextStyle? timeTextStyle,
    TextStyle? timeHintTextStyle,
    TextStyle? timeLabelTextStyle,
    TextStyle? distanceLabelTextStyle,
    TextStyle? readyLabelTextStyle,
    TextStyle? delayHintTextStyle,
    ButtonStyle? activeDelayButtonStyle,
    ButtonStyle? unActiveDelayButtonStyle,
    TextStyle? selectTimeTextStyle,
    IconThemeData? selectTimeIconStyle,
  }) =>
      ActiveOrderDetailsTheme(
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        timeTextStyle: timeTextStyle ?? this.timeTextStyle,
        timeHintTextStyle: timeHintTextStyle ?? this.timeHintTextStyle,
        delayHintTextStyle: delayHintTextStyle ?? this.delayHintTextStyle,
        activeDelayButtonStyle: activeDelayButtonStyle ?? this.activeDelayButtonStyle,
        unActiveDelayButtonStyle: unActiveDelayButtonStyle ?? this.unActiveDelayButtonStyle,
        selectTimeTextStyle: selectTimeTextStyle ?? this.selectTimeTextStyle,
        selectTimeIconStyle: selectTimeIconStyle ?? this.selectTimeIconStyle,
      );

  @override
  ThemeExtension<ActiveOrderDetailsTheme> lerp(covariant ThemeExtension<ActiveOrderDetailsTheme>? other, double t) {
    if (other is! ActiveOrderDetailsTheme) {
      return this;
    }
    return ActiveOrderDetailsTheme(
      backgroundDecoration: BoxDecoration.lerp(backgroundDecoration, other.backgroundDecoration, t)!,
      timeTextStyle: TextStyle.lerp(timeTextStyle, other.timeTextStyle, t)!,
      timeHintTextStyle: TextStyle.lerp(timeHintTextStyle, other.timeHintTextStyle, t)!,
      delayHintTextStyle: TextStyle.lerp(delayHintTextStyle, other.delayHintTextStyle, t)!,
      activeDelayButtonStyle: ButtonStyle.lerp(activeDelayButtonStyle, other.activeDelayButtonStyle, t)!,
      selectTimeTextStyle: TextStyle.lerp(selectTimeTextStyle, other.selectTimeTextStyle, t)!,
      selectTimeIconStyle: IconThemeData.lerp(selectTimeIconStyle, other.selectTimeIconStyle, t),
      unActiveDelayButtonStyle: ButtonStyle.lerp(unActiveDelayButtonStyle, other.unActiveDelayButtonStyle, t)!,
    );
  }
}
