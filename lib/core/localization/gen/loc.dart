import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'loc_ar.dart';
import 'loc_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of Loc
/// returned by `Loc.of(context)`.
///
/// Applications need to include `Loc.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/loc.dart';
///
/// return MaterialApp(
///   localizationsDelegates: Loc.localizationsDelegates,
///   supportedLocales: Loc.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the Loc.supportedLocales
/// property.
abstract class Loc {
  Loc(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static Loc of(BuildContext context) {
    return Localizations.of<Loc>(context, Loc)!;
  }

  static const LocalizationsDelegate<Loc> delegate = _LocDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @addCard.
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// No description provided for @addNMins.
  ///
  /// In en, this message translates to:
  /// **'Add {count, plural, =0{no-mins} =1{1-min} other{{count} mins}}'**
  String addNMins(num count);

  /// No description provided for @add_balance.
  ///
  /// In en, this message translates to:
  /// **'Add Balance'**
  String get add_balance;

  /// No description provided for @add_coupon.
  ///
  /// In en, this message translates to:
  /// **'Add Coupon'**
  String get add_coupon;

  /// No description provided for @add_item.
  ///
  /// In en, this message translates to:
  /// **'Add item'**
  String get add_item;

  /// No description provided for @add_to_cart.
  ///
  /// In en, this message translates to:
  /// **'Add to cart'**
  String get add_to_cart;

  /// No description provided for @add_your_comment.
  ///
  /// In en, this message translates to:
  /// **'Do you have any comments ?'**
  String get add_your_comment;

  /// No description provided for @add_your_comment_hint.
  ///
  /// In en, this message translates to:
  /// **'Add Your Comment'**
  String get add_your_comment_hint;

  /// No description provided for @allowNotifications.
  ///
  /// In en, this message translates to:
  /// **'Allow Notifications'**
  String get allowNotifications;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// No description provided for @are_you_sure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get are_you_sure;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get balance;

  /// No description provided for @better_luck_next_time.
  ///
  /// In en, this message translates to:
  /// **'Better Luck Next Time'**
  String get better_luck_next_time;

  /// No description provided for @buyFiveGetOne.
  ///
  /// In en, this message translates to:
  /// **'Buy 5 Get 1'**
  String get buyFiveGetOne;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @cancel_order.
  ///
  /// In en, this message translates to:
  /// **'Cancel Order'**
  String get cancel_order;

  /// No description provided for @cancel_reward_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this reward?'**
  String get cancel_reward_message;

  /// No description provided for @cancel_reward_message_desc.
  ///
  /// In en, this message translates to:
  /// **'Once canceled, you will lose this reward opportunity'**
  String get cancel_reward_message_desc;

  /// No description provided for @canceled.
  ///
  /// In en, this message translates to:
  /// **'Canceled'**
  String get canceled;

  /// No description provided for @canceled_orders.
  ///
  /// In en, this message translates to:
  /// **'Canceled Orders'**
  String get canceled_orders;

  /// No description provided for @cardHolderName.
  ///
  /// In en, this message translates to:
  /// **'Card Holder Name'**
  String get cardHolderName;

  /// No description provided for @cardNumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumber;

  /// No description provided for @cart.
  ///
  /// In en, this message translates to:
  /// **'Cart'**
  String get cart;

  /// No description provided for @cart_is_empty.
  ///
  /// In en, this message translates to:
  /// **'Cart is empty'**
  String get cart_is_empty;

  /// No description provided for @cash.
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get cash;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @choose_n.
  ///
  /// In en, this message translates to:
  /// **'Choose {count}'**
  String choose_n(Object count);

  /// No description provided for @claim.
  ///
  /// In en, this message translates to:
  /// **'Claim'**
  String get claim;

  /// No description provided for @claim_your_free_cup.
  ///
  /// In en, this message translates to:
  /// **'Claim Your Free Cup'**
  String get claim_your_free_cup;

  /// No description provided for @claro_coffee_app.
  ///
  /// In en, this message translates to:
  /// **'Claro coffee App'**
  String get claro_coffee_app;

  /// No description provided for @code_copied.
  ///
  /// In en, this message translates to:
  /// **'Code Copied'**
  String get code_copied;

  /// No description provided for @coffee_points.
  ///
  /// In en, this message translates to:
  /// **'Coffee Points'**
  String get coffee_points;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @completed_orders.
  ///
  /// In en, this message translates to:
  /// **'Completed Orders'**
  String get completed_orders;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @confirm_password.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirm_password;

  /// No description provided for @confirm_password_hint.
  ///
  /// In en, this message translates to:
  /// **'**** **** ****'**
  String get confirm_password_hint;

  /// No description provided for @confirm_profile_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your profile information before proceeding'**
  String get confirm_profile_subtitle;

  /// No description provided for @confirm_profile_title.
  ///
  /// In en, this message translates to:
  /// **'Confirm Profile'**
  String get confirm_profile_title;

  /// No description provided for @congratulations.
  ///
  /// In en, this message translates to:
  /// **'Congratulations'**
  String get congratulations;

  /// No description provided for @copy_code.
  ///
  /// In en, this message translates to:
  /// **'COPY CODE'**
  String get copy_code;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @coupon.
  ///
  /// In en, this message translates to:
  /// **'Coupon'**
  String get coupon;

  /// No description provided for @coupon_applied.
  ///
  /// In en, this message translates to:
  /// **'Coupon successfully applied'**
  String get coupon_applied;

  /// No description provided for @coupons.
  ///
  /// In en, this message translates to:
  /// **'Coupons'**
  String get coupons;

  /// No description provided for @coupons_for_you.
  ///
  /// In en, this message translates to:
  /// **'Coupons for you'**
  String get coupons_for_you;

  /// No description provided for @create_new_password.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get create_new_password;

  /// No description provided for @create_order.
  ///
  /// In en, this message translates to:
  /// **'Create Order'**
  String get create_order;

  /// No description provided for @creditAndDebitCard.
  ///
  /// In en, this message translates to:
  /// **'Credit & Debit Card'**
  String get creditAndDebitCard;

  /// No description provided for @cup_n.
  ///
  /// In en, this message translates to:
  /// **'Cup {count}'**
  String cup_n(Object count);

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days}d'**
  String daysAgo(Object days);

