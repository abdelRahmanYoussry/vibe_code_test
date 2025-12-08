import 'package:flutter/material.dart';

class CustomAlertDialogTheme extends ThemeExtension<CustomAlertDialogTheme> {
  static CustomAlertDialogTheme of(BuildContext context) => Theme.of(context).extension<CustomAlertDialogTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

  const CustomAlertDialogTheme({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
  });

  @override
  ThemeExtension<CustomAlertDialogTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) =>
      CustomAlertDialogTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      );

  @override
  ThemeExtension<CustomAlertDialogTheme> lerp(covariant ThemeExtension<CustomAlertDialogTheme>? other, double t) {
    if (other is! CustomAlertDialogTheme) {
      return this;
    }
    return CustomAlertDialogTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subtitleTextStyle: TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t)!,
    );
  }
}
