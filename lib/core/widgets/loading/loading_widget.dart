import 'dart:math' as math;

import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:size_config/size_config.dart';

import '../../assets/gen/assets.gen.dart';
import '../pic.dart';

class LoadingWidget extends StatefulWidget {
  const LoadingWidget({super.key, required this.loadingKey, this.ignoring = false,required this.loading});
  final String loadingKey;
  final bool ignoring;
  final bool loading;

  @override
  State<LoadingWidget> createState() => _LoadingWidgetState();
}

class _LoadingWidgetState extends State<LoadingWidget> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.addListener(() => setState(() {}));
    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(!widget.loading){
      return const SizedBox();
    }
    return IgnorePointer(
      ignoring: widget.ignoring,
      child: Material(
        color: Colors.white.withAlpha(6),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Pic(
                    Assets.icons.logoDark.path,
                    width: 187.w,
                  ).animate(autoPlay: true,onPlay: (controller) => (AnimationController controller) => controller.repeat()).shimmer(delay: const Duration(milliseconds: 300), duration: const Duration(milliseconds: 1000),),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h),
                    RotationTransition(
                      turns: Tween(begin: 0.0, end: 1.0).animate(_animationController),
                      child: GradientCircularProgressIndicator(
                        radius: 16.w,
                        strokeWidth: 3.w,
                        gradientColors: [
                          for (int index = 0; index < 2; index++) ...[
                            // const Color(0xffF0F1F4),
                            AppColors.brown33,
                            AppColors.brown33.withAlpha(2),
                          ],
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      widget.loadingKey,
                      style: TextStyle(
                        color: AppColors.brown33,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientCircularProgressIndicator extends StatelessWidget {
  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;

  const GradientCircularProgressIndicator({
    super.key,
    required this.radius,
    required this.gradientColors,
    this.strokeWidth = 10.0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: GradientCircularProgressPainter(
        radius: radius,
        gradientColors: gradientColors,
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class GradientCircularProgressPainter extends CustomPainter {
  GradientCircularProgressPainter({
    required this.radius,
    required this.gradientColors,
    required this.strokeWidth,
  });

  final double radius;
  final List<Color> gradientColors;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    size = Size.fromRadius(radius);
    double offset = strokeWidth / 2;
    Rect rect = Offset(offset, offset) & Size(size.width - strokeWidth, size.height - strokeWidth);
    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    paint.shader = SweepGradient(colors: gradientColors, startAngle: 0.0, endAngle: 2 * math.pi).createShader(rect);
    canvas.drawArc(rect, 0.0, 2 * math.pi, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
