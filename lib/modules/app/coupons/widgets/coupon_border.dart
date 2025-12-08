import 'package:test_vibe/core/utils/math_utils.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class CouponBorder extends StatelessWidget {
  const CouponBorder({
    super.key,
    required this.child,
    required this.borderSide,
    this.bottomOffset,
  });

  final Widget child;
  final BorderSide? borderSide;
  final double? bottomOffset;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _CouponBorderPainter(borderSide, bottomOffset),
      child: ClipPath(
        clipper: _CouponBorderClipper(bottomOffset),
        child: child,
      ),
    );
  }
}

class _CouponBorderPainter extends CustomPainter {
  final BorderSide? borderSide;
  final double? bottomOffset;

  _CouponBorderPainter(this.borderSide, this.bottomOffset);

  @override
  void paint(Canvas canvas, Size size) {
    final r = 15.h; //radius
    final w = size.width;
    final h = size.height;
    final m = bottomOffset == null ? (h / 2) : h - (bottomOffset!); //midpoint

    //dashes
    final sw = 12.w; //width
    final sh = 4.h; //height
    final sm = sh / 2; //midpoint
    final sg = 8.h; //gap
    final sc = (w / (r + sg)).floor() - 1; //count

    final paint = Paint()
      ..color = borderSide?.color ?? Colors.transparent
      ..strokeWidth = borderSide?.width ?? 0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final circleLeft = Rect.fromCircle(
      center: Offset(0, m),
      radius: r,
    );
    final circleRight = Rect.fromCircle(
      center: Offset(w, m),
      radius: r,
    );
    canvas.drawArc(
      circleLeft,
      degToRad(-90),
      degToRad(180),
      false,
      paint,
    );
    canvas.drawArc(
      circleRight,
      degToRad(-90),
      degToRad(-180),
      false,
      paint,
    );
    for (int i = 0; i < sc; i++) {
      canvas.drawRect(Rect.fromLTWH((r + sg) * (i + 1), m - sm, sw, sh), paint);
    }
  }

  @override
  bool shouldRepaint(covariant _CouponBorderPainter oldDelegate) =>
      oldDelegate.borderSide != borderSide || oldDelegate.bottomOffset != bottomOffset;
}

class _CouponBorderClipper extends CustomClipper<Path> {
  final double? bottomOffset;

  _CouponBorderClipper(this.bottomOffset);

  @override
  Path getClip(Size size) {
    final r = 15.h; //radius
    final w = size.width;
    final h = size.height;
    final m = bottomOffset == null ? (h / 2) : h - (bottomOffset!); //midpoint

    final path = Path()..fillType = PathFillType.evenOdd;
    // final path = Path();

    path.addRect(Rect.fromLTWH(0, 0, w, h));
    path.addOval(Rect.fromCircle(center: Offset(0, m), radius: r));
    path.addOval(Rect.fromCircle(center: Offset(w, m), radius: r));

    // path.lineTo(w, 0);
    // path.lineTo(w, m - r);
    // path.lineTo(w - r, m - r);
    // path.lineTo(w - r, m + r);
    // path.lineTo(w, m + r);
    // path.lineTo(w, h);
    // path.lineTo(0, h);
    // path.lineTo(0, m + r);
    // path.lineTo(r, m + r);
    // path.lineTo(r, m - r);
    // path.lineTo(0, m - r);
    // path.lineTo(0, 0);
    // path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant _CouponBorderClipper oldClipper) => bottomOffset != oldClipper.bottomOffset;
}
