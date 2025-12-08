import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class CartOverviewSectionTheme extends ThemeExtension<CartOverviewSectionTheme> {
  static CartOverviewSectionTheme of(BuildContext context) => Theme.of(context).extension<CartOverviewSectionTheme>()!;

  final BoxDecoration backgroundDecoration;
  final TextStyle labelTextStyle;
  final TextStyle valueTextStyle;
  final ExpandableThemeData couponInputExpandableTheme;

  const CartOverviewSectionTheme({
    required this.backgroundDecoration,
    required this.labelTextStyle,
    required this.valueTextStyle,
    required this.couponInputExpandableTheme,
  });

  @override
  ThemeExtension<CartOverviewSectionTheme> copyWith({
    BoxDecoration? backgroundDecoration,
    TextStyle? labelTextStyle,
    TextStyle? valueTextStyle,
    ExpandableThemeData? couponInputExpandableTheme,
  }) =>
      CartOverviewSectionTheme(
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        valueTextStyle: valueTextStyle ?? this.valueTextStyle,
        couponInputExpandableTheme: couponInputExpandableTheme ?? this.couponInputExpandableTheme,
      );

  @override
  ThemeExtension<CartOverviewSectionTheme> lerp(covariant ThemeExtension<CartOverviewSectionTheme>? other, double t) {
    if (other is! CartOverviewSectionTheme) {
      return this;
    }
    return CartOverviewSectionTheme(
      backgroundDecoration: BoxDecoration.lerp(backgroundDecoration, other.backgroundDecoration, t)!,
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      valueTextStyle: TextStyle.lerp(valueTextStyle, other.valueTextStyle, t)!,
      couponInputExpandableTheme: other.couponInputExpandableTheme,
    );
  }
}
