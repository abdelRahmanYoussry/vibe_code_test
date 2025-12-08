import 'package:flutter/material.dart';

class QrProductItemTheme extends ThemeExtension<QrProductItemTheme> {
  static QrProductItemTheme of(BuildContext context) => Theme.of(context).extension<QrProductItemTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;

  const QrProductItemTheme({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
  });

  @override
  ThemeExtension<QrProductItemTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
  }) =>
      QrProductItemTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
      );

  @override
  ThemeExtension<QrProductItemTheme> lerp(covariant ThemeExtension<QrProductItemTheme>? other, double t) {
    if (other is! QrProductItemTheme) {
      return this;
    }
    return QrProductItemTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subtitleTextStyle: TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t)!,
    );
  }
}
