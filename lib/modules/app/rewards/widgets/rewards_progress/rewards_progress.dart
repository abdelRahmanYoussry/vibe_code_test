import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/modules/app/rewards/widgets/reward_item/reward_item.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/navigation/nav.dart';
import '../reward_products/reward_products_page_params.dart';
import 'rewards_progress_theme.dart';

class RewardsProgress extends StatelessWidget {
  const RewardsProgress({
    super.key,
    required this.max,
    required this.progress,
  });

  final int max;
  final int progress;

  @override
  Widget build(BuildContext context) {
    final myTheme = RewardsProgressTheme.of(context);
    return Container(
      decoration: myTheme.backgroundContainerDecoration,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 20.w),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(
              max + 1,
              (index) => Expanded(
                child: Padding(
                  padding: EdgeInsets.only(bottom: index % 2 == 0 ? 0 : 16.h),
                  child: RewardItemNew(
                    max: max,
                    progress: progress,
                    active: index == max,
                    index: index,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          if (progress <= max)
            CustomElevatedButton(
              style: myTheme.buttonStyle.copyWith(
                backgroundColor: progress == max ? WidgetStatePropertyAll(AppColors.green34) : null,
              ),
              enabled: progress == max,
              child: Text(Loc.of(context).claim_your_free_cup),
              onPressed: () {
                RewardProductsPageParams args = RewardProductsPageParams(
                  title: Loc.of(context).choose_your_reward,
                );
                Nav.rewardProductsPage.push(context, args: args);
              },
            ),
        ],
      ),
    );
  }
}
