import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/branches/models/branch_model.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'branch_item_theme.dart';

class BranchItem extends StatelessWidget {
  const BranchItem({
    super.key,
    required this.model,
    this.checked,
    this.onTap,
  });

  final BranchModel model;
  final bool? checked;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final myTheme = BranchItemTheme.of(context);
    final child = Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Pic(
              Assets.icons.location.path,
              size: myTheme.iconThemeData.size,
              color: myTheme.iconThemeData.color,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name,
                    style: myTheme.titleTextStyle,
                  ),
                  Text(
                    '${model.city}, ${model.address}',
                    maxLines: 3,
                    style: myTheme.subtitleTextStyle,
                  ),
                ],
              ),
            ),
            if (checked != null)
              Pic(
                checked == true ? Assets.icons.radioActive.path : Assets.icons.radioInactive.path,
              ),
          ],
        ),
        SizedBox(height: 16.h),
        Divider(),
        SizedBox(height: 16.h),
      ],
    );
    if (onTap != null) {
      return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: child,
      );
    }
    return child;
  }
}
