import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/profile/widgets/user_info_tile/user_info_tile.dart';
import 'package:test_vibe/modules/app/root/bloc/root_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:size_config/size_config.dart';

import 'widgets/profile_action_tile/profile_action_tile.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      overridePageName: Nav.profile,
      appBar: CustomAppbar(
        title: Text(Loc.of(context).profile),
        elevated: false,
        overridePageName: Nav.profile,
        showBackButton: false ,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 32.h),
            UserInfoTile(),
            SizedBox(height: 32.h),
            Padding(
              padding: SpacingTheme.of(context).pagePadding,
              child: Column(
                spacing: 16.h,
                children: [
                  for (final item in [
                    (
                      title: Loc.of(context).my_orders,
                      icon: Assets.icons.notes.path,
                      onPressed: () => RootBloc.of(context).changePage(RootIndex.orders),
                    ),
                    (
                    title: Loc.of(context).balance,
                    icon: Assets.icons.cash.path,
                    onPressed: () => Nav.balance.push(context),
                    ),
                    (
                      title: Loc.of(context).coupons,
                      icon: Assets.icons.ticket.path,
                      onPressed: () => Nav.coupons.push(context),
                    ),
                    (
                      title: Loc.of(context).points,
                      icon: Assets.icons.coin.path,
                      onPressed: () => Nav.points.push(context),
                    ),
                    // (
                    //   title: Loc.of(context).qrCode,
                    //   icon: Assets.icons.qr.path,
                    //   onPressed: () => Nav.qrCodes.push(context),
                    // ),
                    (
                      title: Loc.of(context).spin_and_win,
                      icon: Assets.icons.spinner.path,
                      onPressed: () => Nav.spinners.push(context),
                    ),
                  ])
                    ProfileActionTile(
                      title: Text(item.title),
                      leading: Pic(item.icon, inherit: true),
                      trailing: Icon(CupertinoIcons.right_chevron),
                      onPressed: item.onPressed,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
