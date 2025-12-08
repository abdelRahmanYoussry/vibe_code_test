import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class ProgressDash extends StatelessWidget {
  const ProgressDash({
    super.key,
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _ProgressDash(color: color),
    );
  }
}

class _ProgressDash extends CustomPainter {
  final Color color;

  _ProgressDash({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final th = 1.25.h; //thickness
    final l = 5.w; //length
    final g = 5.w; //gap
    final c = (w / (l + g)).floor();

    final paint = Paint()
      ..color = color
      ..strokeWidth = th
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < c; i++) {
      canvas.drawLine(
        Offset(i * (l + g), h / 2),
        Offset(i * (l + g) + l, h / 2),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ProgressDash oldDelegate) => oldDelegate.color != color;
}
