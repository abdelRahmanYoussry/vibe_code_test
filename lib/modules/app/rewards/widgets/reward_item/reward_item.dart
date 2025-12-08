import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'reward_item_theme.dart';

class RewardItem extends StatelessWidget {
  const RewardItem({
    super.key,
    required this.active,
    required this.label,
  });

  final bool active;
  final String label;

  @override
  Widget build(BuildContext context) {
    final myTheme = RewardItemTheme.of(context);
    return IconTheme(
      data: myTheme.iconThemeData,
      child: Column(
        spacing: 8.h,
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            alignment: Alignment.center,
            decoration: myTheme.iconContainerDecoration,
            child: active
                ? Icon(
                    Icons.check,
                  )
                : Pic(
                    Assets.images.cup.path,
                    height: 40.h,
                  ),
          ),
          Text(
            label,
            style: myTheme.labelStyle,
          ),
        ],
      ),
    );
  }
}

class RewardItemNew extends StatelessWidget {
  const RewardItemNew({
    super.key,
    required this.active,
    required this.progress,
    required this.max,
   required this.index,
  });
  final bool active;
  final int max;
  final int progress;
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Pic(
            !active ? Assets.images.drink.path : Assets.images.freeDrink.path,
            fit: BoxFit.fill,
          ),
          if (index < progress)
          Icon(
            Icons.check,
          ),
        ],
      ),
    );
  }
}
