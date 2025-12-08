import 'package:flutter/material.dart';

class SpinnerItemTheme extends ThemeExtension<SpinnerItemTheme> {
  static SpinnerItemTheme of(BuildContext context) => Theme.of(context).extension<SpinnerItemTheme>()!;

  final SpinnerItemThemeData available;
  final SpinnerItemThemeData unavailable;

  const SpinnerItemTheme({
    required this.available,
    required this.unavailable,
  });

  @override
  ThemeExtension<SpinnerItemTheme> copyWith({
    SpinnerItemThemeData? available,
    SpinnerItemThemeData? unavailable,
  }) =>
      SpinnerItemTheme(
        available: available ?? this.available,
        unavailable: unavailable ?? this.unavailable,
      );

  @override
  ThemeExtension<SpinnerItemTheme> lerp(covariant ThemeExtension<SpinnerItemTheme>? other, double t) {
    if (other is! SpinnerItemTheme) {
      return this;
    }
    return SpinnerItemTheme(
      available: available.lerp(other.available, t),
      unavailable: unavailable.lerp(other.unavailable, t),
    );
  }
}

class SpinnerItemThemeData {
  final BoxDecoration boxDecoration;
  final TextStyle labelTextStyle;
  final BoxDecoration labelBoxDecoration;
  final TextStyle titleTextStyle;
  final TextStyle descTextStyle;
  final ButtonStyle buttonStyle;
  final String image;

  const SpinnerItemThemeData({
    required this.boxDecoration,
    required this.labelTextStyle,
    required this.labelBoxDecoration,
    required this.titleTextStyle,
    required this.descTextStyle,
    required this.buttonStyle,
    required this.image,
  });

  SpinnerItemThemeData copyWith({
    BoxDecoration? boxDecoration,
    TextStyle? labelTextStyle,
    BoxDecoration? labelBoxDecoration,
    TextStyle? titleTextStyle,
    TextStyle? descTextStyle,
    ButtonStyle? buttonStyle,
    String? image,
  }) =>
      SpinnerItemThemeData(
        boxDecoration: boxDecoration ?? this.boxDecoration,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        labelBoxDecoration: labelBoxDecoration ?? this.labelBoxDecoration,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        descTextStyle: descTextStyle ?? this.descTextStyle,
        buttonStyle: buttonStyle ?? this.buttonStyle,
        image: image ?? this.image,
      );

  SpinnerItemThemeData lerp(covariant SpinnerItemThemeData? other, double t) {
    if (other is! SpinnerItemThemeData) {
      return this;
    }
    return SpinnerItemThemeData(
      boxDecoration: BoxDecoration.lerp(boxDecoration, other.boxDecoration, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      labelBoxDecoration: BoxDecoration.lerp(labelBoxDecoration, other.labelBoxDecoration, t)!,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      descTextStyle: TextStyle.lerp(descTextStyle, other.descTextStyle, t)!,
      buttonStyle: ButtonStyle.lerp(buttonStyle, other.buttonStyle, t)!,
      image: other.image,
    );
  }
}
