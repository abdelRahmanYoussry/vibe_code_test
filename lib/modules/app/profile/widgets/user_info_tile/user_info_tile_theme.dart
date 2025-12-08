import 'package:flutter/material.dart';

class UserInfoTileTheme extends ThemeExtension<UserInfoTileTheme> {
  static UserInfoTileTheme of(BuildContext context) => Theme.of(context).extension<UserInfoTileTheme>()!;

  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final ButtonStyle gearButtonStyle;

  const UserInfoTileTheme({
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.gearButtonStyle,
  });

  @override
  ThemeExtension<UserInfoTileTheme> copyWith({
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    ButtonStyle? gearButtonStyle,
  }) =>
      UserInfoTileTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        gearButtonStyle: gearButtonStyle ?? this.gearButtonStyle,
      );

  @override
  ThemeExtension<UserInfoTileTheme> lerp(covariant ThemeExtension<UserInfoTileTheme>? other, double t) {
    if (other is! UserInfoTileTheme) {
      return this;
    }
    return UserInfoTileTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subtitleTextStyle: TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t)!,
      gearButtonStyle: ButtonStyle.lerp(gearButtonStyle, other.gearButtonStyle, t)!,
    );
  }
}
