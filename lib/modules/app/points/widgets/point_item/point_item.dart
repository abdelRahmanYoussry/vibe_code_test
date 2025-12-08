import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/utils/math_utils.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/utils/functions.dart';
import '../../models/point_model_new.dart';
import 'point_item_theme.dart';

class PointItem extends StatelessWidget {
  const PointItem({
    super.key,
    required this.model,
  });

  final LoyaltyPointEntry model;

  @override
  Widget build(BuildContext context) {
    final myTheme = PointItemTheme.of(context);
    final isUp = model.action == 'earn' || model.action == 'transfer_in';
    return Column(
      children: [
        Row(
          spacing: 8.w,
          children: [
            Expanded(
              child: Text(
                validString(model.description)?model.description!:
                isUp ? Loc.of(context).earn_points : Loc.of(context).use_points,
                style: myTheme.titleTextStyle,
              ),
            ),
            Text(
              isUp
                  ? model.points == 0
                      ? model.points.withDecimals(1)
                      : '+${model.points.withDecimals(1)}'
                  : '-${model.points.withDecimals(1)}',
              style: isUp ? myTheme.priceUpTextStyle : myTheme.priceDownTextStyle,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          spacing: 8.w,
          children: [
            Expanded(
              child: Text(
                convertUtcToLocalTime(model.date,'MMM d, yyyy h:mm a'),
                style: myTheme.dateTextStyle,
              ),
            ),
            Text(
              '${Loc.of(context).points}: ${model.points}',
              style: myTheme.pointsTextStyle,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Divider(),
      ],
    );
  }
}
