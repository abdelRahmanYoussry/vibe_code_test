import 'package:flutter/material.dart';

class CustomContainerButtonTheme extends ThemeExtension<CustomContainerButtonTheme> {
  static CustomContainerButtonTheme of(BuildContext context) => Theme.of(context).extension<CustomContainerButtonTheme>()!;

  final TextStyle labelStyle;
  final IconThemeData iconThemeData;
  final BoxDecoration containerDecoration;

  const CustomContainerButtonTheme({
    required this.labelStyle,
    required this.iconThemeData,
    required this.containerDecoration,
  });

  @override
  ThemeExtension<CustomContainerButtonTheme> copyWith({
    TextStyle? labelStyle,
    IconThemeData? iconThemeData,
    BoxDecoration? containerDecoration,
  }) =>
      CustomContainerButtonTheme(
        labelStyle: labelStyle ?? this.labelStyle,
        iconThemeData: iconThemeData ?? this.iconThemeData,
        containerDecoration: containerDecoration ?? this.containerDecoration,
      );

  @override
  ThemeExtension<CustomContainerButtonTheme> lerp(covariant ThemeExtension<CustomContainerButtonTheme>? other, double t) {
    if (other is! CustomContainerButtonTheme) {
      return this;
    }
    return CustomContainerButtonTheme(
      labelStyle: other.labelStyle,
      iconThemeData: other.iconThemeData,
      containerDecoration: other.containerDecoration,
    );
  }
}