  /// No description provided for @delay_option_hint.
  ///
  /// In en, this message translates to:
  /// **'You can delay the pickup'**
  String get delay_option_hint;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @delete_account.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get delete_account;

  /// No description provided for @delete_account_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete your account?'**
  String get delete_account_message;

  /// No description provided for @delete_account_message_desc.
  ///
  /// In en, this message translates to:
  /// **'This action cannot be undone. All your data will be permanently deleted'**
  String get delete_account_message_desc;

  /// No description provided for @didnt_receive_otp.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the code?'**
  String get didnt_receive_otp;

  /// No description provided for @discount.
  ///
  /// In en, this message translates to:
  /// **'Discount'**
  String get discount;

  /// No description provided for @discount_reward.
  ///
  /// In en, this message translates to:
  /// **'Discount Reward'**
  String get discount_reward;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @dont_have_account.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dont_have_account;

  /// No description provided for @earn_points.
  ///
  /// In en, this message translates to:
  /// **'You earn Points'**
  String get earn_points;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @email_hint.
  ///
  /// In en, this message translates to:
  /// **'example@gmail.com'**
  String get email_hint;

  /// No description provided for @empty_field.
  ///
  /// In en, this message translates to:
  /// **'{field} should not be empty'**
  String empty_field(Object field);

  /// No description provided for @enableNotificationAccess.
  ///
  /// In en, this message translates to:
  /// **'Enable Notification Access'**
  String get enableNotificationAccess;

  /// No description provided for @enableNotificationsToStayUpToDate.
  ///
  /// In en, this message translates to:
  /// **'enable notifications to stay up-to-date'**
  String get enableNotificationsToStayUpToDate;

  /// No description provided for @enjoy_benefits_through_the.
  ///
  /// In en, this message translates to:
  /// **'enjoy benefits through the'**
  String get enjoy_benefits_through_the;

  /// No description provided for @enjoying_coffee.
  ///
  /// In en, this message translates to:
  /// **'Enjoying Coffee'**
  String get enjoying_coffee;

  /// No description provided for @enter_coupon_code.
  ///
  /// In en, this message translates to:
  /// **'Enter coupon code'**
  String get enter_coupon_code;

  /// No description provided for @error_While_getting_data.
  ///
  /// In en, this message translates to:
  /// **'Error while getting data'**
  String get error_While_getting_data;

