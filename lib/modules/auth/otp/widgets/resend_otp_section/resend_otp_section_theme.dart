import 'package:flutter/material.dart';

class ResendOtpSectionTheme extends ThemeExtension<ResendOtpSectionTheme> {
  static ResendOtpSectionTheme of(BuildContext context) => Theme.of(context).extension<ResendOtpSectionTheme>()!;

  final TextStyle textStyle;

  const ResendOtpSectionTheme({
    required this.textStyle,
  });

  @override
  ThemeExtension<ResendOtpSectionTheme> copyWith({
    TextStyle? textStyle,
  }) =>
      ResendOtpSectionTheme(
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  ThemeExtension<ResendOtpSectionTheme> lerp(covariant ThemeExtension<ResendOtpSectionTheme>? other, double t) {
    if (other is! ResendOtpSectionTheme) {
      return this;
    }
    return ResendOtpSectionTheme(
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
