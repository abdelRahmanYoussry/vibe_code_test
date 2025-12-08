import 'package:flutter/material.dart';

class NotificationPermissionTheme extends ThemeExtension<NotificationPermissionTheme> {
  static NotificationPermissionTheme of(BuildContext context) => Theme.of(context).extension<NotificationPermissionTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  final IconThemeData iconStyle;

  const NotificationPermissionTheme({
    required this.titleTextStyle,
    required this.subTitleTextStyle,
    required this.iconStyle,
  });

  @override
  ThemeExtension<NotificationPermissionTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? dateTextStyle,
    TextStyle? subTitleTextStyle,
    IconThemeData? iconStyle,
  }) =>
      NotificationPermissionTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subTitleTextStyle: subTitleTextStyle ?? this.subTitleTextStyle,
        iconStyle: iconStyle ?? this.iconStyle,
      );

  @override
  ThemeExtension<NotificationPermissionTheme> lerp(covariant ThemeExtension<NotificationPermissionTheme>? other, double t) {
    if (other is! NotificationPermissionTheme) {
      return this;
    }
    return NotificationPermissionTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subTitleTextStyle: TextStyle.lerp(subTitleTextStyle, other.subTitleTextStyle, t)!,
      iconStyle: IconThemeData.lerp(iconStyle, other.iconStyle, t),
    );
  }
}
