// api_app_config.dart
// Endpoints and API configuration for Coffee Driver - Full API (Professional)

import '../functions.dart';

abstract class AppConfig {
  static const String baseUrl = 'https://beta.clarocafe.ae/api/v1/';
  static const String baseUrlV1 = 'https://beta.clarocafe.ae/v1/';
  static const packageName = 'com.algoriza.coffee_driver';

  // ===================== Authentication & Profile =====================

  static String login() => 'customer/auth/login';
  static String registerWithDataBase() => 'customer/auth/register';
  static String registerWithOtp() => 'customer/auth/register/send-otp';
  static String verifyCode() => 'customer/auth/verify-code';
  static String verifyRegisterOtp() => 'customer/auth/register/verify-otp';
  static String logout() => 'customer/auth/logout';
  static String resetPasswordRequest() => 'password/email';
  static String resetPasswordConfirm() => 'password/reset';
  static String getProfile() => 'customer/auth/profile';
  static String updateProfile() => 'customer/profile';
  static String changePassword() => 'customer/auth/change-password';
  static String deleteAccount() => 'customer/auth/delete';
  static String updateDeviceToken() => 'customer/auth/token';
  static String updateAvatar() => 'customer/profile/avatar';
  static String socialLogin() => 'customer/auth/social-login';
  static String emailVerificationRequest() =>
      'customer/auth/email/verify-request';
  static String emailVerificationConfirm() => 'customer/auth/email/verify';
  static String socialLoginEndpoint() => "auth/social-login";

  // ===================== Products =====================

  static String getAllProducts() => 'products';
  static String getProductDetails(int productId) => 'product/$productId';
  static String getTopRequestedProducts(Map<String, String> params) =>
      'products?${mapToQueryParams(params)}';
  static String getNewlyReleasedProducts(Map<String, String> params) =>
      'products?${mapToQueryParams(params)}';
  static String getSpecialProducts() => 'products?is_special=1';
  static String getSignatureProducts(Map<String, String> params) =>
      'products?${mapToQueryParams(params)}';
  static String searchProducts(String keyword) => 'search?keyword=$keyword';
  static String getProductsByCategory(
          int categoryId, Map<String, String> params) =>
      'categories/$categoryId/products?${mapToQueryParams(params)}';
  static String getRelatedProducts(int productId) =>
      'products/$productId/related';
  static String getSearchRecentView() => 'products/recently-viewed-searched';
  static String deleteSearchRecentView(int productId) =>
      'product/delete-searched?product_id=$productId';
  static String addCommentToProduct() => 'product/add-comment';

  // ===================== Categories & Brands =====================

  static String getAllCategories(Map<String, String> params) =>
      'categories?${mapToQueryParams(params)}';
  static String getCategoryAttributes(int categoryId) =>
      'categories/$categoryId/attributes';
  static String getBrands() => 'brands';
  static String getSubCategories(
          {required int categoryId, required Map<String, String> params}) =>
      'categories/$categoryId/sub-categories?${mapToQueryParams(params)}';

  // ===================== Branches =====================
  static String getBranches(Map<String, String> params) =>
      'store-locators?${mapToQueryParams(params)}';
  static String assignBranchToUser(int branchId) => 'store-locators/assign/$branchId';
  static String autoAssignBranch() => 'customer/branch/auto-assign';

  // ===================== Reviews & FAQ =====================

  static String getProductReviews(int productId) =>
      'products/$productId/reviews';
  static String getProductFAQ(int productId) => 'products/$productId/faq';

  // ===================== Rewards & Policies =====================

  static String getRewardsProgress() => 'promotions/buy-get';
  static String getQrCodeRewards() => 'promotions/generate-qrcode-free-offer';
  static String getRefundPolicy() => 'page/refund-policy';
  static String getTermsAndConditions() => 'terms-conditions';
  static String getRewardFreeProducts(Map<String, String> params) =>
      'free-products-from-settings?${mapToQueryParams(params)}';

