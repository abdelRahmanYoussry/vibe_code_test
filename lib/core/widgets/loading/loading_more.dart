import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:size_config/size_config.dart';

class LoadingMore extends StatelessWidget {
  const LoadingMore({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
              width: 20.h,
              child: CircularProgressIndicator(
                strokeWidth: 2.w,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              Loc.of(context).loading_more,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.red6E,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ).animate().fade(duration: 300.ms);
  }
}
