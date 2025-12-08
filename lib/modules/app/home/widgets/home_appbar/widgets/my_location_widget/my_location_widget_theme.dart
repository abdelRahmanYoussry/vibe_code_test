import 'package:flutter/material.dart';

class MyLocationWidgetTheme extends ThemeExtension<MyLocationWidgetTheme> {
  static MyLocationWidgetTheme of(BuildContext context) => Theme.of(context).extension<MyLocationWidgetTheme>()!;

  final TextStyle labelTextStyle;
  final TextStyle titleTextStyle;
  final IconThemeData expandIconThemeData;

  const MyLocationWidgetTheme({
    required this.labelTextStyle,
    required this.titleTextStyle,
    required this.expandIconThemeData,
  });

  @override
  ThemeExtension<MyLocationWidgetTheme> copyWith({
    TextStyle? labelTextStyle,
    TextStyle? titleTextStyle,
    IconThemeData? expandIconThemeData,
  }) =>
      MyLocationWidgetTheme(
        labelTextStyle: labelTextStyle ?? this.labelTextStyle,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        expandIconThemeData: expandIconThemeData ?? this.expandIconThemeData,
      );

  @override
  ThemeExtension<MyLocationWidgetTheme> lerp(covariant ThemeExtension<MyLocationWidgetTheme>? other, double t) {
    if (other is! MyLocationWidgetTheme) {
      return this;
    }
    return MyLocationWidgetTheme(
      labelTextStyle: TextStyle.lerp(labelTextStyle, other.labelTextStyle, t)!,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      expandIconThemeData: IconThemeData.lerp(expandIconThemeData, other.expandIconThemeData, t),
    );
  }
}
