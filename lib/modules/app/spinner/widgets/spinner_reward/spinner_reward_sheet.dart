import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/utils/functions.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/core/widgets/sheets/custom_sheet/custom_sheet.dart';
import 'package:test_vibe/modules/app/spinner/widgets/spinner_reward/spinner_reward_sheet_params.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'spinner_reward_theme.dart';

class SpinnerRewardSheet extends StatelessWidget {
  const SpinnerRewardSheet({
    super.key,
    required this.params,
  });

  final SpinnerRewardSheetParams params;


  @override
  Widget build(BuildContext context) {
    final myTheme = SpinnerRewardTheme.of(context);
    return CustomSheet(
      builder: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 24.h),
          Text(
            Loc.of(context).congratulations,
            style: myTheme.labelTextStyle,
          ),
          SizedBox(height: 4.h),
          Text(
            Loc.of(context).youHaveWon,
            style: myTheme.titleTextStyle,
          ),
          SizedBox(height: 0.h),
          Pic(
            Assets.images.cup.path,
            height: 100.h,
            width: 100.h,
          ),
          SizedBox(height: 0.h),
          AutoSizeText(
            params.result.rewardName?? '',
            style: myTheme.rewardNameTextStyle,
            stepGranularity: 1.sp,
            minFontSize: 8.sp,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () async {
                    final result = await Nav.alert(
                      context,
                      message: Loc.of(context).cancel_reward_message,
                      messageDescription: Loc.of(context).cancel_reward_message_desc,
                    );
                    if (result && context.mounted) {
                      Nav.root.popUntil(context);
                    }
                  },
                  child: Text(Loc.of(context).cancel),
                ),
              ),
              SizedBox(width: 10.w),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    // SpinnerProductsPageParams args = SpinnerProductsPageParams(
                    //   title: Loc.of(context).spinner_products,
                    //   bloc: params.bloc,
                    // );
                    //todo claim reward
                    // Nav.root.popUntil(context);
                  handleSpinnerResult(context, params);
                  },
                  child: Text(params.result.btn_title?? Loc.of(context).claim),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
