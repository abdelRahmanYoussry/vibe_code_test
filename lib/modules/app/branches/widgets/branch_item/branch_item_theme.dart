import 'package:flutter/material.dart';

class BranchItemTheme extends ThemeExtension<BranchItemTheme> {
  static BranchItemTheme of(BuildContext context) => Theme.of(context).extension<BranchItemTheme>()!;

  final IconThemeData iconThemeData;
  final TextStyle titleTextStyle;
  final TextStyle subtitleTextStyle;
  final IconThemeData activeIconThemeData;
  final IconThemeData inactiveIconThemeData;

  const BranchItemTheme({
    required this.iconThemeData,
    required this.titleTextStyle,
    required this.subtitleTextStyle,
    required this.activeIconThemeData,
    required this.inactiveIconThemeData,
  });

  @override
  ThemeExtension<BranchItemTheme> copyWith({
    IconThemeData? iconThemeData,
    TextStyle? titleTextStyle,
    TextStyle? subtitleTextStyle,
    IconThemeData? activeIconThemeData,
    IconThemeData? inactiveIconThemeData,
  }) =>
      BranchItemTheme(
        iconThemeData: iconThemeData ?? this.iconThemeData,
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        subtitleTextStyle: subtitleTextStyle ?? this.subtitleTextStyle,
        activeIconThemeData: activeIconThemeData ?? this.activeIconThemeData,
        inactiveIconThemeData: inactiveIconThemeData ?? this.inactiveIconThemeData,
      );

  @override
  ThemeExtension<BranchItemTheme> lerp(covariant ThemeExtension<BranchItemTheme>? other, double t) {
    if (other is! BranchItemTheme) {
      return this;
    }
    return BranchItemTheme(
      iconThemeData: IconThemeData.lerp(iconThemeData, other.iconThemeData, t),
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      subtitleTextStyle: TextStyle.lerp(subtitleTextStyle, other.subtitleTextStyle, t)!,
      activeIconThemeData: IconThemeData.lerp(activeIconThemeData, other.activeIconThemeData, t),
      inactiveIconThemeData: IconThemeData.lerp(inactiveIconThemeData, other.inactiveIconThemeData, t),
    );
  }
}
