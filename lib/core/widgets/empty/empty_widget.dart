import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../assets/gen/assets.gen.dart';



class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, this.title, this.icon, this.iconColor});

  final String? title;
  final String? icon;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20.h),
        Pic(
          icon ?? Assets.icons.noData.path,
          height: 100.h,
          width: 100.h,
          color: iconColor ?? AppColors.grey9E,
        ),
        SizedBox(height: 30.h),
        EmptyTextWidget(
          title: title ??Loc.of(context).no_recorded_data_found,
          color: iconColor?? AppColors.grey9E,
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}

class EmptyTextWidget extends StatelessWidget {
  const EmptyTextWidget({super.key, required this.title, this.color});

  final String title;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center ,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 20.sp,
        color: color ?? AppColors.grey9E.withAlpha(8),
      ),
    );
  }
}
