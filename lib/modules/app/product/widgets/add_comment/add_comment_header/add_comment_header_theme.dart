import 'package:flutter/material.dart';

class AddCommentHeaderTheme extends ThemeExtension<AddCommentHeaderTheme> {
  static AddCommentHeaderTheme of(BuildContext context) => Theme.of(context).extension<AddCommentHeaderTheme>()!;

  final TextStyle titleTextStyle;
  final IconThemeData leadingIconStyle;
  final IconThemeData trailingIconStyle;

  const AddCommentHeaderTheme({
    required this.titleTextStyle,
    required this.leadingIconStyle,
    required this.trailingIconStyle,
  });

  @override
  ThemeExtension<AddCommentHeaderTheme> copyWith({
    TextStyle? titleTextStyle,
    IconThemeData? leadingIconStyle,
    IconThemeData? trailingIconStyle,
  }) =>
      AddCommentHeaderTheme(
        titleTextStyle: titleTextStyle ?? this.titleTextStyle,
        leadingIconStyle: leadingIconStyle ?? this.leadingIconStyle,
        trailingIconStyle: trailingIconStyle ?? this.trailingIconStyle,
      );

  @override
  ThemeExtension<AddCommentHeaderTheme> lerp(covariant ThemeExtension<AddCommentHeaderTheme>? other, double t) {
    if (other is! AddCommentHeaderTheme) {
      return this;
    }
    return AddCommentHeaderTheme(
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      leadingIconStyle: IconThemeData.lerp(leadingIconStyle, other.leadingIconStyle, t),
      trailingIconStyle: IconThemeData.lerp(trailingIconStyle, other.trailingIconStyle, t),
    );
  }
}
