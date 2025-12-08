import 'package:test_vibe/core/di/di.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/dialogs/custom_alert_dialog/custom_alert_dialog.dart';
import 'package:test_vibe/modules/app/branches/branches_page.dart';
import 'package:test_vibe/modules/app/cart/cart_page.dart';
import 'package:test_vibe/modules/app/check_out/check_payment_page_params.dart';
import 'package:test_vibe/modules/app/check_out/payment_methods_page.dart';
import 'package:test_vibe/modules/app/check_out/payment_web_view_page_params.dart';
import 'package:test_vibe/modules/app/coupons/coupons_page.dart';
import 'package:test_vibe/modules/app/home/home_page.dart';
import 'package:test_vibe/modules/app/home/widgets/signatures_products_section/all_signatures_products/all_signatures_products_page.dart';
import 'package:test_vibe/modules/app/notifications/notifications_page.dart';
import 'package:test_vibe/modules/app/offers/bloc/offers_bloc.dart';
import 'package:test_vibe/modules/app/offers/offers_page.dart';
import 'package:test_vibe/modules/app/on_board/on_boarding.dart';
import 'package:test_vibe/modules/app/orders/models/order_model.dart';
import 'package:test_vibe/modules/app/orders/orders_page.dart';
import 'package:test_vibe/modules/app/orders/widgets/select_time_sheet/select_time_sheet.dart';
import 'package:test_vibe/modules/app/points/points_page.dart';
import 'package:test_vibe/modules/app/product/product_details_page.dart';
import 'package:test_vibe/modules/app/product/product_page.dart';
import 'package:test_vibe/modules/app/product/widgets/add_comment/add_comment_sheet/add_comment_sheet.dart';
import 'package:test_vibe/modules/app/products/models/product_model.dart';
import 'package:test_vibe/modules/app/products/products_page.dart';
import 'package:test_vibe/modules/app/products/products_page_params.dart';
import 'package:test_vibe/modules/app/profile/profile_page.dart';
import 'package:test_vibe/modules/app/qr_codes/qr_codes_page.dart';
import 'package:test_vibe/modules/app/qr_codes/widgets/qr_sheet/qr_sheet.dart';
import 'package:test_vibe/modules/app/root/bloc/root_bloc.dart';
import 'package:test_vibe/modules/app/root/root_page.dart';
import 'package:test_vibe/modules/app/search/search_page.dart';
import 'package:test_vibe/modules/app/settings/settings_page.dart';
import 'package:test_vibe/modules/app/spinner/spinner_page.dart';
import 'package:test_vibe/modules/app/spinner/widgets/spinner_reward/spinner_reward_sheet.dart';
import 'package:test_vibe/modules/app/spinners/models/spinner_model_new.dart';
import 'package:test_vibe/modules/app/spinners/spinners_page.dart';
import 'package:test_vibe/modules/auth/bloc/login_bloc.dart';
import 'package:test_vibe/modules/auth/login/login_page.dart';
import 'package:test_vibe/modules/auth/otp/otp_page.dart';
import 'package:test_vibe/modules/auth/otp/register_otp_page.dart';
import 'package:test_vibe/modules/auth/otp/widgets/otp_page_params.dart';
import 'package:test_vibe/modules/auth/password/password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/app/add_credit_card/add_credit_card_page.dart';
import '../../modules/app/balance/balance_page.dart';
import '../../modules/app/balance/recently_transaction.dart';
import '../../modules/app/categories/bloc/categories_bloc.dart';
import '../../modules/app/categories/pages/sub_categories_page.dart';
import '../../modules/app/check_out/check_payment_page.dart';
import '../../modules/app/check_out/confirm_payment_page.dart';
import '../../modules/app/check_out/failed_payment_page.dart';
import '../../modules/app/check_out/payment_web_view_page.dart';
import '../../modules/app/home/widgets/home_appbar/widgets/my_location_widget/branches_page_params.dart';
import '../../modules/app/home/widgets/newly_released_products_section/newly_released_products/newly_released_products_page.dart';
import '../../modules/app/home/widgets/top_requested_products_section/all_top_requested_products/all_top_requested_products_page.dart';
import '../../modules/app/home/widgets/top_requested_products_section/all_top_requested_products/all_top_requsted_products_page_params.dart';
import '../../modules/app/categories/pages/category_item_page.dart';
import '../../modules/app/categories/models/category_products_page_params.dart';
import '../../modules/app/categories/pages/menu_page.dart';
import '../../modules/app/categories/models/menus_page_params.dart';
import '../../modules/app/notifications/notification_permission_page.dart';
import '../../modules/app/offers/models/special_offers_model.dart';
import '../../modules/app/offers/offer_details_page.dart';
import '../../modules/app/orders/bloc/edit_order_bloc.dart';
import '../../modules/app/orders/bloc/orders_bloc.dart';
import '../../modules/app/orders/edit_order_page.dart';
import '../../modules/app/orders/widgets/product_sheet/product_sheet.dart';
import '../../modules/app/points/models/point_model_new.dart';
import '../../modules/app/product/widgets/add_comment/add_comment_params.dart';
import '../../modules/app/rewards/widgets/reward_products/reward_products_page.dart';
import '../../modules/app/rewards/widgets/reward_products/reward_products_page_params.dart';
import '../../modules/app/settings/widget/delete_account_sheet.dart';
import '../../modules/app/settings/widget/lang_select_sheet.dart';
import '../../modules/app/spinner/widgets/spinner_reward/choose_two_products_page.dart';
import '../../modules/app/spinner/widgets/spinner_reward/spinner_buy_one_get_one_page_params.dart';
import '../../modules/app/spinner/widgets/spinner_reward/spinner_products_page.dart';
import '../../modules/app/spinner/widgets/spinner_reward/spinner_products_page_params.dart';
import '../../modules/app/spinner/widgets/spinner_reward/spinner_reward_sheet_params.dart';
import '../../modules/app/splash/splash_page.dart';
import '../../modules/auth/login/confirm_name_page.dart';
import '../../modules/auth/login/confirm_profile_page.dart';
import '../../modules/auth/login/widgets/confirm_profile_page_params.dart';
import '../../modules/auth/sign_up/sign_up_page.dart';
import '../utils/force_update/force_update_page.dart';
import 'nav_obs.dart';

