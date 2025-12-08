import 'dart:math';

import 'package:test_vibe/core/utils/math_utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class SpinnerPainter extends CustomPainter {
  final Color outerBorderColor;
  final Color outerBorderCirclesColor;
  final Color innerBorderColor;
  final Color innerBorderCircleColor;
  final List<SpinnerItem> items;

  SpinnerPainter({
    required this.items,
    required this.outerBorderColor,
    required this.outerBorderCirclesColor,
    required this.innerBorderColor,
    required this.innerBorderCircleColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final strokeWidth = 18.sp;
    final radius = (size.width / 2) - strokeWidth;
    final circle = Rect.fromCircle(
      center: center,
      radius: radius,
    );
    canvas.drawCircle(
      center,
      radius + strokeWidth / 2,
      Paint()
        ..color = outerBorderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth,
    );
    final segment = 360 / items.length;

    double getStartAngle(int index) {
      return degToRad((index * segment) - 90);
    }

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      canvas.drawArc(
        circle,
        getStartAngle(i),
        degToRad(segment),
        true,
        Paint()..color = item.color,
      );
    }

    for (int i = 0; i < items.length; i++) {
      final item = items[i];
      final textPainter = TextPainter(
        text: item.title,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(
        minWidth: 0,
        maxWidth: (radius - strokeWidth) * .7,
      );
      canvas.save();
      canvas.translate(
        center.dx,
        center.dy,
      );
      final angle = getStartAngle(i) + (degToRad(segment) / 2);
      canvas.rotate(angle);
      canvas.translate(
        (radius - strokeWidth) * .7 / 2,
        -textPainter.height / 2,
      );
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }

    for (int i = 0; i < (items.length * 1) - 0; i++) {
      final angle = getStartAngle(i) + (degToRad(segment) / 2);
      canvas.drawCircle(
        Offset(
          center.dx + (radius + strokeWidth / 2) * cos(angle),
          center.dy + (radius + strokeWidth / 2) * sin(angle),
        ),
        strokeWidth / 2,
        Paint()..color = outerBorderCirclesColor,
      );
      canvas.drawCircle(
        Offset(
          center.dx + (radius + strokeWidth / 2) * cos(angle + degToRad(segment / 2)),
          center.dy + (radius + strokeWidth / 2) * sin(angle + degToRad(segment / 2)),
        ),
        strokeWidth / 2,
        Paint()..color = outerBorderCirclesColor,
      );
    }

    canvas.drawCircle(
      Offset(
        center.dx,
        center.dy,
      ),
      15.sp,
      Paint()..color = innerBorderCircleColor,
    );
    canvas.drawCircle(
      Offset(
        center.dx,
        center.dy,
      ),
      15.sp,
      Paint()
        ..color = innerBorderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth / 2,
    );
  }

  @override
  bool shouldRepaint(covariant SpinnerPainter oldDelegate) =>
      oldDelegate.items != items ||
      oldDelegate.outerBorderColor != outerBorderColor ||
      oldDelegate.outerBorderCirclesColor != outerBorderCirclesColor ||
      oldDelegate.innerBorderColor != innerBorderColor ||
      oldDelegate.innerBorderCircleColor != innerBorderCircleColor;
}

class SpinnerArrowPainter extends CustomPainter {
  final Color arrowOuterBorderColor;
  final Color arrowInnerBorderColor;

  SpinnerArrowPainter({
    required this.arrowOuterBorderColor,
    required this.arrowInnerBorderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final arrowWidth = 30.w;
    final arrowHeight = 55.h;
    final arrowHeightBreakingPoint = 20.h;
    canvas.save();
    canvas.translate(
      size.width / 2 - arrowWidth / 2,
      -arrowHeightBreakingPoint * .75,
    );
    canvas.drawPath(
      Path()
        ..relativeLineTo(arrowWidth, 0)
        ..relativeLineTo(0, arrowHeightBreakingPoint)
        ..relativeLineTo(-arrowWidth / 2, arrowHeight - arrowHeightBreakingPoint)
        ..relativeLineTo(-arrowWidth / 2, -(arrowHeight - arrowHeightBreakingPoint))
        ..close(),
      Paint()..color = arrowInnerBorderColor,
    );
    canvas.drawPath(
      Path()
        ..relativeLineTo(arrowWidth, 0)
        ..relativeLineTo(0, arrowHeightBreakingPoint)
        ..relativeLineTo(-arrowWidth / 2, arrowHeight - arrowHeightBreakingPoint)
        ..relativeLineTo(-arrowWidth / 2, -(arrowHeight - arrowHeightBreakingPoint))
        ..close(),
      Paint()
        ..color = arrowOuterBorderColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10.sp,
    );
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant SpinnerArrowPainter oldDelegate) =>
      oldDelegate.arrowInnerBorderColor != arrowInnerBorderColor || oldDelegate.arrowOuterBorderColor != arrowOuterBorderColor;
}

class SpinnerItem extends Equatable {
  final TextSpan title;
  final Color color;

  const SpinnerItem({
    required this.title,
    required this.color,
  });

  @override
  List<Object?> get props => [
        title,
        color,
      ];
}
