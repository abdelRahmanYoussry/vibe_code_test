import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/buttons/custom_container_button/custom_container_button.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class HomeNavLinksSection extends StatelessWidget {
  const HomeNavLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SpacingTheme.of(context).pagePadding,
      child: Row(
        spacing: 7.w,
        children: [
          for (final item in [
            (
              icon: Assets.icons.ticket.path,
              title: Loc.of(context).coupons,
              onPressed: () {
                Nav.coupons.push(context);
              }
            ),
            (
              icon: Assets.icons.coin.path,
              title: Loc.of(context).points,
              onPressed: () {
                Nav.points.push(context);
              }
            ),
            // (
            //   icon: Assets.icons.qr.path,
            //   title: Loc.of(context).qrCode,
            //   onPressed: () {
            //     Nav.qrCodes.push(context);
            //   }
            // ),
          ])
            Expanded(
              child: CustomContainerButton(
                onPressed: item.onPressed,
                label: item.title,
                icon: item.icon,
              ),
            ),
        ],
      ),
    );
  }
}
