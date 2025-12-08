import 'package:test_vibe/core/widgets/quantity_counter/quantity_counter_theme.dart';
import 'package:flutter/material.dart';

class AddCartSectionTheme extends ThemeExtension<AddCartSectionTheme> {
  static AddCartSectionTheme of(BuildContext context) => Theme.of(context).extension<AddCartSectionTheme>()!;

  final QuantityCounterTheme counterTheme;
  final BoxDecoration backgroundDecoration;
  final ButtonStyle addCartButtonStyle;

  const AddCartSectionTheme({
    required this.counterTheme,
    required this.backgroundDecoration,
    required this.addCartButtonStyle,
  });

  @override
  ThemeExtension<AddCartSectionTheme> copyWith({
    QuantityCounterTheme? counterTheme,
    BoxDecoration? backgroundDecoration,
    ButtonStyle? addCartButtonStyle,
  }) =>
      AddCartSectionTheme(
        counterTheme: counterTheme ?? this.counterTheme,
        backgroundDecoration: backgroundDecoration ?? this.backgroundDecoration,
        addCartButtonStyle: addCartButtonStyle ?? this.addCartButtonStyle,
      );

  @override
  ThemeExtension<AddCartSectionTheme> lerp(covariant ThemeExtension<AddCartSectionTheme>? other, double t) {
    if (other is! AddCartSectionTheme) {
      return this;
    }
    return AddCartSectionTheme(
      counterTheme: counterTheme.lerp(other.counterTheme, t),
      backgroundDecoration: BoxDecoration.lerp(backgroundDecoration, other.backgroundDecoration, t)!,
      addCartButtonStyle: ButtonStyle.lerp(addCartButtonStyle, other.addCartButtonStyle, t)!,
    );
  }
}
