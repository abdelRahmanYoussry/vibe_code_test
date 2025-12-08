import 'package:flutter/material.dart';

class CustomSheetTheme extends ThemeExtension<CustomSheetTheme> {
  static CustomSheetTheme of(BuildContext context) => Theme.of(context).extension<CustomSheetTheme>()!;

  final TextStyle titleTextStyle;
  final IconThemeData iconThemeData;
  final ButtonStyle outlinedButtonStyle;
  final ButtonStyle elevatedButtonStyle;

  const CustomSheetTheme({
    required this.titleTextStyle,
    required this.iconThemeData,
    required this.outlinedButtonStyle,
    required this.elevatedButtonStyle,
  });

  @override
  ThemeExtension<CustomSheetTheme> copyWith({
    TextStyle? titleTextStyle,
    IconThemeData? iconThemeData,
    ButtonStyle? outlinedButtonStyle,
    ButtonStyle? elevatedButtonStyle,
  }) =>
      CustomSheetTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        iconThemeData: iconThemeData ?? this.iconThemeData,
        outlinedButtonStyle: outlinedButtonStyle ?? this.outlinedButtonStyle,
        elevatedButtonStyle: elevatedButtonStyle ?? this.elevatedButtonStyle,
      );

  @override
  ThemeExtension<CustomSheetTheme> lerp(covariant ThemeExtension<CustomSheetTheme>? other, double t) {
    if (other is! CustomSheetTheme) {
      return this;
    }
    return CustomSheetTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      iconThemeData: IconThemeData.lerp(iconThemeData, other.iconThemeData, t),
      outlinedButtonStyle: ButtonStyle.lerp(outlinedButtonStyle, other.outlinedButtonStyle, t)!,
      elevatedButtonStyle: ButtonStyle.lerp(elevatedButtonStyle, other.elevatedButtonStyle, t)!,
    );
  }
}