enum Nav {
  login,
  otp,
  password,
  root,
  home,
  orders,
  profile,
  offers,
  product,
  productDetails,
  products,
  menus,
  categoryProducts,
  subCategories,
  addCommentSheet,
  notifications,
  notificationPermission,
  coupons,
  points,
  branches,
  qrCodes,
  qrSheet,
  selectTimeSheet,
  selectLangSheet,
  cart,
  search,
  spinners,
  spinner,
  settings,
  spinnerRewardSheet,
  alertDialog,
  paymentMethods,
  addCreditCard,
  allTopRequestedProducts,
  newlyReleasedProducts,
  allSignaturesProducts,
  splash,
  onBoarding,
  confirmProfilePage,
  productDetailsSheet,
  balance,
  recentlyTransaction,
  confirmNamePage,
  confirmPaymentPage,
  failedPaymentPage,
  deleteAccountSheet,
  offerDetailsPage,
  spinnerProductPage,
  rewardProductsPage,
  paymentWebView,
  chooseTwoProductsPage,
  forceUpdate,
  checkPaymentStatusPage,
  signUp,
  registerOTP,
  changeBranchDialog,
  editOder;

  // Add the global navigator key
  static final GlobalKey<NavigatorState> mainNavKey = GlobalKey<NavigatorState>();

  /// a short-hand for showing alert dialog and always returning bool
  static Future<bool> alert<T>(BuildContext context, {
    required String message,
    String? messageDescription,
  }) async {
    final result = await Nav.alertDialog.dialog(
      context,
      args: {
        'message': message,
        'messageDescription': messageDescription,
      },
    );
    return result == true;
  }
}

extension NavX on Nav {
  push(BuildContext context, {Object? args}) {
    if (di<NavObs>().isLast(this)) {
      return;
    }
    return Navigator.of(context).pushNamed(
      name,
      arguments: args,
    );
  }

  replace(BuildContext context, {Object? args}) {
    if (di<NavObs>().isLast(this)) {
      return;
    }
    return Navigator.of(context).pushReplacementNamed(
      name,
      arguments: args,
    );
  }

  replaceAll(BuildContext context, {Object? args}) {
    if (di<NavObs>().isLast(this)) {
      return;
    }
    return Navigator.of(context).pushNamedAndRemoveUntil(
      name,
      arguments: args,
          (route) => false,
    );
  }

  popUntil(BuildContext context) {
    if (di<NavObs>().isLast(this)) {
      return;
    }
    return Navigator.of(context).popUntil(
          (route) => route.settings.name == name,
    );
  }

