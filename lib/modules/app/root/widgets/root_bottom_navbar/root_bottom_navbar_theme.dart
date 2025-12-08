import 'package:flutter/material.dart';

class RootBottomNavbarTheme extends ThemeExtension<RootBottomNavbarTheme> {
  static RootBottomNavbarTheme of(BuildContext context) => Theme.of(context).extension<RootBottomNavbarTheme>()!;

  final Size size;
  final DividerThemeData dividerTheme;

  const RootBottomNavbarTheme({
    required this.size,
    required this.dividerTheme,
  });

  @override
  ThemeExtension<RootBottomNavbarTheme> copyWith({
    Size? size,
    DividerThemeData? dividerTheme,
  }) =>
      RootBottomNavbarTheme(
        size: size ?? this.size,
        dividerTheme: dividerTheme ?? this.dividerTheme,
      );

  @override
  ThemeExtension<RootBottomNavbarTheme> lerp(covariant ThemeExtension<RootBottomNavbarTheme>? other, double t) {
    if (other is! RootBottomNavbarTheme) {
      return this;
    }
    return RootBottomNavbarTheme(
      size: Size.lerp(size, other.size, t)!,
      dividerTheme: DividerThemeData.lerp(dividerTheme, other.dividerTheme, t),
    );
  }
}
