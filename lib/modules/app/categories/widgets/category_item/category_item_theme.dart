import 'package:flutter/material.dart';

class CategoryItemTheme extends ThemeExtension<CategoryItemTheme> {
  static CategoryItemTheme of(BuildContext context) => Theme.of(context).extension<CategoryItemTheme>()!;

  final TextStyle titleTextStyle;

  const CategoryItemTheme({
    required this.titleTextStyle,
  });

  @override
  ThemeExtension<CategoryItemTheme> copyWith({
    TextStyle? titleTextStyle,
  }) =>
      CategoryItemTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      );

  @override
  ThemeExtension<CategoryItemTheme> lerp(covariant ThemeExtension<CategoryItemTheme>? other, double t) {
    if (other is! CategoryItemTheme) {
      return this;
    }
    return CategoryItemTheme(
      titleTextStyle: other.titleTextStyle,
    );
  }
}
