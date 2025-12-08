// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'loc.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class LocEn extends Loc {
  LocEn([String locale = 'en']) : super(locale);

  @override
  String get active => 'Active';

  @override
  String get add => 'Add';

  @override
  String get addCard => 'Add Card';

  @override
  String addNMins(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mins',
      one: '1-min',
      zero: 'no-mins',
    );
    return 'Add $_temp0';
  }

  @override
  String get add_balance => 'Add Balance';

  @override
  String get add_coupon => 'Add Coupon';

  @override
  String get add_item => 'Add item';

  @override
  String get add_to_cart => 'Add to cart';

  @override
  String get add_your_comment => 'Do you have any comments ?';

  @override
  String get add_your_comment_hint => 'Add Your Comment';

  @override
  String get allowNotifications => 'Allow Notifications';

  @override
  String get apply => 'Apply';

  @override
  String get are_you_sure => 'Are you sure?';

  @override
  String get balance => 'Balance';

  @override
  String get better_luck_next_time => 'Better Luck Next Time';

  @override
  String get buyFiveGetOne => 'Buy 5 Get 1';

  @override
  String get cancel => 'Cancel';

  @override
  String get cancel_order => 'Cancel Order';

  @override
  String get cancel_reward_message =>
      'Are you sure you want to cancel this reward?';

  @override
  String get cancel_reward_message_desc =>
      'Once canceled, you will lose this reward opportunity';

  @override
  String get canceled => 'Canceled';

  @override
  String get canceled_orders => 'Canceled Orders';

  @override
  String get cardHolderName => 'Card Holder Name';

  @override
  String get cardNumber => 'Card Number';

  @override
  String get cart => 'Cart';

  @override
  String get cart_is_empty => 'Cart is empty';

  @override
  String get cash => 'Cash';

  @override
  String get checkout => 'Checkout';

  @override
  String choose_n(Object count) {
    return 'Choose $count';
  }

  @override
  String get claim => 'Claim';

  @override
  String get claim_your_free_cup => 'Claim Your Free Cup';

  @override
  String get claro_coffee_app => 'Claro coffee App';

  @override
  String get code_copied => 'Code Copied';

  @override
  String get coffee_points => 'Coffee Points';

  @override
  String get completed => 'Completed';

  @override
  String get completed_orders => 'Completed Orders';

  @override
  String get confirm => 'Confirm';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get confirm_password_hint => '**** **** ****';

  @override
  String get confirm_profile_subtitle =>
      'Please confirm your profile information before proceeding';

  @override
  String get confirm_profile_title => 'Confirm Profile';

  @override
  String get congratulations => 'Congratulations';

  @override
  String get copy_code => 'COPY CODE';

  @override
  String get country => 'Country';

  @override
  String get coupon => 'Coupon';

  @override
  String get coupon_applied => 'Coupon successfully applied';

  @override
  String get coupons => 'Coupons';

  @override
  String get coupons_for_you => 'Coupons for you';

  @override
  String get create_new_password => 'Create New Password';

  @override
  String get create_order => 'Create Order';

  @override
  String get creditAndDebitCard => 'Credit & Debit Card';

  @override
  String cup_n(Object count) {
    return 'Cup $count';
  }

  @override
  String get cvv => 'CVV';

  @override
  String daysAgo(Object days) {
    return '${days}d';
  }

  @override
  String get delay_option_hint => 'You can delay the pickup';

  @override
  String get delete => 'Delete';

  @override
  String get delete_account => 'Delete Account';

  @override
  String get delete_account_message =>
      'Are you sure you want to delete your account?';

  @override
  String get delete_account_message_desc =>
      'This action cannot be undone. All your data will be permanently deleted';

  @override
  String get didnt_receive_otp => 'Didn\'t receive the code?';

  @override
  String get discount => 'Discount';

  @override
  String get discount_reward => 'Discount Reward';

  @override
  String get done => 'Done';

  @override
  String get dont_have_account => 'Don\'t have an account?';

  @override
  String get earn_points => 'You earn Points';

  @override
  String get email => 'Email';

  @override
  String get email_hint => 'example@gmail.com';

  @override
  String empty_field(Object field) {
    return '$field should not be empty';
  }

  @override
  String get enableNotificationAccess => 'Enable Notification Access';

  @override
  String get enableNotificationsToStayUpToDate =>
      'enable notifications to stay up-to-date';

  @override
  String get enjoy_benefits_through_the => 'enjoy benefits through the';

  @override
  String get enjoying_coffee => 'Enjoying Coffee';

  @override
  String get enter_coupon_code => 'Enter coupon code';

  @override
  String get error_While_getting_data => 'Error while getting data';

  @override
  String get error_while_getting_spin_wheel_data =>
      'Error while getting spin wheel data';

  @override
  String get expiryDate => 'Expiry Date';

  @override
  String get fREE => 'FREE';

  @override
  String get forgot_password => 'Forgot Password';

  @override
  String get free => 'Free';

  @override
  String get friday => 'Friday';

  @override
  String get get_special_offer => 'Get Special Offer';

  @override
  String get home => 'Home';

  @override
  String hoursAgo(Object hours) {
    return '${hours}h';
  }

  @override
  String get invalid_card_holder_name => 'Invalid Card Holder Name';

  @override
  String get invalid_card_number => 'Invalid Card Number';

  @override
  String get invalid_cvv => 'Invalid CVV';

  @override
  String get invalid_email => 'Invalid Email';

  @override
  String get invalid_expiry_date => 'Invalid Expiry Date';

  @override
  String get invalid_name => 'Invalid Name';

  @override
  String get invalid_phone => 'Invalid phone number';

  @override
  String get items_count => 'Items Count';

  @override
  String get justNow => 'Now';

  @override
  String get language => 'Language';

  @override
  String get lastWeek => 'Last Week';

  @override
  String get loading => 'Loading...';

  @override
  String get loading_more => 'Loading more...';

  @override
  String get location => 'Location';

  @override
  String get maybeLater => 'Maybe Later';

  @override
  String get menu => 'Menu';

  @override
  String minsAgo(Object minutes) {
    return '${minutes}m';
  }

  @override
  String get monday => 'Monday';

  @override
  String monthsAgo(Object months) {
    return '${months}mo';
  }

  @override
  String get morePaymentOptions => 'More Payment Options';

  @override
  String get more_suggestions => 'More Suggestions';

  @override
  String get my_orders => 'My Orders';

  @override
  String my_reward_p_m(Object max, Object progress) {
    return 'My Reward ($progress / $max)';
  }

  @override
  String nItems(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count items',
      one: '1 item',
      zero: 'no items',
    );
    return '$_temp0';
  }

  @override
  String get name => 'Name';

  @override
  String get name_hint => 'Enter your name';

  @override
  String get new_password => 'New Password';

  @override
  String get new_password_description =>
      'Your new password must be different from\npreviously used passwords';

  @override
  String get no_Branch_selected => 'No Branch Selected';

  @override
  String get no_description => 'No Description';

  @override
  String get no_recorded_data_found => 'No Recorded Data Found';

  @override
  String get notifications => 'Notifications';

  @override
  String get offer_products => 'Offer Products';

  @override
  String get on_boarding_subtitle1 =>
      'Enjoy a cup of coffee full of flavor from Claro Coffee in just one application';

  @override
  String get on_boarding_subtitle2 =>
      'Skip the wait, enjoy daily deals, earn Claro Points, and more exciting exclusive offers!';

  @override
  String get on_boarding_subtitle3 =>
      'Your daily coffee just got better. Enjoy exclusive rewards with our app';

  @override
  String get option => 'Option';

  @override
  String get or_sign_in_with => 'Or sign in with';

  @override
  String get order_now => 'Order Now';

  @override
  String get order_ready_message => 'On time we’ve got your order';

  @override
  String get orders => 'Orders';

  @override
  String get otp_subtitle => 'Enter the verification code sent to your mobile';

  @override
  String get our_branches => 'Our Branches';

  @override
  String get password => 'Password';

  @override
  String get password_hint => '**** **** ****';

  @override
  String get password_mismatch => 'Password mismatch';

  @override
  String get payment_methods => 'Payment Methods';

  @override
  String get payment_transfer => 'Payment Transfer';

  @override
  String get phone => 'Mobile';

  @override
  String get phone_hint => '55 701 5031';

  @override
  String get please_add_new_order_or_wait_for_order_to_appear_here =>
      'Please add a new order or wait for the order to appear here';

  @override
  String get please_select_product_options => 'Please select product options';

  @override
  String get point => 'Point';

  @override
  String get points => 'Points';

  @override
  String points_equality_desc_prefix(Object points) {
    return '$points Points is equal to';
  }

  @override
  String get profile => 'Profile';

  @override
  String get pull_to_refresh => 'Pull to refresh';

  @override
  String get qr => 'QR';

  @override
  String get qrCode => 'QR Code';

  @override
  String get quantity => 'Quantity';

  @override
  String get ready => 'Ready';

  @override
  String get recent_search => 'Recent Search';

  @override
  String get recent_view => 'Recent View';

  @override
  String get recently_transactions => 'Recent Transactions';

  @override
  String get resend_code => 'Resend Code';

  @override
  String get saturday => 'Saturday';

  @override
  String get scanToPay => 'Scan to pay';

  @override
  String get search => 'Search';

  @override
  String secsAgo(Object seconds) {
    return '${seconds}s';
  }

  @override
  String get see_all => 'See All';

  @override
  String get select_branch => 'Select Branch';

  @override
  String get select_options => 'Select Options';

  @override
  String get select_time => 'Select Time';

  @override
  String get select_your_branch => 'Select Your Branch';

  @override
  String get server_error => 'Server Error';

  @override
  String get settings => 'Settings';

  @override
  String get share_the_Perks_with_the => 'Share the perks with the';

  @override
  String get short_password => 'Short Password';

  @override
  String get sign_in => 'Sign In';

  @override
  String get sign_in_subtitle =>
      'Hi! Sign in with your mobile number to continue';

  @override
  String get sign_up => 'Sign Up';

  @override
  String get signatures => 'Signatures';

  @override
  String get skip => 'Skip';

  @override
  String get something_went_wrong => 'Something went wrong';

  @override
  String get special_offers => 'Special Offers';

  @override
  String get spin => 'Spin';

  @override
  String get spin_and_win => 'Spin & Win';

  @override
  String get spinner => 'Spinner';

  @override
  String get spinner_products => 'Spinner Products';

  @override
  String get spinners => 'Spinners';

  @override
  String get stop => 'Stop';

  @override
  String get subtotal => 'Subtotal';

  @override
  String successfully_added(Object item) {
    return '$item successfully added';
  }

  @override
  String get sunday => 'Sunday';

  @override
  String get taxes => 'Taxes';

  @override
  String get the_best_experience => 'The Best Experience';

  @override
  String get there_are_no_order_to_track => 'There are no orders to track';

  @override
  String get thursday => 'Thursday';

  @override
  String get today => 'Today';

  @override
  String get todays_offers => 'Today’s Offers';

  @override
  String get top_requested_products => 'Top Requested Products';

  @override
  String get total_coffees_point => 'Total Coffees Point';

  @override
  String get total_price => 'Total Price';

  @override
  String get transfer => 'Transfer';

  @override
  String get transfer_amount => 'Transfer Amount';

  @override
  String get transfer_to => 'Transfer To';

  @override
  String get try_spinner_again => 'Try Spinner Again';

  @override
  String get try_your_luck => 'Try Your Luck';

  @override
  String get tuesday => 'Tuesday';

  @override
  String unlock_h_m(num hours, num minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '${hours}h ',
      zero: '',
    );
    String _temp1 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '${minutes}m',
      zero: '',
    );
    return 'Unlock $_temp0$_temp1';
  }

  @override
  String get unlock_later => 'Unlock Later';

  @override
  String up_to_percent(Object percent) {
    return 'Up to $percent%';
  }

  @override
  String get use_points => 'You use Points';

  @override
  String get verify_code => 'Verify Code';

  @override
  String get view_cart => 'View cart';

  @override
  String get wallet => 'Wallet';

  @override
  String get weak_password => 'Weak Password';

  @override
  String get wednesday => 'Wednesday';

  @override
  String weeksAgo(Object weeks) {
    return '${weeks}w';
  }

  @override
  String yearsAgo(Object years) {
    return '${years}y';
  }

  @override
  String get yesterday => 'Yesterday';

  @override
  String get youHaveWon => '🎉 You have won 🥳';

  @override
  String get your_booking_is_confirmed => 'Your booking is confirmed';

  @override
  String get branch_proximity_detection => 'Branch proximity detection';

  @override
  String get proximity_tracking_enabled =>
      'Proximity tracking enabled successfully';

  @override
  String get enable_location_tracking_description =>
      'Would you like to enable location tracking to notify the branch when you\'re approaching?';

  @override
  String get setting_up_location_tracking => 'Setting up location tracking...';

  @override
  String get location_tracking_disabled => 'Location tracking disabled';

  @override
  String get pay_with_credit_card => 'Pay with Credit Card';

  @override
  String get payment => 'Payment';

  @override
  String get payment_successful => 'Payment successful';

  @override
  String get payment_failed => 'Payment failed';

  @override
  String get try_again => 'Try Again';

  @override
  String get reward_products => 'Reward Products';

  @override
  String get get_your_reward => 'Get your reward';

  @override
  String get choose_your_reward => 'Choose your reward';

  @override
  String get pay_one_and_get_one_free => 'Pay one and get one free';

  @override
  String get please_select_paid_drink => 'Please select paid drink';

  @override
  String get please_select_free_drink => 'Please select free drink';

  @override
  String get paid => 'Paid';

  @override
  String get choose_first_product => 'Choose first product';

  @override
  String get choose_second_product => 'Choose second product';

  @override
  String get first => 'First';

  @override
  String get second => 'Second';

  @override
  String get get_free_drink => 'Get free drink';

  @override
  String get update => 'Update';

  @override
  String get force_update => 'Force Update';

  @override
  String get invalid_points => 'Invalid Points';

  @override
  String get transfer_success => 'Transfer Success';

  @override
  String get field_required => 'Field required';

  @override
  String get enter_email => 'Enter email';

  @override
  String get enter_email_or_phone => 'Enter email or phone';

  @override
  String get sms_otp_uae_only => 'SMS OTP service is only available in UAE';

  @override
  String get manual_otp_entry_required => 'Please enter the OTP manually';

  @override
  String get code_sent_successfully => 'Code sent successfully';

  @override
  String get pleaseSelectUAECountry => 'Please select UAE Country (+971)';

  @override
  String get bestSellers => 'Best Sellers';

  @override
  String get dont_have_account_sign_up_now =>
      'Don\'t have an account? Sign up now';

  @override
  String get register_success => 'Registration successful';

  @override
  String get sign_up_description =>
      'Hello! Create an account using your phone number to continue';

  @override
  String order_number(Object number) {
    return 'Order Number #$number';
  }

  @override
  String get newlyReleased => 'Newly Released';

  @override
  String get date => 'Date';

  @override
  String get products_selected => 'Products Selected';

  @override
  String get are_you_sure_cancel_order =>
      'Are you sure you want to cancel the order';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String get yes_cancel => 'Yes, Cancel';

  @override
  String get edit_order => 'Edit Order';

  @override
  String get order_summary => 'Order Summary';

  @override
  String get original_subtotal => 'Original Subtotal';

  @override
  String get new_subtotal => 'New Subtotal';

  @override
  String get difference => 'Difference';

  @override
  String get update_order => 'Update Order';

  @override
  String get remove => 'Remove';

  @override
  String get remove_product => 'Remove Product';

  @override
  String get from_the_order => 'from the order';

  @override
  String get are_you_sure_remove_product =>
      'Are you sure you want to remove this product';

  @override
  String get nearest_branch_updated => 'Nearest branch updated';

  @override
  String get ok => 'OK';

  @override
  String get the_nearest_branch_is => 'The nearest branch is';

  @override
  String get auto_assigned_branch => 'Auto assigned branch';

  @override
  String get modify_feature => 'Modify feature';
}
