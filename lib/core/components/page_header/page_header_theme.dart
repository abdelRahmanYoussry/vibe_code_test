import 'package:flutter/material.dart';

class PageHeaderTheme extends ThemeExtension<PageHeaderTheme> {
  static PageHeaderTheme of(BuildContext context) => Theme.of(context).extension<PageHeaderTheme>()!;

  final TextStyle titleStyle;
  final TextStyle title2Style;
  final TextStyle subtitleStyle;
  final TextStyle subtitle2Style;

  const PageHeaderTheme({
    required this.titleStyle,
    required this.subtitleStyle,
    required this.subtitle2Style,
    required this.title2Style,
  });

  @override
  ThemeExtension<PageHeaderTheme> copyWith({
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    TextStyle? subtitle2Style,
    TextStyle? title2Style,
  }) =>
      PageHeaderTheme(
        titleStyle: titleStyle ?? this.titleStyle,
        subtitleStyle: subtitleStyle ?? this.subtitleStyle,
        subtitle2Style: subtitle2Style ?? this.subtitle2Style,
        title2Style: title2Style ?? this.title2Style,
      );

  @override
  ThemeExtension<PageHeaderTheme> lerp(covariant ThemeExtension<PageHeaderTheme>? other, double t) {
    if (other is! PageHeaderTheme) {
      return this;
    }
    return PageHeaderTheme(
      titleStyle: TextStyle.lerp(titleStyle, other.titleStyle, t)!,
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t)!,
      subtitle2Style: TextStyle.lerp(subtitle2Style, other.subtitle2Style, t)!,
      title2Style: TextStyle.lerp(title2Style, other.title2Style, t)!,
    );
  }
}
