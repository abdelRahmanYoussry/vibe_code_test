import 'package:flutter/material.dart';

class CustomDialogTheme extends ThemeExtension<CustomDialogTheme> {
  static CustomDialogTheme of(BuildContext context) => Theme.of(context).extension<CustomDialogTheme>()!;

  final TextStyle titleTextStyle;
  final IconThemeData iconThemeData;
  final ButtonStyle outlinedButtonStyle;
  final ButtonStyle elevatedButtonStyle;

  const CustomDialogTheme({
    required this.titleTextStyle,
    required this.iconThemeData,
    required this.outlinedButtonStyle,
    required this.elevatedButtonStyle,
  });

  @override
  ThemeExtension<CustomDialogTheme> copyWith({
    TextStyle? titleTextStyle,
    IconThemeData? iconThemeData,
    ButtonStyle? outlinedButtonStyle,
    ButtonStyle? elevatedButtonStyle,
  }) =>
      CustomDialogTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        iconThemeData: iconThemeData ?? this.iconThemeData,
        outlinedButtonStyle: outlinedButtonStyle ?? this.outlinedButtonStyle,
        elevatedButtonStyle: elevatedButtonStyle ?? this.elevatedButtonStyle,
      );

  @override
  ThemeExtension<CustomDialogTheme> lerp(covariant ThemeExtension<CustomDialogTheme>? other, double t) {
    if (other is! CustomDialogTheme) {
      return this;
    }
    return CustomDialogTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      iconThemeData: IconThemeData.lerp(iconThemeData, other.iconThemeData, t),
      outlinedButtonStyle: ButtonStyle.lerp(outlinedButtonStyle, other.outlinedButtonStyle, t)!,
      elevatedButtonStyle: ButtonStyle.lerp(elevatedButtonStyle, other.elevatedButtonStyle, t)!,
    );
  }
}
