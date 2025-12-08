import 'package:flutter/material.dart';

class RecentSearchItemTheme extends ThemeExtension<RecentSearchItemTheme> {
  static RecentSearchItemTheme of(BuildContext context) => Theme.of(context).extension<RecentSearchItemTheme>()!;

  final TextStyle labelStyle;
  final IconThemeData iconThemeData;

  const RecentSearchItemTheme({
    required this.labelStyle,
    required this.iconThemeData,
  });

  @override
  ThemeExtension<RecentSearchItemTheme> copyWith({
    TextStyle? labelStyle,
    IconThemeData? iconThemeData,
  }) =>
      RecentSearchItemTheme(
        labelStyle: labelStyle ?? this.labelStyle,
        iconThemeData: iconThemeData ?? this.iconThemeData,
      );

  @override
  ThemeExtension<RecentSearchItemTheme> lerp(covariant ThemeExtension<RecentSearchItemTheme>? other, double t) {
    if (other is! RecentSearchItemTheme) {
      return this;
    }
    return RecentSearchItemTheme(
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      iconThemeData: IconThemeData.lerp(iconThemeData, other.iconThemeData, t),
    );
  }
}
