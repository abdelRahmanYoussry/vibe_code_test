import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../modules/app/home/widgets/home_appbar/widgets/home_appbar_actions/home_appbar_actions.dart';
import '../../assets/gen/assets.gen.dart';
import '../../navigation/nav.dart';
import '../../theme/constants/app_colors.dart';
import '../../utils/functions.dart';
import '../cart_selector/cart_selector.dart';

class AppBarTitleWithCart extends StatelessWidget {
  final String title;

  const AppBarTitleWithCart({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Spacer(),
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        Spacer(),
        CartSelector(
          builder: (context, cartCount) {
            return HomeAppBarActionButton(
              icon: Assets.icons.shoppingCart.path,
              badgeCount: cartCount,
              backgroundColor: AppColors.brown33,
              badgeColor: AppColors.red6E,
              iconColor: AppColors.white,
              width: isMobileDevice(context) ? 40.w : 30.w,
              height: isMobileDevice(context) ? 40.w : 30.w,
              iconSize: 18.sp,
              badgeFontSize: 10.sp,
              badgeMaxSize: 16,
              badgeMinSize: 14,
              padding: EdgeInsetsDirectional.symmetric(
                vertical: 4.h,
              ).add(
                EdgeInsetsDirectional.only(
                  start: 8.w,
                  end: 4.w,
                ),
              ),
              onPressed: () {
                Nav.cart.push(context);
              },
            );
          },
        ),
      ],
    );
  }
}
