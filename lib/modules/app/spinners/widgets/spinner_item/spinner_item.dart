import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/utils/date_time_utils.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/spinners/models/spinner_model_new.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'spinner_item_theme.dart';

class SpinnerItem extends StatelessWidget {
  const SpinnerItem({
    super.key,
    required this.model,
  });

  final SpinnerModel model;

  @override
  Widget build(BuildContext context) {
    final myTheme = model.available ? SpinnerItemTheme.of(context).available : SpinnerItemTheme.of(context).unavailable;
    final duration = parseRemainingTime(model.duration);
    final hours = duration.inHours;
    final minutes = duration.inMinutes % 60;
    debugPrint('hours $hours minutes $minutes');
    debugPrint('duration $duration');
    debugPrint('${model.available}available');
    return Container(
      decoration: myTheme.boxDecoration,
      child: IntrinsicHeight(
        child: Row(
          children: [
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16.h),
                  Container(
                    decoration: myTheme.labelBoxDecoration,
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    child: Text(
                      model.label,
                      style: myTheme.labelTextStyle,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    model.title??'Spin & Win',
                    style: myTheme.titleTextStyle,
                  ),
                  Text(
                    model.desc * 2,
                    maxLines: 3,
                    style: myTheme.descTextStyle,
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    style: myTheme.buttonStyle,
                    onPressed: !model.available
                        ? null
                        : () {
                            Nav.spinner.push(context, args: model);
                          },
                    child: model.available ? Text(Loc.of(context).try_your_luck) : Text(Loc.of(context).unlock_h_m(hours, minutes)),
                  ),
                  SizedBox(height: 12.h),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.bottomEnd,
                child: Pic(
                  myTheme.image,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 358.w,
    mainAxisExtent: 172.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 16.h,
  );
}