  // ===================== Wishlist =====================

  static String getWishlist() => 'wishlist';
  static String addToWishlist() => 'wishlist';
  static String removeFromWishlist(int productId) => 'wishlist/$productId';

  // ===================== Cart =====================

  static String getCart() => 'customer/cart';
  static String addToCart() => 'customer/cart/add-to-cart';
  static String updateCartItem() => 'customer/cart/update';
  static String removeFromCart(String rowId) => 'customer/cart/remove/$rowId';

  // ===================== Orders =====================

  static String getOrders(Map<String, String> params) =>
      'customer/orders?${mapToQueryParams(params)}';
  static String getOrderDetails(int orderId) => 'customer/orders/$orderId';
  static String createOrder() => 'orders';
  static String trackOrder() => 'customer/track/order';
  static String addMinutesToOrder() => 'customer/add-minutes/track/order';
  static String checkOrder() => 'customer/checkout/final-checkout';
  static String checkOrderStatus(String orderId) =>
      'customer/payment-status/$orderId';
  static String deleteOrder(int orderId) => 'customer/orders/$orderId';
  static String updateOrder(int orderId) => 'customer/orders/$orderId';
  static String cancelOrder(int orderId) => 'customer/orders/cancel/$orderId';
  static String deleteOrderProduct(int orderId, int productId) =>
      'customer/orders/$orderId/products/$productId';

  // ===================== Compare =====================

  static String getCompareList() => 'compare';
  static String addToCompare() => 'compare';
  static String removeFromCompare(int productId) => 'compare/$productId';

  // ===================== Addresses =====================

  static String getAddresses() => 'addresses';
  static String addAddress() => 'addresses';
  static String updateAddress(int addressId) => 'addresses/$addressId';
  static String deleteAddress(int addressId) => 'addresses/$addressId';

  // ===================== Coupons =====================

  static String validateCoupon() => 'customer/coupons/validate';
  static String getCoupons() => 'customer/coupons';
  static String applyCoupon() => 'customer/checkout/apply-coupon';

  // ===================== points =====================

  static String getPointsHistory() => 'customer/get-points-history';
  static String getPoints() => 'customer/get-points';
  static String transferPoints() => 'customer/transfer-points';

  // ===================== Notifications =====================

  static String getNotifications() => 'customer/notifications';
  static String getUnreadNotifications() => 'customer/unread-notifications';
  static String markAllAsRead() => 'customer/notifications/mark-as-read';
  static String deleteAllNotifications() => 'notifications';
  static String deleteNotification(int notificationId) =>
      'notifications/$notificationId';

  // ===================== User =====================

  static String getUserInfo() => '${baseUrlV1}user/info';
  static String updateUserInfo() => '${baseUrlV1}user/info/update';
  static String getShippingAddresses(int id) =>
      '${baseUrlV1}user/shipping/address/$id';

  // ===================== Settings & General =====================

  static String getLanguages() => '${baseUrlV1}languages';
  static String getCurrencies() => '${baseUrlV1}currencies';
  static String getTranslations() => '${baseUrlV1}translations';
  static String getFilter() => '${baseUrlV1}filter';
  static String getConfig() => '${baseUrlV1}config';

  // ===================== Wheel Spinner =====================

  static String spinWheel() => 'customer/wheel-spinner/spin';
  static String wheelSpinHistory() => 'customer/wheel-spinner/history';
  static String getAllSpinners() => 'wheel-spinner/all';
  static String getSpinnerFreeProducts(Map<String, String> params) =>
      'wheel-spinner/free-products?${mapToQueryParams(params)}';
  static String spinTheWheel(int id) => 'wheel-spinner/$id/spin';
  static String getBuyOneGetOneFree(Map<String, String> params) =>
      'wheel-spinner/buy-get-another-free?${mapToQueryParams(params)}';
  // ===================== Special Offers =====================
  static String getAllSpecialOffers() => 'special-offers';
}
