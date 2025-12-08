import 'package:flutter/material.dart';

class SpinnerRewardTheme extends ThemeExtension<SpinnerRewardTheme> {
  static SpinnerRewardTheme of(BuildContext context) => Theme.of(context).extension<SpinnerRewardTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle labelTextStyle;
  final TextStyle rewardNameTextStyle;

  const SpinnerRewardTheme({
    required this.titleTextStyle,
    required this.labelTextStyle,
    required this.rewardNameTextStyle,
  });

  @override
  ThemeExtension<SpinnerRewardTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? labelTextStyle,
    TextStyle? rewardNameTextStyle,
  }) =>
      SpinnerRewardTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        rewardNameTextStyle: rewardNameTextStyle ?? this.rewardNameTextStyle,
      );

  @override
  ThemeExtension<SpinnerRewardTheme> lerp(covariant ThemeExtension<SpinnerRewardTheme>? other, double t) {
    if (other is! SpinnerRewardTheme) {
      return this;
    }
    return SpinnerRewardTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      rewardNameTextStyle: TextStyle.lerp(rewardNameTextStyle, other.rewardNameTextStyle, t)!,
    );
  }
}
