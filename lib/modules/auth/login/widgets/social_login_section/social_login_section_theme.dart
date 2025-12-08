import 'package:flutter/material.dart';

class SocialLoginSectionTheme extends ThemeExtension<SocialLoginSectionTheme> {
  static SocialLoginSectionTheme of(BuildContext context) => Theme.of(context).extension<SocialLoginSectionTheme>()!;

  final TextStyle? headerStyle;
  final TextStyle? registerLabelStyle;
  final ButtonStyle? registerButtonStyle;

  const SocialLoginSectionTheme({
    required this.headerStyle,
    required this.registerLabelStyle,
    required this.registerButtonStyle,
  });

  @override
  ThemeExtension<SocialLoginSectionTheme> copyWith({
    TextStyle? headerStyle,
    TextStyle? registerLabelStyle,
    ButtonStyle? registerButtonStyle,
  }) =>
      SocialLoginSectionTheme(
        headerStyle: headerStyle ?? this.headerStyle,
        registerLabelStyle: registerLabelStyle ?? this.registerLabelStyle,
        registerButtonStyle: registerButtonStyle ?? this.registerButtonStyle,
      );

  @override
  ThemeExtension<SocialLoginSectionTheme> lerp(covariant ThemeExtension<SocialLoginSectionTheme>? other, double t) {
    if (other is! SocialLoginSectionTheme) {
      return this;
    }
    return SocialLoginSectionTheme(
      headerStyle: TextStyle.lerp(headerStyle, other.headerStyle, t)!,
      registerLabelStyle: TextStyle.lerp(registerLabelStyle, other.registerLabelStyle, t)!,
      registerButtonStyle: ButtonStyle.lerp(registerButtonStyle, other.registerButtonStyle, t)!,
    );
  }
}
