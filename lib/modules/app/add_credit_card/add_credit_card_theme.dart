import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class AddCreditCardTheme extends ThemeExtension<AddCreditCardTheme> {
  static AddCreditCardTheme of(BuildContext context) => Theme.of(context).extension<AddCreditCardTheme>()!;

  final TextStyle labelTextStyle;
  final TextStyle hintStyle;

  const AddCreditCardTheme({
    required this.labelTextStyle,
    required this.hintStyle,
  });

  @override
  ThemeExtension<AddCreditCardTheme> copyWith({
    TextStyle? labelTextStyle,
    TextStyle? hintStyle,
    TextStyle? optionTextStyle,
    DividerThemeData? dividerThemeData,
    ExpandableThemeData? expandableThemeData,
    ListTileControlAffinity? listTileControlAffinity,
    WidgetStateProperty<Color?>? radioFillColor,
  }) =>
      AddCreditCardTheme(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        hintStyle: hintStyle ?? this.hintStyle,
      );

  @override
  ThemeExtension<AddCreditCardTheme> lerp(covariant ThemeExtension<AddCreditCardTheme>? other, double t) {
    if (other is! AddCreditCardTheme) {
      return this;
    }
    return AddCreditCardTheme(
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      hintStyle: TextStyle.lerp(hintStyle, other.hintStyle, t)!,
    );
  }
}
