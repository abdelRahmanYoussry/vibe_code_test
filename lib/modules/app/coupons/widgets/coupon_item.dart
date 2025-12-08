import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/theme/constants/app_colors.dart';
import '../../../../core/widgets/snack_bar/snack_bar.dart';
import '../../check_out/models/coupons_model.dart';
import 'coupon_border.dart';
import 'coupon_item_theme.dart';

class CouponItem extends StatelessWidget {
  const CouponItem({
    super.key,
    required this.model,
  });

  final CouponModel model;

  @override
  Widget build(BuildContext context) {
    final myTheme = CouponItemTheme.of(context);
final type = model.typeOption;
double value = model.value;
String showAmount = '';
if(type == 'percentage') {
  value = value ;
  showAmount = 'Get ${value.toStringAsFixed(0)}% off';
} else if (type == 'amount') {
  value = value; // Assuming the amount is in cents, convert to dollars
  showAmount = 'Get ${value.toStringAsFixed(0)} AED off';
}else{
  showAmount = 'Get ${value.toStringAsFixed(0)} off';
}
    return CouponBorder(
      bottomOffset: 37.h + 8.h + 21.h + 25.h / 2,
      borderSide: myTheme.backgroundDecoration.border?.top,
      child: Container(
        decoration: myTheme.backgroundDecoration,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: SelectableText(
                    model.code,
                    style: myTheme.titleTextStyle,
                  ),
                ),
                SizedBox(height: 4.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: SelectableText(
                    model.description??Loc.of(context).no_description,
                    style: myTheme.bodyTextStyle,
                  ),
                ),
                SizedBox(height: 25.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.w),
                  child: SizedBox(
                    height: 21.h,
                    child: Row(
                      children: [
                        Pic(
                          Assets.icons.discount.path,
                          size: myTheme.discountIconStyle.size,
                          color: myTheme.discountIconStyle.color,
                        ),
                        SizedBox(width: 4.w),
                        SelectableText(
                          showAmount,
                          maxLines: 1,
                          style: myTheme.discountTextStyle,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  height: 37.h,
                  child: Material(
                    color: myTheme.copyButtonBackground.color,
                    child: InkWell(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: model.code));
                        SnackBarBuilder.showFeedBackMessage(context,
                          Loc.of(context).code_copied,
                        );
                      },
                      child: Center(
                        child: Text(
                          Loc.of(context).copy_code,
                          style: myTheme.copyButtonTextStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: CustomPaint(
                  painter: DashedLinePainter(
                    color:AppColors.greyF5,
                    dashWidth: 10.w,
                dashHeight: 5.h  ,
                    dashSpace: 10.w,
                    borderColor: AppColors.greyD9,
                    borderWidth: 1.0,
                  ),
                  size: Size(double.infinity, 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 357.w,
    mainAxisExtent: 153.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}

class DashedLinePainter extends CustomPainter {
  final Color color;
  final double dashWidth;
  final double dashSpace;
  final double dashHeight;
  final Color borderColor;
  final double borderWidth;

  DashedLinePainter({
    required this.color,
    required this.dashWidth,
    required this.dashSpace,
    required this.dashHeight,
    this.borderColor = Colors.grey,
    this.borderWidth = 1.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    double startX = 0;
    final double endX = size.width;
    final double centerY = size.height / 2;

    // Position the dash vertically centered
    final double topY = centerY - (dashHeight / 2);

    while (startX < endX) {
      final rect = Rect.fromLTWH(startX, topY, dashWidth, dashHeight);

      // Draw the filled rectangle
      canvas.drawRect(rect, fillPaint);

      // Draw the border
      canvas.drawRect(rect, borderPaint);

      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
