import 'package:country_picker/country_picker.dart';
import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/components/page_header/page_header_theme.dart';
import 'package:test_vibe/core/components/page_label/page_label_theme.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/core/theme/constants/app_fonts.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/utils/widget_utils.dart';
import 'package:test_vibe/core/widgets/buttons/custom_container_button/custom_container_button_theme.dart';
import 'package:test_vibe/core/widgets/dialogs/custom_alert_dialog/custom_alert_dialog_theme.dart';
import 'package:test_vibe/core/widgets/dialogs/custom_dialog/custom_dialog_theme.dart';
import 'package:test_vibe/core/widgets/fields/coupon_field/coupon_field_theme.dart';
import 'package:test_vibe/core/widgets/fields/otp_field/otp_field_theme.dart';
import 'package:test_vibe/core/widgets/fields/phone_field/phone_country_picker_theme.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/core/widgets/quantity_counter/quantity_counter_theme.dart';
import 'package:test_vibe/core/widgets/section_label/section_label_theme.dart';
import 'package:test_vibe/core/widgets/sheets/custom_sheet/custom_sheet_theme.dart';
import 'package:test_vibe/modules/app/branches/widgets/branch_item/branch_item_theme.dart';
import 'package:test_vibe/modules/app/cart/widgets/cart_overview_section/cart_overview_section_theme.dart';
import 'package:test_vibe/modules/app/cart/widgets/cart_product_item/cart_product_item_theme.dart';
import 'package:test_vibe/modules/app/categories/widgets/category_item/category_item_theme.dart';
import 'package:test_vibe/modules/app/check_out/widgets/payment_method_theme.dart';
import 'package:test_vibe/modules/app/coupons/widgets/coupon_item_theme.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/home_appbar_theme.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/widgets/home_appbar_actions/home_appbar_actions_theme.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/widgets/my_location_widget/my_location_widget_theme.dart';
import 'package:test_vibe/modules/app/notifications/widgets/notification_item/notification_item_theme.dart';
import 'package:test_vibe/modules/app/notifications/widgets/notification_permission/notification_permission_theme.dart';
import 'package:test_vibe/modules/app/offers/widgets/offer_item/offer_item_theme.dart';
import 'package:test_vibe/modules/app/offers/widgets/offers_carousel/offers_carousel_theme.dart';
import 'package:test_vibe/modules/app/orders/widgets/active_order_details/active_order_details_theme.dart';
import 'package:test_vibe/modules/app/orders/widgets/active_order_details/order_progress_bar/order_progress_bar_theme.dart';
import 'package:test_vibe/modules/app/points/widgets/point_item/point_item_theme.dart';
import 'package:test_vibe/modules/app/points/widgets/total_points_overview/total_points_overview_theme.dart';
import 'package:test_vibe/modules/app/product/widgets/add_cart_section/add_cart_section_theme.dart';
import 'package:test_vibe/modules/app/product/widgets/add_comment/add_comment_header/add_comment_header_theme.dart';
import 'package:test_vibe/modules/app/product/widgets/product_customization/product_customization_theme.dart';
import 'package:test_vibe/modules/app/product/widgets/product_info_widget/product_info_widget_theme.dart';
import 'package:test_vibe/modules/app/products/widgets/horizontal_product_item/horizontal_product_item_theme.dart';
import 'package:test_vibe/modules/app/products/widgets/plain_product_item/plain_product_item_theme.dart';
import 'package:test_vibe/modules/app/products/widgets/product_item_with_add_button/product_item_with_add_button_theme.dart';
import 'package:test_vibe/modules/app/profile/widgets/profile_action_tile/profile_action_tile_theme.dart';
import 'package:test_vibe/modules/app/profile/widgets/user_info_tile/user_info_tile_theme.dart';
import 'package:test_vibe/modules/app/qr_codes/widgets/qr_product_item/qr_product_item_theme.dart';
import 'package:test_vibe/modules/app/rewards/widgets/reward_item/reward_item_theme.dart';
import 'package:test_vibe/modules/app/rewards/widgets/rewards_progress/rewards_progress_theme.dart';
import 'package:test_vibe/modules/app/root/widgets/root_bottom_navbar/root_bottom_navbar_theme.dart';
import 'package:test_vibe/modules/app/search/widgets/recent_search_item/recent_search_item_theme.dart';
import 'package:test_vibe/modules/app/spinner/widgets/spinner/spinner_theme.dart';
import 'package:test_vibe/modules/app/spinner/widgets/spinner_reward/spinner_reward_theme.dart';
import 'package:test_vibe/modules/app/spinners/widgets/spinner_item/spinner_item_theme.dart';
import 'package:test_vibe/modules/auth/login/widgets/social_login_section/social_login_section_theme.dart';
import 'package:test_vibe/modules/auth/otp/widgets/resend_otp_section/resend_otp_section_theme.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:size_config/size_config.dart';

