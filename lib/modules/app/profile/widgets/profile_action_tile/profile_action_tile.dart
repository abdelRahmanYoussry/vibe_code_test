import 'package:test_vibe/modules/app/profile/widgets/profile_action_tile/profile_action_tile_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class ProfileActionTile extends StatelessWidget {
  const ProfileActionTile({
    super.key,
    this.title,
    this.leading,
    this.trailing,
    this.onPressed,
  });

  final Widget? title;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final myTheme = ProfileActionTileTheme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onPressed,
      child: Container(
        decoration: myTheme.boxDecoration,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Row(
          children: [
            SizedBox(width: 16.w),
            if (leading != null)
              IconTheme(
                data: myTheme.leadingIconThemeData,
                child: SizedBox(
                  width: myTheme.leadingIconThemeData.size,
                  child: leading!,
                ),
              ),
            SizedBox(width: 8.w),
            if (title != null)
              Expanded(
                child: DefaultTextStyle(
                  style: myTheme.labelStyle,
                  child: title!,
                ),
              ),
            if (trailing != null)
              IconTheme(
                data: myTheme.trailingIconThemeData,
                child: DefaultTextStyle(
                  style: myTheme.trailingTextStyle,
                  child: trailing!,
                ),
              ),
            SizedBox(width: 8.w),
          ],
        ),
      ),
    );
  }
}
