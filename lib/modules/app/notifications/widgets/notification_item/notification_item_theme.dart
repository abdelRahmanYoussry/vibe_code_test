import 'package:flutter/material.dart';

class NotificationItemTheme extends ThemeExtension<NotificationItemTheme> {
  static NotificationItemTheme of(BuildContext context) => Theme.of(context).extension<NotificationItemTheme>()!;

  final TextStyle bodyTextStyle;
  final TextStyle dateTextStyle;
  final TextStyle headerTextStyle;
  final IconThemeData iconStyle;

  const NotificationItemTheme({
    required this.bodyTextStyle,
    required this.dateTextStyle,
    required this.headerTextStyle,
    required this.iconStyle,
  });

  @override
  ThemeExtension<NotificationItemTheme> copyWith({
    TextStyle? bodyTextStyle,
    TextStyle? dateTextStyle,
    TextStyle? headerTextStyle,
    IconThemeData? iconStyle,
  }) =>
      NotificationItemTheme(
        bodyTextStyle: bodyTextStyle ?? this.bodyTextStyle,
        dateTextStyle: dateTextStyle ?? this.dateTextStyle,
        headerTextStyle: headerTextStyle ?? this.headerTextStyle,
        iconStyle: iconStyle ?? this.iconStyle,
      );

  @override
  ThemeExtension<NotificationItemTheme> lerp(covariant ThemeExtension<NotificationItemTheme>? other, double t) {
    if (other is! NotificationItemTheme) {
      return this;
    }
    return NotificationItemTheme(
      bodyTextStyle: TextStyle.lerp(bodyTextStyle, other.bodyTextStyle, t)!,
      dateTextStyle: TextStyle.lerp(dateTextStyle, other.dateTextStyle, t)!,
      headerTextStyle: TextStyle.lerp(headerTextStyle, other.headerTextStyle, t)!,
      iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    );
  }
}
