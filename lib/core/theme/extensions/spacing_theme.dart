import 'dart:ui';

import 'package:flutter/material.dart';

class SpacingTheme extends ThemeExtension<SpacingTheme> {
  static SpacingTheme of(BuildContext context) => Theme.of(context).extension<SpacingTheme>()!;

  final EdgeInsetsGeometry pagePadding;
  final EdgeInsetsGeometry bottomSheetPagePadding;
  final double bottomSheetHeightFactor;
  final EdgeInsetsGeometry dialogPagePadding;

  const SpacingTheme({
    required this.pagePadding,
    required this.bottomSheetPagePadding,
    required this.bottomSheetHeightFactor,
    required this.dialogPagePadding,
  });

  @override
  ThemeExtension<SpacingTheme> copyWith({
    EdgeInsetsGeometry? pagePadding,
    EdgeInsetsGeometry? bottomSheetPagePadding,
    double? bottomSheetHeightFactor,
    EdgeInsetsGeometry? dialogPagePadding,
  }) =>
      SpacingTheme(
        pagePadding: pagePadding ?? this.pagePadding,
        bottomSheetPagePadding: bottomSheetPagePadding ?? this.bottomSheetPagePadding,
        bottomSheetHeightFactor: bottomSheetHeightFactor ?? this.bottomSheetHeightFactor,
        dialogPagePadding: dialogPagePadding ?? this.dialogPagePadding,
      );

  @override
  SpacingTheme lerp(SpacingTheme? other, double t) {
    if (other == null) return this;
    return SpacingTheme(
      pagePadding: EdgeInsetsGeometry.lerp(pagePadding, other.pagePadding, t)!,
      bottomSheetPagePadding: EdgeInsetsGeometry.lerp(bottomSheetPagePadding, other.bottomSheetPagePadding, t)!,
      bottomSheetHeightFactor: lerpDouble(bottomSheetHeightFactor, other.bottomSheetHeightFactor, t)!,
      dialogPagePadding: EdgeInsetsGeometry.lerp(dialogPagePadding, other.dialogPagePadding, t)!,
    );
  }
}
