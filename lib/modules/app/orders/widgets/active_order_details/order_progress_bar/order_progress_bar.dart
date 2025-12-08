import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/orders/models/track_order_model.dart';
import 'package:test_vibe/modules/app/orders/widgets/active_order_details/order_progress_bar/widgets/progress_dash.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../../core/utils/functions.dart';
import 'order_progress_bar_theme.dart';

class OrderProgressBar extends StatelessWidget {
  final TrackOrderModel model;

  const OrderProgressBar({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final myTheme = OrderProgressBarTheme.of(context);

    final items = <({
      BoxDecoration decoration,
      String? label,
      TextStyle? labelStyle,
      Widget child,
    })>[
      // Confirmed state
      (
        decoration: myTheme.checkBackgroundDecoration.copyWith(color: model.isConfirmed ? Colors.green : Colors.amber),
        label: convertUtcToLocalTime(model.confirmedTime, 'h:mm a'),
        labelStyle: myTheme.distanceLabelTextStyle,
        child: model.isConfirmed
            ? IconTheme(
                data: myTheme.checkIconStyle,
                child: Icon(Icons.check),
              )
            : Pic(
                Assets.images.cup.path,
                height: 30.h,
              ),
      ),
      // Preparing state
      (
        decoration: model.isPreparing ? myTheme.checkBackgroundDecoration : myTheme.distanceBackgroundDecoration,
        label: model.isPreparing
            ? convertUtcToLocalTime(model.preparationAt, 'h:mm a')
            : '${model.estimatedPreparationMinutes}m',
        labelStyle: model.isPreparing ? myTheme.timeLabelTextStyle : myTheme.distanceLabelTextStyle,
        child: model.isPreparing
            ? IconTheme(
                data: myTheme.checkIconStyle,
                child: Icon(Icons.check),
              )
            : Pic(
                Assets.images.cup.path,
                height: 30.h,
              ),
      ),
      // Ready state
      (
        decoration: model.isReady ? myTheme.checkBackgroundDecoration : myTheme.readyBackgroundDecoration,
        label: model.isReady
            ? convertUtcToLocalTime(model.estimatedReadyTime, 'h:mm a')
            : convertUtcToLocalTime(model.estimatedReadyTime, 'h:mm a'),
        labelStyle: myTheme.timeLabelTextStyle,
        child: model.isReady
            ? IconTheme(
                data: myTheme.checkIconStyle,
                child: Icon(Icons.check),
              )
            : IconTheme(
                data: myTheme.checkIconStyle,
                child: Pic(
                  Assets.icons.location.path,
                  height: 30.h,
                  color: Colors.white,
                ),
              ),
      ),
    ];

    final circleSize = 35.w;

    return IntrinsicHeight(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: circleSize * 1.075,
            right: circleSize * 1.075,
            top: circleSize / 2,
            child: ProgressDash(
              color: myTheme.progressDashColor,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (final item in items)
                Column(
                  children: [
                    Container(
                      width: circleSize,
                      height: circleSize,
                      decoration: item.decoration,
                      alignment: Alignment.center,
                      child: item.child,
                    ),
                    if (item.label != null)
                      Padding(
                        padding: EdgeInsets.only(top: 5.h),
                        child: Text(
                          item.label!,
                          maxLines: 1,
                          style: item.labelStyle,
                        ),
                      )
                    else
                      Spacer(),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
