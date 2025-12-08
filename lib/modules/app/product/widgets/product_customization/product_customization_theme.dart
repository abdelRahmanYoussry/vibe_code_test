import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class ProductCustomizationTheme extends ThemeExtension<ProductCustomizationTheme> {
  static ProductCustomizationTheme of(BuildContext context) => Theme.of(context).extension<ProductCustomizationTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle subtitleStyle;
  final TextStyle optionTextStyle;
  final DividerThemeData dividerThemeData;
  final ExpandableThemeData expandableThemeData;
  final ListTileControlAffinity listTileControlAffinity;
  final WidgetStateProperty<Color?> radioFillColor;

  const ProductCustomizationTheme({
    required this.titleTextStyle,
    required this.subtitleStyle,
    required this.optionTextStyle,
    required this.dividerThemeData,
    required this.expandableThemeData,
    required this.listTileControlAffinity,
    required this.radioFillColor,
  });

  @override
  ThemeExtension<ProductCustomizationTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? subtitleStyle,
    TextStyle? optionTextStyle,
    DividerThemeData? dividerThemeData,
    ExpandableThemeData? expandableThemeData,
    ListTileControlAffinity? listTileControlAffinity,
    WidgetStateProperty<Color?>? radioFillColor,
  }) =>
      ProductCustomizationTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleStyle: subtitleStyle ?? this.subtitleStyle,
        optionTextStyle: optionTextStyle ?? this.optionTextStyle,
        dividerThemeData: dividerThemeData ?? this.dividerThemeData,
        expandableThemeData: expandableThemeData ?? this.expandableThemeData,
        listTileControlAffinity: listTileControlAffinity ?? this.listTileControlAffinity,
        radioFillColor: radioFillColor ?? this.radioFillColor,
      );

  @override
  ThemeExtension<ProductCustomizationTheme> lerp(covariant ThemeExtension<ProductCustomizationTheme>? other, double t) {
    if (other is! ProductCustomizationTheme) {
      return this;
    }
    return ProductCustomizationTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subtitleStyle: TextStyle.lerp(subtitleStyle, other.subtitleStyle, t)!,
      optionTextStyle: TextStyle.lerp(optionTextStyle, other.optionTextStyle, t)!,
      dividerThemeData: DividerThemeData.lerp(dividerThemeData, other.dividerThemeData, t),
      expandableThemeData: other.expandableThemeData,
      listTileControlAffinity: other.listTileControlAffinity,
      radioFillColor: WidgetStateProperty.lerp<Color?>(
        radioFillColor,
        other.radioFillColor,
        t,
        (a, b, t) => Color.lerp(a, b, t),
      )!,
    );
  }
}
