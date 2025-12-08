import 'package:flutter/material.dart';

class SectionLabelTheme extends ThemeExtension<SectionLabelTheme> {
  static SectionLabelTheme of(BuildContext context) => Theme.of(context).extension<SectionLabelTheme>()!;

  final TextStyle labelStyle;

  const SectionLabelTheme({
    required this.labelStyle,
  });

  @override
  ThemeExtension<SectionLabelTheme> copyWith({
    TextStyle? labelStyle,
  }) =>
      SectionLabelTheme(
        labelStyle: labelStyle ?? this.labelStyle,
      );

  @override
  ThemeExtension<SectionLabelTheme> lerp(covariant ThemeExtension<SectionLabelTheme>? other, double t) {
    if (other is! SectionLabelTheme) {
      return this;
    }
    return SectionLabelTheme(
      labelStyle: other.labelStyle,
    );
  }
}
