import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class PaymentMethodTheme extends ThemeExtension<PaymentMethodTheme> {
  static PaymentMethodTheme of(BuildContext context) => Theme.of(context).extension<PaymentMethodTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle paymentMethodStyle;
  final WidgetStateProperty<Color?> radioFillColor;

  const PaymentMethodTheme({
    required this.titleTextStyle,
    required this.paymentMethodStyle,
    required this.radioFillColor,
  });

  @override
  ThemeExtension<PaymentMethodTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? paymentMethodStyle,
    TextStyle? optionTextStyle,
    DividerThemeData? dividerThemeData,
    ExpandableThemeData? expandableThemeData,
    ListTileControlAffinity? listTileControlAffinity,
    WidgetStateProperty<Color?>? radioFillColor,
  }) =>
      PaymentMethodTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        paymentMethodStyle: paymentMethodStyle ?? this.paymentMethodStyle,
        radioFillColor: radioFillColor ?? this.radioFillColor,
      );

  @override
  ThemeExtension<PaymentMethodTheme> lerp(covariant ThemeExtension<PaymentMethodTheme>? other, double t) {
    if (other is! PaymentMethodTheme) {
      return this;
    }
    return PaymentMethodTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      paymentMethodStyle: TextStyle.lerp(paymentMethodStyle, other.paymentMethodStyle, t)!,
      radioFillColor: WidgetStateProperty.lerp<Color?>(
        radioFillColor,
        other.radioFillColor,
        t,
        (a, b, t) => Color.lerp(a, b, t),
      )!,
    );
  }
}
