import 'package:flutter/material.dart';

class PageLabelTheme extends ThemeExtension<PageLabelTheme> {
  static PageLabelTheme of(BuildContext context) => Theme.of(context).extension<PageLabelTheme>()!;

  final TextStyle labelStyle;

  const PageLabelTheme({
    required this.labelStyle,
  });

  @override
  ThemeExtension<PageLabelTheme> copyWith({
    TextStyle? labelStyle,
  }) =>
      PageLabelTheme(
        labelStyle: labelStyle ?? this.labelStyle,
      );

  @override
  ThemeExtension<PageLabelTheme> lerp(covariant ThemeExtension<PageLabelTheme>? other, double t) {
    if (other is! PageLabelTheme) {
      return this;
    }
    return PageLabelTheme(
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
    );
  }
}
