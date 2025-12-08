import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/buttons/custom_ink_response.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'social_login_section_theme.dart';

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({
    super.key,
    required this.onGoogleLogin,
    required this.onAppleLogin,
  });
  final VoidCallback onGoogleLogin;
  final VoidCallback onAppleLogin;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Text(
            Loc.of(context).or_sign_in_with,
            style: SocialLoginSectionTheme.of(context).headerStyle,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (final socialButton in [
                (
                  icon: Assets.images.google.path,
                  onPressed: () {
                    onGoogleLogin();
                  }
                ),
                // (
                //   icon: Assets.icons.facebook.path,
                //   onPressed: () {
                //     //todo login facebook
                //   }
                // ),
                (
                  icon: Assets.images.apple.path,
                  onPressed: () {
                    onAppleLogin();
                  }
                ),
              ])
                CustomInkResponse(
                  onPressed: socialButton.onPressed,
                  child: Pic(socialButton.icon),
                ),
            ],
          ),
        ),
        // Row(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     Padding(
        //       padding: EdgeInsetsDirectional.only(end: 0.w),
        //       child: Text(
        //         Loc.of(context).dont_have_account,
        //         style: SocialLoginSectionTheme.of(context).registerLabelStyle,
        //       ),
        //     ),
        //     CustomInkWell(
        //       onPressed: () {
        //         //todo register page
        //       },
        //       padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
        //       child: Text(
        //         Loc.of(context).sign_up,
        //         style: SocialLoginSectionTheme.of(context).registerButtonStyle?.textStyle?.resolve({...WidgetState.values}),
        //       ),
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
