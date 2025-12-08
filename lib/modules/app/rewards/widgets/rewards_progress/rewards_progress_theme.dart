import 'package:flutter/material.dart';

class RewardsProgressTheme extends ThemeExtension<RewardsProgressTheme> {
  static RewardsProgressTheme of(BuildContext context) => Theme.of(context).extension<RewardsProgressTheme>()!;

  final BoxDecoration backgroundContainerDecoration;
  final ButtonStyle buttonStyle;

  const RewardsProgressTheme({
    required this.backgroundContainerDecoration,
  required  this.buttonStyle ,
  });

  @override
  ThemeExtension<RewardsProgressTheme> copyWith({
    BoxDecoration? backgroundContainerDecoration,
    ButtonStyle? buttonStyle,
  }) =>
      RewardsProgressTheme(
        backgroundContainerDecoration: backgroundContainerDecoration ?? this.backgroundContainerDecoration,
        buttonStyle: buttonStyle ?? this.buttonStyle,
      );

  @override
  ThemeExtension<RewardsProgressTheme> lerp(covariant ThemeExtension<RewardsProgressTheme>? other, double t) {
    if (other is! RewardsProgressTheme) {
      return this;
    }
    return RewardsProgressTheme(
      backgroundContainerDecoration: BoxDecoration.lerp(backgroundContainerDecoration, other.backgroundContainerDecoration, t)!,
      buttonStyle: ButtonStyle.lerp(buttonStyle, other.buttonStyle, t)!,
    );
  }
}
