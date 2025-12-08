import 'package:flutter/material.dart';

class TextStyleBuilder extends TextStyle {
  const TextStyleBuilder({
    required super.fontWeight,
    required super.fontSize,
    super.letterSpacing,
    required super.color,
    double? height,
    super.fontFamily,
    super.fontStyle,
    super.decoration,
    super.decorationColor,
  }) : super(
          height: height == null || fontSize == null ? null : height / fontSize,
          overflow: TextOverflow.ellipsis,
        );
}

Size getTextSize(String text, TextStyle style, [int? maxLines]) {
  final painter = TextPainter(
    text: TextSpan(text: text, style: style),
    maxLines: maxLines,
    textDirection: TextDirection.ltr,
  );
  painter.layout();
  return painter.size;
}
