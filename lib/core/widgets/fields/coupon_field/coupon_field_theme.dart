import 'package:flutter/material.dart';

class CouponFieldTheme extends ThemeExtension<CouponFieldTheme> {
  static CouponFieldTheme of(BuildContext context) => Theme.of(context).extension<CouponFieldTheme>()!;

  final InputDecorationTheme inputDecorationTheme;

  const CouponFieldTheme({
    required this.inputDecorationTheme,
  });

  @override
  ThemeExtension<CouponFieldTheme> copyWith({
    InputDecorationTheme? inputDecorationTheme,
  }) =>
      CouponFieldTheme(
        inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
      );

  @override
  ThemeExtension<CouponFieldTheme> lerp(covariant ThemeExtension<CouponFieldTheme>? other, double t) {
    if (other is! CouponFieldTheme) {
      return this;
    }
    return CouponFieldTheme(
      inputDecorationTheme: other.inputDecorationTheme,
    );
  }
}