  Future<T?> sheet<T>(BuildContext context, {
    Object? args,
    bool isDismissible = true,
    bool showDragHandle = true,
  }) {
    return showModalBottomSheet(
      context: context,
      showDragHandle: showDragHandle,
      isScrollControlled: true,
      enableDrag: isDismissible,
      isDismissible: isDismissible,
      routeSettings: RouteSettings(name: name, arguments: args),
      builder: (context) => getWidget(context),
    );
  }

  Future<T?> dialog<T>(BuildContext context, {Object? args}) {
    return showDialog(
      context: context,
      routeSettings: RouteSettings(name: name, arguments: args),
      builder: (context) => getWidget(context),
    );
  }

  Widget getWidget(BuildContext context) {
    final args = ModalRoute
        .of(context)
        ?.settings
        .arguments;
    switch (this) {
      case Nav.login:
        return const LoginPage();
      case Nav.otp:
        if (args is OtpPageParams) {
          return BlocProvider(
            create: (context) => di<LoginBloc>(),
            child: OTPPage(
              phone: args.phoneNumber,
              country: args.country,
            ),
          );
        }
      case Nav.registerOTP:
        if (args is RegisterOtpPageParams) {
          return BlocProvider(
            create: (context) => di<LoginBloc>(),
            child: RegisterOTPPage(
              phone: args.phoneNumber,
              country: args.country,
              profilePageParams: args.profilePageParams,
            ),
          );
        }
      case Nav.signUp:
        return const SignUpPage();
      case Nav.password:
        return PasswordPage();
      case Nav.root:
        if (args is RootIndex) {
          return RootPage(initialIndex: args);
        }
        return RootPage();
      case Nav.home:
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => di<SpecialOffersBloc>(),
            ),
            BlocProvider(
              create: (context) =>
              di<OrdersBloc>()
                ..getTrackOrder(),
            ),
          ],
          child: HomePage(),
        );
      case Nav.orders:
        return BlocProvider(
          create: (context) => di<OrdersBloc>(),
          child: OrdersPage(),
        );
      case Nav.profile:
        return ProfilePage();
      case Nav.offers:
        if (args is List<FlashSaleModel>) {
          return OffersPage(flashSaleModelList: args);
        }

      case Nav.product:
        if (args is ProductModel) {
          return ProductPage(
            model: args,
          );
        }
      case Nav.products:
        if (args is ProductsPageParams) {
          return ProductsPage(
            title: args.title,
            models: args.models,
          );
        }
      case Nav.productDetails:
        if (args != null) {
          return ProductDetailsPage(
            productId: int.parse(args.toString()),
          );
        }
      case Nav.addCommentSheet:
        if (args is AddCommentParams) {
          return AddCommentSheet(params: args);
        }
      case Nav.onBoarding:
        return const OnboardingScreen(); // Placeholder for onBoarding, if needed
      case Nav.notifications:
        return NotificationsPage();
      case Nav.notificationPermission:
        return const NotificationPermissionPage();
      case Nav.coupons:
        return CouponsPage();
      case Nav.points:
        return PointsPage();
      case Nav.qrCodes:
        return QrCodesPage();
      case Nav.branches:
        if (args is BranchesPageParams) {
          return BranchesPage(
            selectedBranch: args.selectedBranch,
            bloc: args.bloc,
          );
        }
      case Nav.qrSheet:
        return QrSheet();
      case Nav.selectTimeSheet:
        return SelectTimeSheet();
      case Nav.selectLangSheet:
        if (args is String) {
          return LanguageSelectionSheet(currentLang: args);
        }
      case Nav.cart:
        return CartPage();
      case Nav.search:
        return SearchPage();
      case Nav.spinners:
        return SpinnersPage();
      case Nav.settings:
        return SettingsPage();
      case Nav.alertDialog:
        final message = validateString(validateMap(args)['message']);
        if (validString(message)) {
          final messageDesc = validateString(validateMap(args)['messageDescription']);
          return CustomAlertDialog(
            title: message,
            subtitle: messageDesc,
          );
        }
      case Nav.spinner:
        if (args is SpinnerModel) {
          return SpinnerPage(
            model: args,
          );
        }
      case Nav.spinnerRewardSheet:
        if (args is SpinnerRewardSheetParams) {
          return SpinnerRewardSheet(
            params: args,
          );
        }
      case Nav.paymentMethods:
        return PaymentMethodsScreen();
      case Nav.menus:
        if (args is MenusPageParams) {
          return MenusPage(
            title: args.title,
            bloc: args.bloc,
          );
        }
      case Nav.allTopRequestedProducts:
        if (args is AllTopRequestedProductsPageParams) {
          return AllTopRequestedProductsPage(
            title: args.title,
            bloc: args.bloc,
          );
        }
      case Nav.allSignaturesProducts:
        if (args is AllTopRequestedProductsPageParams) {
          return AllSignaturesProductsPage(
            title: args.title,
            bloc: args.bloc,
          );
        }
      case Nav.newlyReleasedProducts:
        if (args is AllTopRequestedProductsPageParams) {
          return NewlyReleasedProductsPage(
            title: args.title,
            bloc: args.bloc,
          );
        }
      case Nav.splash:
        return const SplashPage();
      case Nav.addCreditCard:
        return const AddCreditCardPage();
      case Nav.categoryProducts:
        if (args is CategoryProductsPageParams) {
          return BlocProvider(
            create: (context) => di<CategoriesBloc>(),
            child: CategoryItemsPage(
              // bloc: args.bloc,
              categoryId: args.categoryId,
              title: args.title,
            ),
          );
        }
      case Nav.subCategories:
        if (args is CategoryProductsPageParams) {
          return BlocProvider(
            create: (context) => di<CategoriesBloc>(),
            child: SubCategoriesPage(
              // bloc: args.bloc,
              categoryId: args.categoryId,
              title: args.title,
            ),
          );
        }
      case Nav.confirmProfilePage:
        if (args is LoginBloc) {
          return ConfirmProfilePage(bloc: args);
        }
      case Nav.productDetailsSheet:
        if (args is OrderProductModel) {
          return ProductDetailsSheet(model: args);
        }
      case Nav.deleteAccountSheet:
        return DeleteAccountSheet();
      case Nav.balance:
        return BalancePage();
      case Nav.recentlyTransaction:
        if (args is List<LoyaltyPointEntry>) {
          return RecentlyTransaction(model: args);
        }
      case Nav.confirmNamePage:
        if (args is ConfirmNamePageParams) {
          return ConfirmNamePage(params: args);
        }
      case Nav.confirmPaymentPage:
        return ConfirmPaymentPage();
      case Nav.offerDetailsPage:
        if (args is List<FlashSaleProductModel>) {
          return OfferDetailsPage(list: args);
        }
      case Nav.spinnerProductPage:
        if (args is SpinnerProductsPageParams) {
          return SpinnerProductsPage(
            title: args.title,
            // bloc: args.bloc,
          );
        }
      case Nav.chooseTwoProductsPage:
        if (args is SpinnerBuyOneGetOnePageParams) {
          return ChooseTwoProductsPage(
            title: args.title,
            type: args.type,
            rewardId: args.rewardId,
            // bloc: args.bloc,
          );
        }
      case Nav.rewardProductsPage:
        if (args is RewardProductsPageParams) {
          return RewardProductsPage(
            title: args.title,
          );
        }
      case Nav.paymentWebView:
        if (args is PaymentWebViewParams) {
          return PaymentWebViewPage(
            callbackUrl: args.callbackUrl,
            paymentUrl: args.paymentUrl,
          );
        }
      case Nav.failedPaymentPage:
        if (args is PaymentWebViewParams) {
          return FailedPaymentPage(
            paymentUrl: args.paymentUrl,
            callbackUrl: args.callbackUrl,
          );
        }
      case Nav.checkPaymentStatusPage:
        if (args is CheckPaymentPageParams) {
          return CheckPaymentPage(
            paymentUrl: args.paymentUrl,
            callbackUrl: args.callbackUrl,
            orderId: args.orderId,
          );
        }
      case Nav.forceUpdate:
        return ForceUpdatePage();
      case Nav.editOder:
        if (args is OrderModel) {
          return BlocProvider(
            create: (context) => di<EditOrderBloc>(),
            child: EditOrderPage(orderModel: args),
          );
        }
      case Nav.changeBranchDialog:
        final branchInfo = validateMap(args);
        return CustomChangeBranchDialog(
          storeName: validateString(branchInfo['storeName']) ?? '',
          storeAddress: validateString(branchInfo['storeAddress']) ?? '',
        );
    }
    //todo not found page
    return Container();
  }
}
