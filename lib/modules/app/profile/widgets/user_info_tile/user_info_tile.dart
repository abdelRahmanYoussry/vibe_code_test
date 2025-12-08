import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/core/widgets/user_selector/user_selector.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/utils/functions.dart';
import 'user_info_tile_theme.dart';

class UserInfoTile extends StatelessWidget {
  const UserInfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    final myTheme = UserInfoTileTheme.of(context);
    return UserSelector(
      builder: (context, user) {
        return Row(
          children: [
            SizedBox(width: SpacingTheme.of(context).pagePadding.horizontal / 2),
            ClipOval(
              child: Pic(
                user?.avatar ?? '',
                size: 44.w,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 11.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user?.name ?? 'User Name',
                    style: myTheme.titleTextStyle,
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    (validString(user?.phone)
                            ? formatPhoneNumber(user?.phone)
                            : validString(user?.email)
                                ? user?.email
                                : '') ??
                        'No contact info',
                    maxLines: 2,
                    style: myTheme.subtitleTextStyle,
                  ),
                ],
              ),
            ),
            IconButton(
              style: myTheme.gearButtonStyle,
              icon: Pic(
                Assets.icons.setting2.path,
                inherit: true,
              ),
              onPressed: () {
                Nav.settings.push(context);
              },
            ),
            SizedBox(width: 8.w),
          ],
        );
      },
    );
  }
}
