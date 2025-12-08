import 'package:flutter/material.dart';

class RewardItemTheme extends ThemeExtension<RewardItemTheme> {
  static RewardItemTheme of(BuildContext context) => Theme.of(context).extension<RewardItemTheme>()!;

  final TextStyle labelStyle;
  final BoxDecoration iconContainerDecoration;
  final IconThemeData iconThemeData;

  const RewardItemTheme({
    required this.labelStyle,
    required this.iconContainerDecoration,
    required this.iconThemeData,
  });

  @override
  ThemeExtension<RewardItemTheme> copyWith({
    TextStyle? labelStyle,
    BoxDecoration? iconContainerDecoration,
    IconThemeData? iconThemeData,
  }) =>
      RewardItemTheme(
        labelStyle: labelStyle ?? this.labelStyle,
        iconContainerDecoration: iconContainerDecoration ?? this.iconContainerDecoration,
        iconThemeData: iconThemeData ?? this.iconThemeData,
      );

  @override
  ThemeExtension<RewardItemTheme> lerp(covariant ThemeExtension<RewardItemTheme>? other, double t) {
    if (other is! RewardItemTheme) {
      return this;
    }
    return RewardItemTheme(
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      iconContainerDecoration: BoxDecoration.lerp(iconContainerDecoration, other.iconContainerDecoration, t)!,
      iconThemeData: IconThemeData.lerp(iconThemeData, other.iconThemeData, t),
    );
  }
}
