import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'total_points_overview_theme.dart';

class TotalPointsOverview extends StatefulWidget {
   const TotalPointsOverview({super.key, required this.totalPoints, required this.totalPointsDesc});
final String totalPoints;
final String totalPointsDesc;

  @override
  State<TotalPointsOverview> createState() => _TotalPointsOverviewState();
}

class _TotalPointsOverviewState extends State<TotalPointsOverview> {
  @override
  Widget build(BuildContext context) {
    final myTheme = TotalPointsOverviewTheme.of(context);
    debugPrint('TotalPointsOverview: totalPoints=${widget.totalPoints}, totalPointsDesc=${widget.totalPointsDesc}');
    return Container(
      decoration: myTheme.backgroundDecoration,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
      child: Row(
        children: [
          Pic(
            Assets.icons.coin.path,
            size: myTheme.iconStyle.size,
            color: myTheme.iconStyle.color,
          ),
          SizedBox(width: 10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Loc.of(context).total_coffees_point,
                style: myTheme.titleTextStyle,
              ),
              Text(
                widget.totalPoints,
                style: myTheme.pointsTextStyle,
              ),
              Text(
                widget.totalPointsDesc,
                style: myTheme.descTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
