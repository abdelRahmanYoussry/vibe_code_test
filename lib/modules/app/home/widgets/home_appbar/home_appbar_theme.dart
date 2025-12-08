import 'package:flutter/material.dart';

class HomeAppbarTheme extends ThemeExtension<HomeAppbarTheme> {
  static HomeAppbarTheme of(BuildContext context) => Theme.of(context).extension<HomeAppbarTheme>()!;

  final AppBarTheme appBarTheme;
  final InputDecorationTheme searchInputDecorationTheme;

  const HomeAppbarTheme({
    required this.appBarTheme,
    required this.searchInputDecorationTheme,
  });

  @override
  ThemeExtension<HomeAppbarTheme> copyWith({
    AppBarTheme? appBarTheme,
    InputDecorationTheme? searchInputDecorationTheme,
  }) =>
      HomeAppbarTheme(
        appBarTheme: appBarTheme ?? this.appBarTheme,
        searchInputDecorationTheme: searchInputDecorationTheme ?? this.searchInputDecorationTheme,
      );

  @override
  ThemeExtension<HomeAppbarTheme> lerp(covariant ThemeExtension<HomeAppbarTheme>? other, double t) {
    if (other is! HomeAppbarTheme) {
      return this;
    }
    return HomeAppbarTheme(
      appBarTheme: AppBarTheme.lerp(appBarTheme, other.appBarTheme, t),
      searchInputDecorationTheme: other.searchInputDecorationTheme,
    );
  }
}
