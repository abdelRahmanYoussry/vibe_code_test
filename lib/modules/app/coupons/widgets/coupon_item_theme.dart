import 'package:flutter/material.dart';

class CouponItemTheme extends ThemeExtension<CouponItemTheme> {
  static CouponItemTheme of(BuildContext context) => Theme.of(context).extension<CouponItemTheme>()!;

  final BoxDecoration backgroundDecoration;
  final TextStyle titleTextStyle;
  final TextStyle bodyTextStyle;
  final TextStyle discountTextStyle;
  final IconThemeData discountIconStyle;
  final TextStyle copyButtonTextStyle;
  final BoxDecoration copyButtonBackground;
  final Color couponBackgroundColor;

  const CouponItemTheme({
    required this.backgroundDecoration,
    required this.titleTextStyle,
    required this.bodyTextStyle,
    required this.discountTextStyle,
    required this.discountIconStyle,
    required this.copyButtonTextStyle,
    required this.copyButtonBackground,
   required this.couponBackgroundColor ,
  });

  @override
  ThemeExtension<CouponItemTheme> copyWith({
    BoxDecoration? backgroundDecoration,
    TextStyle? titleTextStyle,
    TextStyle? bodyTextStyle,
    TextStyle? discountTextStyle,
    IconThemeData? discountIconStyle,
    TextStyle? copyButtonTextStyle,
    BoxDecoration? copyButtonBackground,
    Color? couponBackgroundColor,
  }) =>
      CouponItemTheme(
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
        discountTextStyle: discountTextStyle ?? this.discountTextStyle,
        discountIconStyle: discountIconStyle ?? this.discountIconStyle,
        copyButtonTextStyle: copyButtonTextStyle ?? this.copyButtonTextStyle,
        copyButtonBackground: copyButtonBackground ?? this.copyButtonBackground,
        couponBackgroundColor: couponBackgroundColor ?? this.couponBackgroundColor,
      );

  @override
  ThemeExtension<CouponItemTheme> lerp(covariant ThemeExtension<CouponItemTheme>? other, double t) {
    if (other is! CouponItemTheme) {
      return this;
    }
    return CouponItemTheme(
      backgroundDecoration: BoxDecoration.lerp(backgroundDecoration, other.backgroundDecoration, t)!,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      bodyTextStyle: TextStyle.lerp(bodyTextStyle, other.bodyTextStyle, t)!,
      discountTextStyle: TextStyle.lerp(discountTextStyle, other.discountTextStyle, t)!,
      discountIconStyle: IconThemeData.lerp(discountIconStyle, other.discountIconStyle, t),
      copyButtonTextStyle: TextStyle.lerp(copyButtonTextStyle, other.copyButtonTextStyle, t)!,
      copyButtonBackground: BoxDecoration.lerp(copyButtonBackground, other.copyButtonBackground, t)!,
      couponBackgroundColor: Color.lerp(couponBackgroundColor, other.couponBackgroundColor, t)!,
    );
  }
}