import '../../../modules/app/add_credit_card/add_credit_card_theme.dart';
import '../../../modules/app/categories/widgets/plain_menu_item/plain_menu_item_theme.dart';

double get kDefaultButtonHeight => 54.h;

double get kDefaultAppBarHeight => 56.h;

double get kDefaultInputFieldHeight => 45.h;

ThemeData buildLightTheme() {
  final colorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: AppColors.brown33,
    primaryContainer: AppColors.brown33,
    onPrimary: AppColors.white,
    onPrimaryContainer: AppColors.white,
    secondary: AppColors.yellowF5_50p,
    onSecondary: AppColors.black,
    error: AppColors.redD1,
    onError: AppColors.white,
    surface: AppColors.yellowFC,
    onSurface: AppColors.black,
  );

  final inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.greyD9_59p, width: 1),
  );
  final focusedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.greyD9_59p, width: 1),
  );
  final errorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.redD1, width: 1),
  );
 final snackBarTheme = SnackBarThemeData(
    backgroundColor: AppColors.brown33,
    contentTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      height: 21.sp,
      letterSpacing: -.32.sp,
      color: AppColors.white,
    ),
   insetPadding:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
   shape: RoundedRectangleBorder(
     borderRadius: BorderRadius.circular(50),
   ),
   elevation: 0,

 );

  final inputDecorationTheme = InputDecorationTheme(
    filled: false,
    fillColor: AppColors.greyE2,
    border: inputBorder,
    disabledBorder: inputBorder,
    enabledBorder: inputBorder,
    focusedBorder: focusedInputBorder,
    errorBorder: errorInputBorder,
    focusedErrorBorder: errorInputBorder,
    errorStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: AppColors.redD1,
    ),
    outlineBorder: inputBorder.borderSide,
    suffixIconColor: AppColors.grey9E,
    constraints: BoxConstraints(
      minHeight: kDefaultInputFieldHeight,
      maxHeight: kDefaultInputFieldHeight + 20.h,
    ),
    labelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      height: 21.sp,
      letterSpacing: -.32.sp,
      color: AppColors.brown33,
    ),
    iconColor: AppColors.grey9E,
    hintStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 13.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey9E,
    ),
  );

  final elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.brown33,
      foregroundColor: AppColors.white,
      textStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        // height: 22.sp,
        letterSpacing: -.43.sp,
        color: AppColors.white,
      ),
      minimumSize: Size(double.infinity, kDefaultButtonHeight),
      elevation: 0,
    ),
  );

  final outlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: AppColors.brown33,
      textStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 16.sp,
        // height: 22.sp,
        letterSpacing: -.43.sp,
        color: AppColors.brown33,
      ),
      minimumSize: Size(double.infinity, kDefaultButtonHeight),
      elevation: 0,
    ),
  );

  final textButtonTheme = TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: AppColors.brown33,
      textStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 13.sp,
        // height: 21.sp,
        letterSpacing: -.32.sp,
        color: AppColors.brown33,
      ),
    ),
  );

  final spacingTheme = SpacingTheme(
    pagePadding: EdgeInsets.symmetric(horizontal: 16.w),
    bottomSheetPagePadding: EdgeInsets.symmetric(horizontal: 20.w),
    bottomSheetHeightFactor: .75,
    dialogPagePadding: EdgeInsets.symmetric(horizontal: 20.w),
  );

  final pageHeaderTheme = PageHeaderTheme(
    titleStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 32.sp,
      height: null,
      letterSpacing: null,
      color: AppColors.black09,
    ),
    title2Style: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 24.sp,
      height: null,
      letterSpacing: null,
      color: AppColors.black09,
    ),
    subtitleStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      height: 21.sp,
      letterSpacing: -.32.sp,
      color: AppColors.grey60,
    ),
    subtitle2Style: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 13.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.red6E,
    ),
  );

  final socialLoginTheme = SocialLoginSectionTheme(
    headerStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 17.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey60,
    ),
    registerLabelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey60,
    ),
    registerButtonStyle: textButtonTheme.style?.copyWith(
      textStyle: WidgetStatePropertyAll(
        TextStyleBuilder(
          fontWeight: FontWeight.w500,
          fontSize: 14.sp,
          // height: 21.sp,
          letterSpacing: -.43.sp,
          color: AppColors.brown33,
        ),
      ),
    ),
  );

  final otpFieldTheme = OTPFieldTheme(
    pinTheme: PinTheme(
      shape: PinCodeFieldShape.box,
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      fieldHeight: 44.w,
      fieldWidth: 44.w,
      borderWidth: 1.sp,
      activeBorderWidth: 1.sp,
      disabledBorderWidth: 1.sp,
      errorBorderWidth: 1.sp,
      inactiveBorderWidth: 1.sp,
      selectedBorderWidth: 1.sp,
      activeFillColor: AppColors.greyE6_26p,
      selectedFillColor: AppColors.greyE6_26p,
      inactiveFillColor: AppColors.greyE6_26p,
      activeColor: AppColors.greyD9_59p,
      selectedColor: AppColors.greyD9_59p,
      inactiveColor: AppColors.greyD9_59p,
    ),
    textStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      letterSpacing: -.43.sp,
      color: AppColors.brown33,
    ),
  );

  final myLocationWidgetTheme = MyLocationWidgetTheme(
    labelTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w300,
      fontSize: 12.34.sp,
      color: AppColors.white,
    ),
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.4.sp,
      color: AppColors.white,
    ),
    expandIconThemeData: IconThemeData(
      color: AppColors.white,
      size: 20.w,
    ),
  );

  final homeAppbarActionsTheme = HomeAppbarActionsTheme(
    backgroundColor: AppColors.greyE2,
    foregroundColor: AppColors.brown33,
  );

  final resendOtpSectionTheme = ResendOtpSectionTheme(
    textStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey60,
    ),
  );

  final appBarTheme = AppBarTheme(
    centerTitle: true,
    toolbarHeight: kDefaultAppBarHeight,
    elevation: 0,
    scrolledUnderElevation: 0,
    shadowColor: AppColors.black.withValues(alpha: .1),
    backgroundColor: AppColors.greyF5,
    surfaceTintColor: AppColors.white,
    foregroundColor: AppColors.black09,
    iconTheme: IconThemeData(
      color: AppColors.black29,
    ),
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 14.98.sp,
      height: 22.sp,
      color: AppColors.black09,
    ),
  );

  final actionIconThemeData = ActionIconThemeData(
    backButtonIconBuilder: (context) {
      final iconTheme = IconTheme.of(context);
      return Pic(
        Assets.icons.arrowBack.path,
        size: iconTheme.size,
        color: iconTheme.color,
      );
    },
  );

  final searchFieldInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.transparent, width: 1),
  );
  final searchFieldFocusedInputBorder = searchFieldInputBorder;
  final searchFieldErrorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.redD1, width: 1),
  );

  final searchFieldInputDecorationTheme = inputDecorationTheme.copyWith(
    filled: true,
    border: searchFieldInputBorder,
    disabledBorder: searchFieldInputBorder,
    enabledBorder: searchFieldInputBorder,
    focusedBorder: searchFieldFocusedInputBorder,
    errorBorder: searchFieldErrorInputBorder,
    focusedErrorBorder: searchFieldErrorInputBorder,
    outlineBorder: searchFieldInputBorder.borderSide,
  );

  final phoneCountryPickerTheme = PhoneCountryPickerTheme(
    countryListThemeData: CountryListThemeData(
      backgroundColor: AppColors.white,
      inputDecoration: InputDecoration().applyDefaults(inputDecorationTheme),
      borderRadius: BorderRadius.vertical(top: Radius.circular(8.h)),
    ),
  );

  final categoryItemTheme = CategoryItemTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: AppColors.brown33,
    ),
  );

  final productItemTheme = ProductItemWithAddButtonTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.black,
    ),
    subtitleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: AppColors.grey9E,
    ),
    priceTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 10.sp,
      color: AppColors.black,
    ),
  );

  final horizontalProductItemTheme = HorizontalProductItemTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.black,
    ),
    subtitleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: AppColors.grey9E,
    ),
    priceTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 10.sp,
      color: AppColors.black,
    ),
  );

  final plainProductItemTheme = PlainProductItemTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.black,
    ),
    priceTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: AppColors.black,
    ),
    borderSide: BorderSide(
      width: .5.sp,
      color: AppColors.greyE2,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  final plainMenuItemTheme = PlainMenuItemTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.black,
    ),
    borderSide: BorderSide(
      width: .5.sp,
      color: AppColors.greyE2,
    ),
    borderRadius: BorderRadius.all(Radius.circular(8)),
  );

  final offerItemTheme = OfferItemTheme(
    labelTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      color: AppColors.brown33,
    ),
    labelDecoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      color: AppColors.white,
    ),
    subtitleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.white,
    ),
    buttonStyle: elevatedButtonTheme.style!.copyWith(
      backgroundColor: WidgetStatePropertyAll(AppColors.yellowSocColor),
      foregroundColor: WidgetStatePropertyAll(AppColors.brown33),
      minimumSize: WidgetStatePropertyAll(Size(0, 38.h)),
      textStyle: WidgetStatePropertyAll(
        TextStyleBuilder(
          fontWeight: FontWeight.w500,
          fontSize: 12.sp,
          color: AppColors.brown33,
        ),
      ),
    ),
    backgroundDecoration: BoxDecoration(
      color: AppColors.brown33,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  final sectionLabelTheme = SectionLabelTheme(
    labelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      color: AppColors.brown33,
    ),
  );

  final customContainerButtonTheme = CustomContainerButtonTheme(
    labelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.black09,
    ),
    iconThemeData: IconThemeData(
      color: AppColors.brown33,
      size: 20.sp,
    ),
    containerDecoration: BoxDecoration(
      color: AppColors.greyF5,
      boxShadow: [
        BoxShadow(
          color: AppColors.greyE2,
          spreadRadius: 1,
          blurRadius: 1,
          offset: Offset(0, 1),
        ),
      ] ,
      border: Border.all(color: AppColors.greyE2, width: .5.sp),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  final rewardsProgressTheme = RewardsProgressTheme(
    backgroundContainerDecoration: BoxDecoration(
      color: AppColors.yellowFC,
      borderRadius: BorderRadius.all(Radius.circular(8)),
      border: Border.fromBorderSide(
        BorderSide(
          width: .5.sp,
          color: AppColors.greyE2,
        ),
      ),
    ),
    buttonStyle: elevatedButtonTheme.style!.copyWith(
      minimumSize: WidgetStatePropertyAll(Size(180.w, kDefaultButtonHeight)),
      maximumSize: WidgetStatePropertyAll(Size(250.w, kDefaultButtonHeight)),
      // backgroundColor: WidgetStatePropertyAll(AppColors.green34),
    ),
  );

  final rewardItemTheme = RewardItemTheme(
    labelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
      color: AppColors.black,
    ),
    iconContainerDecoration: BoxDecoration(
      color: AppColors.brown33,
      shape: BoxShape.circle,
    ),
    iconThemeData: IconThemeData(
      color: AppColors.white,
      size: 34.sp,
    ),
  );

  final offersCarouselTheme = OffersCarouselTheme(
    carouselOptions: FlutterCarouselOptions(
      viewportFraction: 1,
      initialPage: 0,
      enableInfiniteScroll: true,
      autoPlay: true,
      enlargeCenterPage: true,
      autoPlayInterval: const Duration(seconds: 6),
      autoPlayAnimationDuration: const Duration(milliseconds: 800),
      autoPlayCurve: Curves.easeInOut,
      scrollDirection: Axis.horizontal,
      pauseAutoPlayOnTouch: true,
      floatingIndicator: false,
      slideIndicator: CircularSlideIndicator(
        slideIndicatorOptions: SlideIndicatorOptions(
          currentIndicatorColor: AppColors.brown33,
          indicatorBackgroundColor: AppColors.greyD9,
          itemSpacing: 15.w,
          indicatorRadius: 5.w,
        ),
      ),
    ),
  );

  final bottomNavigationBarTheme = BottomNavigationBarThemeData(
    backgroundColor: AppColors.yellowFC,
    selectedItemColor: AppColors.brown33,
    unselectedItemColor: AppColors.grey9A,
    selectedLabelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
      height: 16.sp,
      color: AppColors.brown33,
    ),
    unselectedLabelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      height: 16.sp,
      color: AppColors.grey9A,
    ),
    selectedIconTheme: IconThemeData(
      size: 24.sp,
      color: AppColors.brown33,
    ),
    unselectedIconTheme: IconThemeData(
      size: 24.sp,
      color: AppColors.grey9A,
    ),
    type: BottomNavigationBarType.fixed,
  );

  final rootBottomNavbarTheme = RootBottomNavbarTheme(
    size: Size.fromHeight(56.h),
    dividerTheme: DividerThemeData(
      space: 0.sp,
      thickness: .5.sp,
      color: AppColors.black_20p,
    ),
  );

  final productPageBodyTheme = ProductInfoWidgetTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 20.sp,
      color: AppColors.brown33,
    ),
    bodyTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.grey60,
    ),
  );

  final dividerTheme = DividerThemeData(
    color: AppColors.greyE2,
    thickness: 1.sp,
    space: 0.sp,
  );

  final productCustomizationTheme = ProductCustomizationTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 18.sp,
      color: AppColors.brown33,
    ),
    subtitleStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.black,
    ),
    optionTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      color: AppColors.black,
    ),
    dividerThemeData: dividerTheme,
    expandableThemeData: ExpandableThemeData(
      collapseIcon: CupertinoIcons.chevron_up,
      expandIcon: CupertinoIcons.chevron_down,
      iconColor: AppColors.black29,
      iconSize: 24.sp,
    ),
    listTileControlAffinity: ListTileControlAffinity.trailing,
    radioFillColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.brown33;
        }
        return AppColors.greyE2;
      },
    ),
  );

  final paymentMethodTheme = PaymentMethodTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      color: AppColors.brown33,
    ),
    paymentMethodStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 17.sp,
      color: AppColors.brown31f,
    ),
    radioFillColor: WidgetStateProperty.resolveWith(
      (states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.brown33;
        }
        return AppColors.greyE2;
      },
    ),
  );

  final addCreditCardTheme = AddCreditCardTheme(
    labelTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      color: AppColors.brown31f,
    ),
    hintStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 17.sp,
      color: AppColors.grey9E,
      letterSpacing: -.43.sp,
      height: 22.sp,
    ),
  );

  final addCartSectionTheme = AddCartSectionTheme(
    counterTheme: QuantityCounterTheme(
      size: Size.fromHeight(kDefaultButtonHeight),
      counterTextStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColors.black,
      ),
      counterIconStyle: IconThemeData(
        color: AppColors.brown33,
        size: 24.sp,
      ),
      counterDecorationStyle: BoxDecoration(
        border: Border.all(color: AppColors.brown33, width: 1),
        borderRadius: BorderRadius.all(Radius.circular(200)),
      ),
    ),
    backgroundDecoration: BoxDecoration(
      color: AppColors.yellowFF_50p,
      border: Border(
        top: BorderSide(color: AppColors.greyE2, width: 1),
      ),
    ),
    addCartButtonStyle: elevatedButtonTheme.style!,
  );

  final addCommentHeaderTheme = AddCommentHeaderTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.black,
    ),
    leadingIconStyle: IconThemeData(
      color: AppColors.black29,
      size: 24.sp,
    ),
    trailingIconStyle: IconThemeData(
      color: AppColors.black29,
      size: 24.sp,
    ),
  );

  final bottomSheetTheme = BottomSheetThemeData(
    backgroundColor: AppColors.white,
    showDragHandle: true,
    dragHandleColor: AppColors.grey79_40p,
    dragHandleSize: Size(32.w, 4.h),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
    ),
  );

  final pageLabelTheme = PageLabelTheme(
    labelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      height: 21.sp,
      letterSpacing: -.32.sp,
      color: AppColors.brown33,
    ),
  );

  final notificationItemTheme = NotificationItemTheme(
    bodyTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey60,
    ),
    dateTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey60,
    ),
    headerTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      height: 21.sp,
      letterSpacing: -.32.sp,
      color: AppColors.brown33,
    ),
    iconStyle: IconThemeData(
      color: AppColors.brown33,
      size: 24.sp,
    ),
  );
  final notificationPermissionTheme = NotificationPermissionTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 24.sp,
      color: AppColors.black09,
    ),
    subTitleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      height: 21.sp,
      letterSpacing: -.32.sp,
      color: AppColors.grey60,
    ),
    iconStyle: IconThemeData(
      color: AppColors.red6E,
      size: 80.sp,
    ),
  );

  final qrProductItemTheme = QrProductItemTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.black,
    ),
    subtitleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 13.sp,
      color: AppColors.grey9E,
    ),
  );

  final customSheetTheme = CustomSheetTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 20.sp,
      color: AppColors.brown33,
    ),
    iconThemeData: IconThemeData(
      color: AppColors.brown33,
      size: 24.sp,
    ),
    outlinedButtonStyle: TextButton.styleFrom(
      textStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColors.brown33,
      ),
    ),
    elevatedButtonStyle: ElevatedButton.styleFrom(
      textStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColors.white,
      ),
    ),
  );

  final customDialogTheme = CustomDialogTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 20.sp,
      color: AppColors.brown33,
    ),
    iconThemeData: IconThemeData(
      color: AppColors.brown33,
      size: 24.sp,
    ),
    outlinedButtonStyle: TextButton.styleFrom(
      textStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColors.brown33,
      ),
    ),
    elevatedButtonStyle: ElevatedButton.styleFrom(
      textStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 14.sp,
        color: AppColors.white,
      ),
    ),
  );

  final cartProductItemTheme = CartProductItemTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: AppColors.brown33,
    ),
    bodyTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.grey60,
    ),
    priceTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: AppColors.black09,
    ),
    deleteButtonStyle: IconButton.styleFrom(
      iconSize: 24.sp,
      foregroundColor: AppColors.redD1,
    ),
    backgroundDecoration: BoxDecoration(
      border: Border.all(
        color: AppColors.greyE1,
        width: 1.sp,
      ),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  final quantityCounterTheme = QuantityCounterTheme(
    size: Size.fromHeight(43.h),
    counterTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 10.sp,
      color: AppColors.black,
    ),
    counterIconStyle: IconThemeData(
      size: 14.sp,
      color: AppColors.brown33,
    ),
    counterDecorationStyle: BoxDecoration(
      border: Border.all(color: AppColors.brown33, width: .6),
      borderRadius: BorderRadius.all(Radius.circular(200)),
    ),
  );

  final couponInputFieldBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.greyE2, width: 1),
  );
  final couponInputFieldErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: AppColors.redD1, width: 1),
  );
  final cartOverviewSectionTheme = CartOverviewSectionTheme(
    backgroundDecoration: BoxDecoration(
      color: AppColors.yellowFF_50p,
      border: Border(
        top: BorderSide(color: AppColors.greyE2, width: 1),
      ),
    ),
    labelTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: AppColors.grey60,
    ),
    valueTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 16.sp,
      color: AppColors.brown33,
    ),
    couponInputExpandableTheme: ExpandableThemeData(
      expandIcon: CupertinoIcons.plus_circle,
      collapseIcon: CupertinoIcons.plus_circle,
      iconColor: AppColors.black29,
      iconSize: 24.sp,
    ),
  );

  final couponFieldTheme = CouponFieldTheme(
    inputDecorationTheme: InputDecorationTheme(
      border: couponInputFieldBorder,
      enabledBorder: couponInputFieldBorder,
      disabledBorder: couponInputFieldBorder,
      focusedBorder: couponInputFieldBorder,
      errorBorder: couponInputFieldErrorBorder,
      focusedErrorBorder: couponInputFieldErrorBorder,
      suffixIconColor: AppColors.grey9E,
      fillColor: AppColors.white ,
      hintStyle: TextStyleBuilder(
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.grey9E,
      ),
    ),
  );

  final couponItemTheme = CouponItemTheme(
    backgroundDecoration: BoxDecoration(
      border: Border.all(color: AppColors.red6E, width: .5),
      borderRadius: BorderRadius.all(Radius.circular(18)),
      color: AppColors.white,
    ),
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      height: 21.sp,
      letterSpacing: -.32.sp,
      color: AppColors.brown33,
    ),
    bodyTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      height: 21.sp,
      letterSpacing: -.32.sp,
      color: AppColors.grey60,
    ),
    discountTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      height: 21.sp,
      letterSpacing: -.32.sp,
      color: AppColors.brown33,
    ),
    discountIconStyle: IconThemeData(
      size: 18.sp,
      color: AppColors.brown33,
    ),
    copyButtonBackground: BoxDecoration(
      color: AppColors.brown33,
    ),
    copyButtonTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      // height: 22.sp,
      letterSpacing: -.32.sp,
      color: AppColors.greyE2,
    ),
    couponBackgroundColor: AppColors.white,
  );

  final activeOrderDetailsTheme = ActiveOrderDetailsTheme(
    backgroundDecoration: BoxDecoration(
      color: AppColors.yellowFC,
      border: Border.all(color: AppColors.greyE2, width: 1),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    timeTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 17.sp,
      color: AppColors.brown33,
    ),
    timeHintTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.brown33,
    ),
    delayHintTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.brown33,
    ),
    activeDelayButtonStyle: OutlinedButton.styleFrom(
      minimumSize: Size(double.infinity, 40.h),
      padding: EdgeInsets.zero,
      textStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColors.brown33,
      ),
    ),
    unActiveDelayButtonStyle: OutlinedButton.styleFrom(
      minimumSize: Size(double.infinity, 40.h),
      backgroundColor: AppColors.greyD9 ,
      padding: EdgeInsets.zero,
      textStyle: TextStyleBuilder(
        fontWeight: FontWeight.w500,
        fontSize: 12.sp,
        color: AppColors.black29,
      ),
    ),
    selectTimeTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      color: AppColors.brown33,
    ),
    selectTimeIconStyle: IconThemeData(
      size: 24.sp,
      color: AppColors.brown33,
    ),
  );

  final orderProgressBarTheme = OrderProgressBarTheme(
    checkIconStyle: IconThemeData(
      size: 24.sp,
      color: AppColors.white,
    ),
    checkBackgroundDecoration: BoxDecoration(
      color: AppColors.green34,
      shape: BoxShape.circle,
    ),
    distanceBackgroundDecoration: BoxDecoration(
      color: AppColors.brown33,
      shape: BoxShape.circle,
    ),
    readyBackgroundDecoration: BoxDecoration(
      color: AppColors.brown33,
      shape: BoxShape.circle,
    ),
    timeLabelTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: AppColors.black,
    ),
    distanceLabelTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 12.sp,
      color: AppColors.black,
    ),
    readyTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 9.sp,
      color: AppColors.white,
    ),
    progressDashColor: AppColors.brown33,
  );

  final tabBarTheme = TabBarThemeData(
    tabAlignment: TabAlignment.fill,
    dividerHeight: 0,
    dividerColor: Colors.transparent,
    indicatorSize: TabBarIndicatorSize.tab,
    indicatorColor: AppColors.brown33,
    indicatorAnimation: TabIndicatorAnimation.elastic,
    labelColor: AppColors.brown33,
    labelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w700,
      fontSize: 14.sp,
      color: AppColors.brown33,
    ),
    unselectedLabelColor: AppColors.grey9A,
    unselectedLabelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.grey9A,
    ),
  );

  final pointItemTheme = PointItemTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 15.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey60,
    ),
    priceUpTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.green37,
    ),
    priceDownTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.redEB,
    ),
    dateTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 13.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey60,
    ),
    pointsTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 13.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey60,
    ),
  );

  final totalPointsOverviewTheme = TotalPointsOverviewTheme(
    backgroundDecoration: BoxDecoration(
      color: AppColors.brown33,
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    iconStyle: IconThemeData(
      size: 40.sp,
      color: AppColors.white,
    ),
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.white,
    ),
    pointsTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w700,
      fontSize: 14.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.white,
    ),
    descTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.white,
    ),
    priceTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w700,
      fontSize: 14.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.white,
    ),
  );

  final branchItemTheme = BranchItemTheme(
    iconThemeData: IconThemeData(
      size: 24.sp,
      color: AppColors.brown33,
    ),
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.black,
    ),
    subtitleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 12.sp,
      height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.grey60,
    ),
    activeIconThemeData: IconThemeData(
      size: 20.sp,
      color: AppColors.brown33,
    ),
    inactiveIconThemeData: IconThemeData(
      size: 20.sp,
      color: AppColors.grey9E,
    ),
  );

  final homeAppbarTheme = HomeAppbarTheme(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.brown33,
    ),
    searchInputDecorationTheme: searchFieldInputDecorationTheme,
  );

  final recentSearchItemTheme = RecentSearchItemTheme(
    labelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 13.sp,
      color: AppColors.grey9E,
    ),
    iconThemeData: IconThemeData(
      size: 20.sp,
      color: AppColors.brown33,
    ),
  );

  final spinnerItemTheme = SpinnerItemTheme(
    available: SpinnerItemThemeData(
      boxDecoration: BoxDecoration(
        color: AppColors.brown33,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      labelTextStyle: TextStyleBuilder(
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.brown33,
      ),
      labelBoxDecoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      titleTextStyle: TextStyleBuilder(
        fontWeight: FontWeight.w600,
        fontSize: 17.sp,
        color: AppColors.white,
      ),
      descTextStyle: TextStyleBuilder(
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
        color: AppColors.white,
      ),
      buttonStyle: ElevatedButton.styleFrom(
        backgroundColor: AppColors.yellowSocColor,
        foregroundColor: AppColors.brown33,
        disabledBackgroundColor: AppColors.grey9A,
        disabledForegroundColor: AppColors.white,
        minimumSize: Size(double.infinity, 38.sp),
      ),
      image: Assets.images.spinnerDark.path,
    ),
    unavailable: SpinnerItemThemeData(
      boxDecoration: BoxDecoration(
        border: Border.all(color: AppColors.greyE2),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      labelTextStyle: TextStyleBuilder(
        fontWeight: FontWeight.w400,
        fontSize: 12.sp,
        color: AppColors.brown33,
      ),
      labelBoxDecoration: BoxDecoration(
        color: AppColors.greyE2,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      titleTextStyle: TextStyleBuilder(
        fontWeight: FontWeight.w600,
        fontSize: 17.sp,
        color: AppColors.brown33,
      ),
      descTextStyle: TextStyleBuilder(
        fontWeight: FontWeight.w400,
        fontSize: 10.sp,
        color: AppColors.brown33,
      ),
      buttonStyle: ElevatedButton.styleFrom(
        backgroundColor: AppColors.brown33,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.grey9A,
        disabledForegroundColor: AppColors.white,
        minimumSize: Size(double.infinity, 38.sp),
      ),
      image: Assets.images.spinnerLight.path,
    ),
  );

  final spinnerTheme = SpinnerTheme(
    labelTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w600,
      fontSize: 12.sp,
      color: AppColors.white,
    ),
    textColorLight: AppColors.brown33,
    textColorDark: AppColors.white,
    colors: [
      AppColors.brown33,
      AppColors.greyF5,
      // AppColors.redF7,
      // AppColors.blue3A,
      // AppColors.redD8,
      // AppColors.green67,
    ],
    outerBorderColor: AppColors.brown33,
    outerBorderCirclesColor: AppColors.white,
    innerBorderColor: AppColors.brown33,
    innerBorderCircleColor: AppColors.white,
    arrowOuterBorderColor: AppColors.red98,
    arrowInnerBorderColor: AppColors.greyF5,
  );

  final spinnerRewardTheme = SpinnerRewardTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w300,
      fontSize: 32.sp,
      color: AppColors.brown33,
    ),
    labelTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w300,
      fontSize: 14.sp,
      color: AppColors.grey9A,
    ),
    rewardNameTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w900,
      fontSize: 52.sp,
      color: AppColors.redD8,
    ),
  );

  final alertDialogTheme = CustomAlertDialogTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w800,
      fontSize: 16.sp,
      color: AppColors.brown33,
    ),
    subtitleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w400,
      fontSize: 14.sp,
      color: AppColors.brown33,
    ),
  );

  final userInfoTileTheme = UserInfoTileTheme(
    titleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      height: 16.sp,
      color: AppColors.black09,
    ),
    subtitleTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      height: 16.sp,
      color: AppColors.grey9A,
    ),
    gearButtonStyle: IconButton.styleFrom(
      foregroundColor: AppColors.black09,
    ),
  );

  final profileActionTileTheme = ProfileActionTileTheme(
    boxDecoration: BoxDecoration(
      color: AppColors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.all(Radius.circular(8)),
      border: Border.all(color: AppColors.greyE2),
    ),
    leadingIconThemeData: IconThemeData(
      color: AppColors.brown33,
      size: 24.sp,
    ),
    labelStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      // height: 22.sp,
      letterSpacing: -.43.sp,
      color: AppColors.brown33,
    ),
    trailingTextStyle: TextStyleBuilder(
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      // height: 22.sp,
      letterSpacing: -.43.sp,
      decoration: TextDecoration.underline,
      color: AppColors.grey9A,
      decorationColor: AppColors.grey9A,
    ),
    trailingIconThemeData: IconThemeData(
      color: AppColors.brown33,
      size: 24.sp,
    ),
  );

  ThemeData theme = ThemeData(
    extensions: [
      spacingTheme,
      pageLabelTheme,
      pageHeaderTheme,
      socialLoginTheme,
      otpFieldTheme,
      couponFieldTheme,
      resendOtpSectionTheme,
      myLocationWidgetTheme,
      homeAppbarActionsTheme,
      phoneCountryPickerTheme,
      categoryItemTheme,
      productItemTheme,
      horizontalProductItemTheme,
      plainProductItemTheme,
      plainMenuItemTheme,
      offerItemTheme,
      sectionLabelTheme,
      customContainerButtonTheme,
      rewardsProgressTheme,
      rewardItemTheme,
      offersCarouselTheme,
      rootBottomNavbarTheme,
      productPageBodyTheme,
      productCustomizationTheme,
      paymentMethodTheme,
      addCreditCardTheme,
      addCartSectionTheme,
      addCommentHeaderTheme,
      notificationItemTheme,
      notificationPermissionTheme,
      qrProductItemTheme,
      customSheetTheme,
      customDialogTheme,
      cartProductItemTheme,
      quantityCounterTheme,
      cartOverviewSectionTheme,
      couponItemTheme,
      activeOrderDetailsTheme,
      orderProgressBarTheme,
      pointItemTheme,
      totalPointsOverviewTheme,
      branchItemTheme,
      homeAppbarTheme,
      recentSearchItemTheme,
      spinnerItemTheme,
      spinnerTheme,
      spinnerRewardTheme,
      alertDialogTheme,
      userInfoTileTheme,
      profileActionTileTheme,
    ],
    useMaterial3: true,
    fontFamily: AppFonts.mainFont,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.greyF5,
    inputDecorationTheme: inputDecorationTheme,
    elevatedButtonTheme: elevatedButtonTheme,
    outlinedButtonTheme: outlinedButtonTheme,
    textButtonTheme: textButtonTheme,
    actionIconTheme: actionIconThemeData,
    appBarTheme: appBarTheme,
    bottomNavigationBarTheme: bottomNavigationBarTheme,
    dividerTheme: dividerTheme,
    bottomSheetTheme: bottomSheetTheme,
    tabBarTheme: tabBarTheme,
    snackBarTheme: snackBarTheme,
  );

  return theme;
}