  /// No description provided for @error_while_getting_spin_wheel_data.
  ///
  /// In en, this message translates to:
  /// **'Error while getting spin wheel data'**
  String get error_while_getting_spin_wheel_data;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @fREE.
  ///
  /// In en, this message translates to:
  /// **'FREE'**
  String get fREE;

  /// No description provided for @forgot_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgot_password;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @friday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get friday;

  /// No description provided for @get_special_offer.
  ///
  /// In en, this message translates to:
  /// **'Get Special Offer'**
  String get get_special_offer;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours}h'**
  String hoursAgo(Object hours);

  /// No description provided for @invalid_card_holder_name.
  ///
  /// In en, this message translates to:
  /// **'Invalid Card Holder Name'**
  String get invalid_card_holder_name;

  /// No description provided for @invalid_card_number.
  ///
  /// In en, this message translates to:
  /// **'Invalid Card Number'**
  String get invalid_card_number;

  /// No description provided for @invalid_cvv.
  ///
  /// In en, this message translates to:
  /// **'Invalid CVV'**
  String get invalid_cvv;

  /// No description provided for @invalid_email.
  ///
  /// In en, this message translates to:
  /// **'Invalid Email'**
  String get invalid_email;

  /// No description provided for @invalid_expiry_date.
  ///
  /// In en, this message translates to:
  /// **'Invalid Expiry Date'**
  String get invalid_expiry_date;

  /// No description provided for @invalid_name.
  ///
  /// In en, this message translates to:
  /// **'Invalid Name'**
  String get invalid_name;

  /// No description provided for @invalid_phone.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalid_phone;

  /// No description provided for @items_count.
  ///
  /// In en, this message translates to:
  /// **'Items Count'**
  String get items_count;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get justNow;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @lastWeek.
  ///
  /// In en, this message translates to:
  /// **'Last Week'**
  String get lastWeek;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @loading_more.
  ///
  /// In en, this message translates to:
  /// **'Loading more...'**
  String get loading_more;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @maybeLater.
  ///
  /// In en, this message translates to:
  /// **'Maybe Later'**
  String get maybeLater;

  /// No description provided for @menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get menu;

  /// No description provided for @minsAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes}m'**
  String minsAgo(Object minutes);

  /// No description provided for @monday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get monday;

  /// No description provided for @monthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{months}mo'**
  String monthsAgo(Object months);

  /// No description provided for @morePaymentOptions.
  ///
  /// In en, this message translates to:
  /// **'More Payment Options'**
  String get morePaymentOptions;

  /// No description provided for @more_suggestions.
  ///
  /// In en, this message translates to:
  /// **'More Suggestions'**
  String get more_suggestions;

  /// No description provided for @my_orders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get my_orders;

  /// No description provided for @my_reward_p_m.
  ///
  /// In en, this message translates to:
  /// **'My Reward ({progress} / {max})'**
  String my_reward_p_m(Object max, Object progress);

  /// No description provided for @nItems.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no items} =1{1 item} other{{count} items}}'**
  String nItems(num count);

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @name_hint.
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get name_hint;

  /// No description provided for @new_password.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get new_password;

  /// No description provided for @new_password_description.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be different from\npreviously used passwords'**
  String get new_password_description;

  /// No description provided for @no_Branch_selected.
  ///
  /// In en, this message translates to:
  /// **'No Branch Selected'**
  String get no_Branch_selected;

  /// No description provided for @no_description.
  ///
  /// In en, this message translates to:
  /// **'No Description'**
  String get no_description;

  /// No description provided for @no_recorded_data_found.
  ///
  /// In en, this message translates to:
  /// **'No Recorded Data Found'**
  String get no_recorded_data_found;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @offer_products.
  ///
  /// In en, this message translates to:
  /// **'Offer Products'**
  String get offer_products;

  /// No description provided for @on_boarding_subtitle1.
  ///
  /// In en, this message translates to:
  /// **'Enjoy a cup of coffee full of flavor from Claro Coffee in just one application'**
  String get on_boarding_subtitle1;

  /// No description provided for @on_boarding_subtitle2.
  ///
  /// In en, this message translates to:
  /// **'Skip the wait, enjoy daily deals, earn Claro Points, and more exciting exclusive offers!'**
  String get on_boarding_subtitle2;

  /// No description provided for @on_boarding_subtitle3.
  ///
  /// In en, this message translates to:
  /// **'Your daily coffee just got better. Enjoy exclusive rewards with our app'**
  String get on_boarding_subtitle3;

  /// No description provided for @option.
  ///
  /// In en, this message translates to:
  /// **'Option'**
  String get option;

  /// No description provided for @or_sign_in_with.
  ///
  /// In en, this message translates to:
  /// **'Or sign in with'**
  String get or_sign_in_with;

  /// No description provided for @order_now.
  ///
  /// In en, this message translates to:
  /// **'Order Now'**
  String get order_now;

  /// No description provided for @order_ready_message.
  ///
  /// In en, this message translates to:
  /// **'On time we’ve got your order'**
  String get order_ready_message;

  /// No description provided for @orders.
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get orders;

  /// No description provided for @otp_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the verification code sent to your mobile'**
  String get otp_subtitle;

  /// No description provided for @our_branches.
  ///
  /// In en, this message translates to:
  /// **'Our Branches'**
  String get our_branches;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @password_hint.
  ///
  /// In en, this message translates to:
  /// **'**** **** ****'**
  String get password_hint;

  /// No description provided for @password_mismatch.
  ///
  /// In en, this message translates to:
  /// **'Password mismatch'**
  String get password_mismatch;

  /// No description provided for @payment_methods.
  ///
  /// In en, this message translates to:
  /// **'Payment Methods'**
  String get payment_methods;

  /// No description provided for @payment_transfer.
  ///
  /// In en, this message translates to:
  /// **'Payment Transfer'**
  String get payment_transfer;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Mobile'**
  String get phone;

  /// No description provided for @phone_hint.
  ///
  /// In en, this message translates to:
  /// **'55 701 5031'**
  String get phone_hint;

  /// No description provided for @please_add_new_order_or_wait_for_order_to_appear_here.
  ///
  /// In en, this message translates to:
  /// **'Please add a new order or wait for the order to appear here'**
  String get please_add_new_order_or_wait_for_order_to_appear_here;

  /// No description provided for @please_select_product_options.
  ///
  /// In en, this message translates to:
  /// **'Please select product options'**
  String get please_select_product_options;

  /// No description provided for @point.
  ///
  /// In en, this message translates to:
  /// **'Point'**
  String get point;

  /// No description provided for @points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get points;

  /// No description provided for @points_equality_desc_prefix.
  ///
  /// In en, this message translates to:
  /// **'{points} Points is equal to'**
  String points_equality_desc_prefix(Object points);

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @pull_to_refresh.
  ///
  /// In en, this message translates to:
  /// **'Pull to refresh'**
  String get pull_to_refresh;

  /// No description provided for @qr.
  ///
  /// In en, this message translates to:
  /// **'QR'**
  String get qr;

  /// No description provided for @qrCode.
  ///
  /// In en, this message translates to:
  /// **'QR Code'**
  String get qrCode;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get ready;

  /// No description provided for @recent_search.
  ///
  /// In en, this message translates to:
  /// **'Recent Search'**
  String get recent_search;

  /// No description provided for @recent_view.
  ///
  /// In en, this message translates to:
  /// **'Recent View'**
  String get recent_view;

  /// No description provided for @recently_transactions.
  ///
  /// In en, this message translates to:
  /// **'Recent Transactions'**
  String get recently_transactions;

  /// No description provided for @resend_code.
  ///
  /// In en, this message translates to:
  /// **'Resend Code'**
  String get resend_code;

  /// No description provided for @saturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get saturday;

  /// No description provided for @scanToPay.
  ///
  /// In en, this message translates to:
  /// **'Scan to pay'**
  String get scanToPay;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @secsAgo.
  ///
  /// In en, this message translates to:
  /// **'{seconds}s'**
  String secsAgo(Object seconds);

  /// No description provided for @see_all.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get see_all;

  /// No description provided for @select_branch.
  ///
  /// In en, this message translates to:
  /// **'Select Branch'**
  String get select_branch;

  /// No description provided for @select_options.
  ///
  /// In en, this message translates to:
  /// **'Select Options'**
  String get select_options;

  /// No description provided for @select_time.
  ///
  /// In en, this message translates to:
  /// **'Select Time'**
  String get select_time;

  /// No description provided for @select_your_branch.
  ///
  /// In en, this message translates to:
  /// **'Select Your Branch'**
  String get select_your_branch;

  /// No description provided for @server_error.
  ///
  /// In en, this message translates to:
  /// **'Server Error'**
  String get server_error;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @share_the_Perks_with_the.
  ///
  /// In en, this message translates to:
  /// **'Share the perks with the'**
  String get share_the_Perks_with_the;

  /// No description provided for @short_password.
  ///
  /// In en, this message translates to:
  /// **'Short Password'**
  String get short_password;

  /// No description provided for @sign_in.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get sign_in;

  /// No description provided for @sign_in_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Hi! Sign in with your mobile number to continue'**
  String get sign_in_subtitle;

  /// No description provided for @sign_up.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get sign_up;

  /// No description provided for @signatures.
  ///
  /// In en, this message translates to:
  /// **'Signatures'**
  String get signatures;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @something_went_wrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get something_went_wrong;

  /// No description provided for @special_offers.
  ///
  /// In en, this message translates to:
  /// **'Special Offers'**
  String get special_offers;

  /// No description provided for @spin.
  ///
  /// In en, this message translates to:
  /// **'Spin'**
  String get spin;

  /// No description provided for @spin_and_win.
  ///
  /// In en, this message translates to:
  /// **'Spin & Win'**
  String get spin_and_win;

  /// No description provided for @spinner.
  ///
  /// In en, this message translates to:
  /// **'Spinner'**
  String get spinner;

  /// No description provided for @spinner_products.
  ///
  /// In en, this message translates to:
  /// **'Spinner Products'**
  String get spinner_products;

  /// No description provided for @spinners.
  ///
  /// In en, this message translates to:
  /// **'Spinners'**
  String get spinners;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @subtotal.
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get subtotal;

  /// No description provided for @successfully_added.
  ///
  /// In en, this message translates to:
  /// **'{item} successfully added'**
  String successfully_added(Object item);

  /// No description provided for @sunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get sunday;

  /// No description provided for @taxes.
  ///
  /// In en, this message translates to:
  /// **'Taxes'**
  String get taxes;

  /// No description provided for @the_best_experience.
  ///
  /// In en, this message translates to:
  /// **'The Best Experience'**
  String get the_best_experience;

  /// No description provided for @there_are_no_order_to_track.
  ///
  /// In en, this message translates to:
  /// **'There are no orders to track'**
  String get there_are_no_order_to_track;

  /// No description provided for @thursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get thursday;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @todays_offers.
  ///
  /// In en, this message translates to:
  /// **'Today’s Offers'**
  String get todays_offers;

  /// No description provided for @top_requested_products.
  ///
  /// In en, this message translates to:
  /// **'Top Requested Products'**
  String get top_requested_products;

  /// No description provided for @total_coffees_point.
  ///
  /// In en, this message translates to:
  /// **'Total Coffees Point'**
  String get total_coffees_point;

  /// No description provided for @total_price.
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get total_price;

  /// No description provided for @transfer.
  ///
  /// In en, this message translates to:
  /// **'Transfer'**
  String get transfer;

  /// No description provided for @transfer_amount.
  ///
  /// In en, this message translates to:
  /// **'Transfer Amount'**
  String get transfer_amount;

  /// No description provided for @transfer_to.
  ///
  /// In en, this message translates to:
  /// **'Transfer To'**
  String get transfer_to;

  /// No description provided for @try_spinner_again.
  ///
  /// In en, this message translates to:
  /// **'Try Spinner Again'**
  String get try_spinner_again;

  /// No description provided for @try_your_luck.
  ///
  /// In en, this message translates to:
  /// **'Try Your Luck'**
  String get try_your_luck;

  /// No description provided for @tuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get tuesday;

  /// No description provided for @unlock_h_m.
  ///
  /// In en, this message translates to:
  /// **'Unlock {hours,plural,=0{}other{{hours}h }}{minutes,plural,=0{}other{{minutes}m}}'**
  String unlock_h_m(num hours, num minutes);

  /// No description provided for @unlock_later.
  ///
  /// In en, this message translates to:
  /// **'Unlock Later'**
  String get unlock_later;

  /// No description provided for @up_to_percent.
  ///
  /// In en, this message translates to:
  /// **'Up to {percent}%'**
  String up_to_percent(Object percent);

  /// No description provided for @use_points.
  ///
  /// In en, this message translates to:
  /// **'You use Points'**
  String get use_points;

  /// No description provided for @verify_code.
  ///
  /// In en, this message translates to:
  /// **'Verify Code'**
  String get verify_code;

  /// No description provided for @view_cart.
  ///
  /// In en, this message translates to:
  /// **'View cart'**
  String get view_cart;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @weak_password.
  ///
  /// In en, this message translates to:
  /// **'Weak Password'**
  String get weak_password;

  /// No description provided for @wednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get wednesday;

  /// No description provided for @weeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{weeks}w'**
  String weeksAgo(Object weeks);

  /// No description provided for @yearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{years}y'**
  String yearsAgo(Object years);

  /// No description provided for @yesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// No description provided for @youHaveWon.
  ///
  /// In en, this message translates to:
  /// **'🎉 You have won 🥳'**
  String get youHaveWon;

  /// No description provided for @your_booking_is_confirmed.
  ///
  /// In en, this message translates to:
  /// **'Your booking is confirmed'**
  String get your_booking_is_confirmed;

  /// No description provided for @branch_proximity_detection.
  ///
  /// In en, this message translates to:
  /// **'Branch proximity detection'**
  String get branch_proximity_detection;

  /// No description provided for @proximity_tracking_enabled.
  ///
  /// In en, this message translates to:
  /// **'Proximity tracking enabled successfully'**
  String get proximity_tracking_enabled;

  /// No description provided for @enable_location_tracking_description.
  ///
  /// In en, this message translates to:
  /// **'Would you like to enable location tracking to notify the branch when you\'re approaching?'**
  String get enable_location_tracking_description;

  /// No description provided for @setting_up_location_tracking.
  ///
  /// In en, this message translates to:
  /// **'Setting up location tracking...'**
  String get setting_up_location_tracking;

  /// No description provided for @location_tracking_disabled.
  ///
  /// In en, this message translates to:
  /// **'Location tracking disabled'**
  String get location_tracking_disabled;

  /// No description provided for @pay_with_credit_card.
  ///
  /// In en, this message translates to:
  /// **'Pay with Credit Card'**
  String get pay_with_credit_card;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @payment_successful.
  ///
  /// In en, this message translates to:
  /// **'Payment successful'**
  String get payment_successful;

  /// No description provided for @payment_failed.
  ///
  /// In en, this message translates to:
  /// **'Payment failed'**
  String get payment_failed;

  /// No description provided for @try_again.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get try_again;

  /// No description provided for @reward_products.
  ///
  /// In en, this message translates to:
  /// **'Reward Products'**
  String get reward_products;

  /// No description provided for @get_your_reward.
  ///
  /// In en, this message translates to:
  /// **'Get your reward'**
  String get get_your_reward;

  /// No description provided for @choose_your_reward.
  ///
  /// In en, this message translates to:
  /// **'Choose your reward'**
  String get choose_your_reward;

  /// No description provided for @pay_one_and_get_one_free.
  ///
  /// In en, this message translates to:
  /// **'Pay one and get one free'**
  String get pay_one_and_get_one_free;

  /// No description provided for @please_select_paid_drink.
  ///
  /// In en, this message translates to:
  /// **'Please select paid drink'**
  String get please_select_paid_drink;

  /// No description provided for @please_select_free_drink.
  ///
  /// In en, this message translates to:
  /// **'Please select free drink'**
  String get please_select_free_drink;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @choose_first_product.
  ///
  /// In en, this message translates to:
  /// **'Choose first product'**
  String get choose_first_product;

  /// No description provided for @choose_second_product.
  ///
  /// In en, this message translates to:
  /// **'Choose second product'**
  String get choose_second_product;

  /// No description provided for @first.
  ///
  /// In en, this message translates to:
  /// **'First'**
  String get first;

  /// No description provided for @second.
  ///
  /// In en, this message translates to:
  /// **'Second'**
  String get second;

  /// No description provided for @get_free_drink.
  ///
  /// In en, this message translates to:
  /// **'Get free drink'**
  String get get_free_drink;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @force_update.
  ///
  /// In en, this message translates to:
  /// **'Force Update'**
  String get force_update;

  /// No description provided for @invalid_points.
  ///
  /// In en, this message translates to:
  /// **'Invalid Points'**
  String get invalid_points;

  /// No description provided for @transfer_success.
  ///
  /// In en, this message translates to:
  /// **'Transfer Success'**
  String get transfer_success;

  /// No description provided for @field_required.
  ///
  /// In en, this message translates to:
  /// **'Field required'**
  String get field_required;

  /// No description provided for @enter_email.
  ///
  /// In en, this message translates to:
  /// **'Enter email'**
  String get enter_email;

  /// No description provided for @enter_email_or_phone.
  ///
  /// In en, this message translates to:
  /// **'Enter email or phone'**
  String get enter_email_or_phone;

  /// No description provided for @sms_otp_uae_only.
  ///
  /// In en, this message translates to:
  /// **'SMS OTP service is only available in UAE'**
  String get sms_otp_uae_only;

  /// No description provided for @manual_otp_entry_required.
  ///
  /// In en, this message translates to:
  /// **'Please enter the OTP manually'**
  String get manual_otp_entry_required;

  /// No description provided for @code_sent_successfully.
  ///
  /// In en, this message translates to:
  /// **'Code sent successfully'**
  String get code_sent_successfully;

  /// No description provided for @pleaseSelectUAECountry.
  ///
  /// In en, this message translates to:
  /// **'Please select UAE Country (+971)'**
  String get pleaseSelectUAECountry;

  /// No description provided for @bestSellers.
  ///
  /// In en, this message translates to:
  /// **'Best Sellers'**
  String get bestSellers;

  /// No description provided for @dont_have_account_sign_up_now.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign up now'**
  String get dont_have_account_sign_up_now;

  /// No description provided for @register_success.
  ///
  /// In en, this message translates to:
  /// **'Registration successful'**
  String get register_success;

  /// No description provided for @sign_up_description.
  ///
  /// In en, this message translates to:
  /// **'Hello! Create an account using your phone number to continue'**
  String get sign_up_description;

  /// No description provided for @order_number.
  ///
  /// In en, this message translates to:
  /// **'Order Number #{number}'**
  String order_number(Object number);

  /// No description provided for @newlyReleased.
  ///
  /// In en, this message translates to:
  /// **'Newly Released'**
  String get newlyReleased;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @products_selected.
  ///
  /// In en, this message translates to:
  /// **'Products Selected'**
  String get products_selected;

  /// No description provided for @are_you_sure_cancel_order.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel the order'**
  String get are_you_sure_cancel_order;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @yes_cancel.
  ///
  /// In en, this message translates to:
  /// **'Yes, Cancel'**
  String get yes_cancel;

  /// No description provided for @edit_order.
  ///
  /// In en, this message translates to:
  /// **'Edit Order'**
  String get edit_order;

  /// No description provided for @order_summary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get order_summary;

  /// No description provided for @original_subtotal.
  ///
  /// In en, this message translates to:
  /// **'Original Subtotal'**
  String get original_subtotal;

  /// No description provided for @new_subtotal.
  ///
  /// In en, this message translates to:
  /// **'New Subtotal'**
  String get new_subtotal;

  /// No description provided for @difference.
  ///
  /// In en, this message translates to:
  /// **'Difference'**
  String get difference;

  /// No description provided for @update_order.
  ///
  /// In en, this message translates to:
  /// **'Update Order'**
  String get update_order;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @remove_product.
  ///
  /// In en, this message translates to:
  /// **'Remove Product'**
  String get remove_product;

  /// No description provided for @from_the_order.
  ///
  /// In en, this message translates to:
  /// **'from the order'**
  String get from_the_order;

  /// No description provided for @are_you_sure_remove_product.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to remove this product'**
  String get are_you_sure_remove_product;

  /// No description provided for @nearest_branch_updated.
  ///
  /// In en, this message translates to:
  /// **'Nearest branch updated'**
  String get nearest_branch_updated;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @the_nearest_branch_is.
  ///
  /// In en, this message translates to:
  /// **'The nearest branch is'**
  String get the_nearest_branch_is;

  /// No description provided for @auto_assigned_branch.
  ///
  /// In en, this message translates to:
  /// **'Auto assigned branch'**
  String get auto_assigned_branch;

  /// No description provided for @modify_feature.
  ///
  /// In en, this message translates to:
  /// **'Modify feature'**
  String get modify_feature;
}

class _LocDelegate extends LocalizationsDelegate<Loc> {
  const _LocDelegate();

  @override
  Future<Loc> load(Locale locale) {
    return SynchronousFuture<Loc>(lookupLoc(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_LocDelegate old) => false;
}

Loc lookupLoc(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return LocAr();
    case 'en':
      return LocEn();
  }

  throw FlutterError(
      'Loc.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
