import 'package:flutter/material.dart';

class ProfileActionTileTheme extends ThemeExtension<ProfileActionTileTheme> {
  static ProfileActionTileTheme of(BuildContext context) => Theme.of(context).extension<ProfileActionTileTheme>()!;

  final BoxDecoration boxDecoration;
  final IconThemeData leadingIconThemeData;
  final TextStyle labelStyle;
  final TextStyle trailingTextStyle;
  final IconThemeData trailingIconThemeData;

  const ProfileActionTileTheme({
    required this.boxDecoration,
    required this.leadingIconThemeData,
    required this.labelStyle,
    required this.trailingTextStyle,
    required this.trailingIconThemeData,
  });

  @override
  ThemeExtension<ProfileActionTileTheme> copyWith({
    BoxDecoration? boxDecoration,
    IconThemeData? leadingIconThemeData,
    TextStyle? labelStyle,
    TextStyle? trailingTextStyle,
    IconThemeData? trailingIconThemeData,
  }) =>
      ProfileActionTileTheme(
        boxDecoration: boxDecoration ?? this.boxDecoration,
        leadingIconThemeData: leadingIconThemeData ?? this.leadingIconThemeData,
        labelStyle: labelStyle ?? this.labelStyle,
        trailingTextStyle: trailingTextStyle ?? this.trailingTextStyle,
        trailingIconThemeData: trailingIconThemeData ?? this.trailingIconThemeData,
      );

  @override
  ThemeExtension<ProfileActionTileTheme> lerp(covariant ThemeExtension<ProfileActionTileTheme>? other, double t) {
    if (other is! ProfileActionTileTheme) {
      return this;
    }
    return ProfileActionTileTheme(
      boxDecoration: BoxDecoration.lerp(boxDecoration, other.boxDecoration, t)!,
      leadingIconThemeData: IconThemeData.lerp(leadingIconThemeData, other.leadingIconThemeData, t),
      labelStyle: TextStyle.lerp(labelStyle, other.labelStyle, t)!,
      trailingTextStyle: TextStyle.lerp(trailingTextStyle, other.trailingTextStyle, t)!,
      trailingIconThemeData: IconThemeData.lerp(trailingIconThemeData, other.trailingIconThemeData, t),
    );
  }
}
