import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPFieldTheme extends ThemeExtension<OTPFieldTheme> {
  static OTPFieldTheme of(BuildContext context) => Theme.of(context).extension<OTPFieldTheme>()!;

  final PinTheme pinTheme;
  final TextStyle textStyle;

  const OTPFieldTheme({
    required this.pinTheme,
    required this.textStyle,
  });

  @override
  ThemeExtension<OTPFieldTheme> copyWith({
    TextStyle? textStyle,
  }) =>
      OTPFieldTheme(
        pinTheme: pinTheme,
        textStyle: textStyle ?? this.textStyle,
      );

  @override
  ThemeExtension<OTPFieldTheme> lerp(covariant ThemeExtension<OTPFieldTheme>? other, double t) {
    if (other is! OTPFieldTheme) {
      return this;
    }
    return OTPFieldTheme(
      pinTheme: other.pinTheme,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
    );
  }
}
