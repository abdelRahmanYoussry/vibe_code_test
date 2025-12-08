import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/home_appbar_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'nav.dart';

abstract class SystemColors {
  // static void setStyleForPage(Nav page) {
  //   Future.delayed(Duration(seconds: 1), () {
  //     SystemChrome.setSystemUIOverlayStyle(getStyleFromPage(page));
  //   });
  // }

  static SystemUiOverlayStyle? getStyleFromPage(BuildContext context, Nav page) {
    final theme = Theme.of(context);
    final scaffoldBackgroundColor = theme.scaffoldBackgroundColor;
    final appBarBackgroundColor = theme.appBarTheme.backgroundColor ?? scaffoldBackgroundColor;
    final homeAppBarBackgroundColor = HomeAppbarTheme.of(context).appBarTheme.backgroundColor ?? appBarBackgroundColor;
    final bottomNavigationBarColor = theme.bottomNavigationBarTheme.backgroundColor ?? scaffoldBackgroundColor;
    switch (page) {
      case Nav.login:
      case Nav.otp:
      case Nav.registerOTP:
      case Nav.confirmProfilePage:
      case Nav.confirmNamePage:
      case Nav.failedPaymentPage:
      case Nav.confirmPaymentPage:
      case Nav.checkPaymentStatusPage:
      case Nav.signUp:
      case Nav.password:
        return buildStyle(
          statusBarColor: scaffoldBackgroundColor,
          navigationBarColor: scaffoldBackgroundColor,
        );
      case Nav.offers:
      case Nav.products:
      case Nav.allTopRequestedProducts:
      case Nav.newlyReleasedProducts:
      case Nav.spinnerProductPage:
      case Nav.chooseTwoProductsPage:
      case Nav.rewardProductsPage:
      case Nav.allSignaturesProducts:
      case Nav.notifications:
      case Nav.notificationPermission:
      // return buildStyle(
      //    statusBarColor: appBarBackgroundColor,
      //    navigationBarColor: scaffoldBackgroundColor,
      // ) ;
      case Nav.qrCodes:
      case Nav.coupons:
      case Nav.points:
      case Nav.balance:
      case Nav.forceUpdate:
      case Nav.branches:
      case Nav.search:
      case Nav.spinners:
      case Nav.splash:
      case Nav.spinner:
      case Nav.settings:
        return buildStyle(
          statusBarColor: appBarBackgroundColor,
          navigationBarColor: scaffoldBackgroundColor,
        );
      case Nav.orders:
      case Nav.profile:
      case Nav.product:
      case Nav.productDetails:
      case Nav.offerDetailsPage:
      case Nav.cart:
        return buildStyle(
          statusBarColor: appBarBackgroundColor,
          navigationBarColor: bottomNavigationBarColor,
        );
      case Nav.editOder:
        return buildStyle(
          statusBarColor: scaffoldBackgroundColor,
          navigationBarColor: bottomNavigationBarColor,
        );
      case Nav.home:
        return buildStyle(
          statusBarColor: homeAppBarBackgroundColor,
          navigationBarColor: bottomNavigationBarColor,
        );
      case Nav.addCommentSheet:
      case Nav.qrSheet:
      case Nav.selectTimeSheet:
      case Nav.selectLangSheet:
      case Nav.deleteAccountSheet:
      case Nav.spinnerRewardSheet:
        return buildStyle(
          statusBarColor: Colors.transparent,
          navigationBarColor: scaffoldBackgroundColor,
        );
      case Nav.alertDialog:
        return buildStyle(
          statusBarColor: Colors.transparent,
          navigationBarColor: Colors.transparent,
        );
      case Nav.changeBranchDialog:
        return buildStyle(
          statusBarColor: Colors.transparent,
          navigationBarColor: Colors.transparent,
        );
      case Nav.root:
        return null;
      case Nav.paymentMethods:
        return buildStyle(
          statusBarColor: appBarBackgroundColor,
          navigationBarColor: bottomNavigationBarColor,
        );
      case Nav.menus:
      case Nav.categoryProducts:
      case Nav.subCategories:
      case Nav.addCreditCard:
        return buildStyle(
          statusBarColor: appBarBackgroundColor,
          navigationBarColor: scaffoldBackgroundColor,
        );
      case Nav.onBoarding:
      case Nav.productDetailsSheet:
      case Nav.recentlyTransaction:
      case Nav.paymentWebView:

    }
    return null;
  }

  static SystemUiOverlayStyle? getStyleFromCurrentPage(BuildContext context) {
    final currentPage = validateEnumNullable(Nav.values, ModalRoute.of(context)?.settings.name);
    if (currentPage != null) {
      return getStyleFromPage(context, currentPage);
    }
    return null;
  }

  static SystemUiOverlayStyle buildStyle({
    required Color statusBarColor,
    required Color navigationBarColor,
  }) =>
      SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarBrightness: ThemeData.estimateBrightnessForColor(statusBarColor),
        statusBarIconBrightness: ThemeData.estimateBrightnessForColor(statusBarColor) == Brightness.dark ? Brightness.light : Brightness.dark,
        // systemStatusBarContrastEnforced: false,
        systemNavigationBarColor: navigationBarColor,
        systemNavigationBarDividerColor: navigationBarColor,
        systemNavigationBarIconBrightness: ThemeData.estimateBrightnessForColor(navigationBarColor) == Brightness.dark ? Brightness.light : Brightness.dark,
        // systemNavigationBarContrastEnforced: false,
      );
}
