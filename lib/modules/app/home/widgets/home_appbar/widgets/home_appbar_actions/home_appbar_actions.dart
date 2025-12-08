import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/core/utils/functions.dart';
import 'package:test_vibe/core/widgets/buttons/custom_ink_response.dart';
import 'package:test_vibe/core/widgets/cart_selector/cart_selector.dart';
import 'package:test_vibe/core/widgets/notifications_selector/notifications_selector.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/bloc/home_app_bar_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../../../core/di/di.dart';
import '../../bloc/home_app_bar_state.dart';
import 'home_appbar_actions_theme.dart';

class HomeAppbarActions extends StatelessWidget {
  const HomeAppbarActions({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<HomeAppBarBloc>()..checkNotificationPermission(),
      child: BlocBuilder<HomeAppBarBloc, HomeAppBarState>(
        builder: (context, state) {
          return Row(
            children: [
              CartSelector(
                builder: (context, cartCount) {
                  return HomeAppBarActionButton(
                    icon: Assets.icons.shoppingCart.path,
                    badgeCount: cartCount,
                    width: isMobileDevice(context)? 45.w:30.w,
                    height: isMobileDevice(context)? 45.w:30.w,
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
              BlocSelector<HomeAppBarBloc, HomeAppBarState, bool>(
                selector: (state) => state.checkNotificationPermissionState.isGranted,
                builder: (context, state) {
                  return NotificationsSelector(
                    builder: (context, notificationsCount) => HomeAppBarActionButton(
                      badgeCount: notificationsCount ,
                      icon: Assets.icons.notification.path,
                      width: isMobileDevice(context)? 45.w:30.w,
                      height: isMobileDevice(context)? 45.w:30.w,
                      padding: EdgeInsetsDirectional.symmetric(
                        vertical: 4.h,
                      ).add(
                        EdgeInsetsDirectional.only(
                          start: 4.w,
                          end: 8.w,
                        ),
                      ),
                      onPressed: () {
                        Nav.notifications.push(context);
                        // if (!state) {
                        //   Nav.notificationPermission.replace(context);
                        // } else {
                        //   Nav.notifications.push(context);
                        // }
                      },
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class HomeAppBarActionButton extends StatelessWidget {
  const HomeAppBarActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.width,
    this.height,
    this.padding,
    this.badgeCount,
    this.backgroundColor,
    this.badgeColor,
    this.iconColor,
    this.iconSize,
    this.badgeFontSize,
    this.badgeMinSize,
    this.badgeMaxSize,
  });

  final VoidCallback onPressed;
  final String icon;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final int? badgeCount;
  final Color? backgroundColor;
  final Color? badgeColor;
  final Color? iconColor;
  final double? iconSize;
  final double ?badgeMinSize ;
  final double ?badgeMaxSize ;
  final double ?badgeFontSize ;
  @override
  Widget build(BuildContext context) {
    return CustomInkResponse(
      onPressed: onPressed,
      padding: padding,
      child: Stack(
        children: [
          Container(
            width: width ?? 40.w,
            height: height ?? 40.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color:backgroundColor??  HomeAppbarActionsTheme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Pic(
              icon,
              width: iconSize ?? 21.sp,
              color: iconColor ?? HomeAppbarActionsTheme.of(context).foregroundColor,
            ),
          ),
          if (badgeCount != null && badgeCount! > 0)
            Positioned(
              right: 1.w,
              top: 2.h,
              child: Container(
                padding: const EdgeInsets.all(1),
                decoration: BoxDecoration(
                  color: badgeColor ?? AppColors.brown33,
                  borderRadius: BorderRadius.circular(8),
                ),
                constraints:  BoxConstraints(
                  minWidth: badgeMinSize?? 16,
                  minHeight: badgeMinSize?? 16,
                ),
                child: Text(
                  '$badgeCount',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: badgeFontSize ?? 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
