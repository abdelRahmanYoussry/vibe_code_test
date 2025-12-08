import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/modules/app/orders/models/track_order_model.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/utils/functions.dart';
import 'active_order_details_theme.dart';
import 'order_progress_bar/order_progress_bar.dart';

class ActiveOrderDetails extends StatelessWidget {
  const ActiveOrderDetails({super.key, required this.model, required this.onAddMinutes, this.addMinutesLoading= false});
final TrackOrderModel model;
final Future<void> Function(int minutes) onAddMinutes;
final bool?addMinutesLoading;
  @override
  Widget build(BuildContext context) {
    final myTheme = ActiveOrderDetailsTheme.of(context);
    return Container(
      decoration: myTheme.backgroundDecoration,
      margin: SpacingTheme.of(context).pagePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Text(
              convertUtcToLocalTime(model.confirmedTime,'h:mm a'),
              style: myTheme.timeTextStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Text(
             model.statusMessage,
              style: myTheme.timeHintTextStyle,
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: OrderProgressBar(model:model ,),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Text(
              Loc.of(context).delay_option_hint,
              style: myTheme.delayHintTextStyle,
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13.w),
            child: Row(
              spacing: 8.w,
              children: [
                if (addMinutesLoading ?? false)
                  Expanded(
                    child: OutlinedButton(
                      style: myTheme.activeDelayButtonStyle,
                      onPressed: null,
                      child: SizedBox(
                        height: 20.h,
                        width: 20.h,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.w,
                          color: myTheme.activeDelayButtonStyle.backgroundColor?.resolve({}) ?? Colors.grey,
                        ),
                      ),
                    ),
                  )
                else
                  for (AddedTimeModel addedTime in model.addedTimes)
                    Expanded(
                      child: OutlinedButton(
                        style: (model.can_add_time && addedTime.flag)
                            ? myTheme.activeDelayButtonStyle
                            : myTheme.unActiveDelayButtonStyle,
                        onPressed: (model.can_add_time && addedTime.flag)
                            ? () {
                          onAddMinutes(addedTime.value);
                        }
                            : null,
                        child: Text(
                          Loc.of(context).addNMins(addedTime.value),
                          style: TextStyle(
                            color: (model.can_add_time && addedTime.flag)
                                ? myTheme.activeDelayButtonStyle.foregroundColor?.resolve({})
                                : myTheme.unActiveDelayButtonStyle.foregroundColor?.resolve({}),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          // Divider(),
          // SizedBox(height: 8.h),
          // Row(
          //   children: [
          //     Expanded(
          //       child: Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 13.w),
          //         child: Text(
          //           Loc.of(context).select_time,
          //           style: myTheme.selectTimeTextStyle,
          //         ),
          //       ),
          //     ),
          //     IconTheme(
          //       data: myTheme.selectTimeIconStyle,
          //       child: IconButton(
          //         onPressed: () {
          //           Nav.selectTimeSheet.sheet(context);
          //         },
          //         icon: Icon(
          //           Icons.more_time,
          //         ),
          //       ),
          //     ),
          //     SizedBox(width: 2.w),
          //   ],
          // ),
          // SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
