// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'loc.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class LocAr extends Loc {
  LocAr([String locale = 'ar']) : super(locale);

  @override
  String get active => 'نشط';

  @override
  String get add => 'إضافة';

  @override
  String get addCard => 'إضافة بطاقة';

  @override
  String addNMins(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دقائق',
      one: 'دقيقة واحدة',
      zero: 'لا-دقائق',
    );
    return 'أضف $_temp0';
  }

  @override
  String get add_balance => 'إضافة رصيد';

  @override
  String get add_coupon => 'أضف قسيمة';

  @override
  String get add_item => 'أضف عنصر';

  @override
  String get add_to_cart => 'أضف إلى السلة';

  @override
  String get add_your_comment => 'هل لديك أي تعليق؟';

  @override
  String get add_your_comment_hint => 'أضف تعليقك';

  @override
  String get allowNotifications => 'السماح بالإشعارات';

  @override
  String get apply => 'تطبيق';

  @override
  String get are_you_sure => 'هل أنت متأكد؟';

  @override
  String get balance => 'الرصيد';

  @override
  String get better_luck_next_time => 'جرب حظك في وقت لاحق';

  @override
  String get buyFiveGetOne => 'اشترِ 5 واحصل على 1 مجانًا';

  @override
  String get cancel => 'إلغاء';

  @override
  String get cancel_order => 'إلغاء الطلب';

  @override
  String get cancel_reward_message =>
      'هل أنت متأكد أنك تريد إلغاء هذه المكافأة؟';

  @override
  String get cancel_reward_message_desc =>
      'عند الإلغاء ستفقد فرصة هذه المكافأة';

  @override
  String get canceled => 'ملغى';

  @override
  String get canceled_orders => 'الطلبات الملغاة';

  @override
  String get cardHolderName => 'اسم حامل البطاقة';

  @override
  String get cardNumber => 'رقم البطاقة';

  @override
  String get cart => 'السلة';

  @override
  String get cart_is_empty => 'السلة فارغة';

  @override
  String get cash => 'نقدًا';

  @override
  String get checkout => 'الدفع';

  @override
  String choose_n(Object count) {
    return 'اختر $count';
  }

  @override
  String get claim => 'استلم';

  @override
  String get claim_your_free_cup => 'استلم كوبك المجاني';

  @override
  String get claro_coffee_app => 'تطبيق كلارو كوفي';

  @override
  String get code_copied => 'تم نسخ الرمز';

  @override
  String get coffee_points => 'نقاط القهوة';

  @override
  String get completed => 'مكتمل';

  @override
  String get completed_orders => 'الطلبات المكتملة';

  @override
  String get confirm => 'تأكيد';

  @override
  String get confirm_password => 'تأكيد كلمة المرور';

  @override
  String get confirm_password_hint => '**** **** ****';

  @override
  String get confirm_profile_subtitle =>
      'يرجى تأكيد معلومات ملفك الشخصي قبل المتابعة';

  @override
  String get confirm_profile_title => 'تأكيد الملف الشخصي';

  @override
  String get congratulations => 'مبروك';

  @override
  String get copy_code => 'نسخ الرمز';

  @override
  String get country => 'الدولة';

  @override
  String get coupon => 'قسيمة';

  @override
  String get coupon_applied => 'تم تطبيق القسيمة بنجاح';

  @override
  String get coupons => 'قسائم';

  @override
  String get coupons_for_you => 'قسائم لك';

  @override
  String get create_new_password => 'إنشاء كلمة مرور جديدة';

  @override
  String get create_order => 'إنشاء طلب';

  @override
  String get creditAndDebitCard => 'بطاقة ائتمان وخصم';

  @override
  String cup_n(Object count) {
    return 'كوب $count';
  }

  @override
  String get cvv => 'CVV';

  @override
  String daysAgo(Object days) {
    return '$daysي';
  }

  @override
  String get delay_option_hint => 'يمكنك تأخير الاستلام';

  @override
  String get delete => 'حذف';

  @override
  String get delete_account => 'حذف الحساب';

  @override
  String get delete_account_message => 'هل أنت متأكد أنك تريد حذف حسابك؟';

  @override
  String get delete_account_message_desc =>
      'لا يمكن التراجع عن هذا الإجراء. سيتم حذف جميع بياناتك نهائيًا';

  @override
  String get didnt_receive_otp => 'لم يصلك الرمز؟';

  @override
  String get discount => 'خصم';

  @override
  String get discount_reward => 'مكافأة الخصم';

  @override
  String get done => 'تم';

  @override
  String get dont_have_account => 'ليس لديك حساب؟';

  @override
  String get earn_points => 'اكسب النقاط';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get email_hint => 'example@gmail.com';

  @override
  String empty_field(Object field) {
    return 'يجب ألا يكون $field فارغًا';
  }

  @override
  String get enableNotificationAccess => 'تمكين الوصول للإشعارات';

  @override
  String get enableNotificationsToStayUpToDate =>
      'فعّل الإشعارات للبقاء على اطلاع';

  @override
  String get enjoy_benefits_through_the => 'استمتع بالمزايا من خلال';

  @override
  String get enjoying_coffee => 'استمتع بالقهوة';

  @override
  String get enter_coupon_code => 'أدخل رمز القسيمة';

  @override
  String get error_While_getting_data => 'خطأ أثناء جلب البيانات';

  @override
  String get error_while_getting_spin_wheel_data =>
      'خطأ أثناء جلب بيانات عجلة الحظ';

  @override
  String get expiryDate => 'تاريخ الانتهاء';

  @override
  String get fREE => 'مجاني';

  @override
  String get forgot_password => 'نسيت كلمة المرور';

  @override
  String get free => 'مجاني';

  @override
  String get friday => 'الجمعة';

  @override
  String get get_special_offer => 'احصل على عرض خاص';

  @override
  String get home => 'الرئيسية';

  @override
  String hoursAgo(Object hours) {
    return '$hoursس';
  }

  @override
  String get invalid_card_holder_name => 'اسم حامل البطاقة غير صحيح';

  @override
  String get invalid_card_number => 'رقم البطاقة غير صحيح';

  @override
  String get invalid_cvv => 'CVV غير صحيح';

  @override
  String get invalid_email => 'البريد الإلكتروني غير صحيح';

  @override
  String get invalid_expiry_date => 'تاريخ الانتهاء غير صحيح';

  @override
  String get invalid_name => 'الاسم غير صحيح';

  @override
  String get invalid_phone => 'رقم الهاتف غير صحيح';

  @override
  String get items_count => 'عدد القطع';

  @override
  String get justNow => 'الآن';

  @override
  String get language => 'اللغة';

  @override
  String get lastWeek => 'الأسبوع الماضي';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get loading_more => 'جاري تحميل المزيد...';

  @override
  String get location => 'الموقع';

  @override
  String get maybeLater => 'ربما لاحقًا';

  @override
  String get menu => 'القائمة';

  @override
  String minsAgo(Object minutes) {
    return '$minutesد';
  }

  @override
  String get monday => 'الاثنين';

  @override
  String monthsAgo(Object months) {
    return '$monthsش';
  }

  @override
  String get morePaymentOptions => 'المزيد من خيارات الدفع';

  @override
  String get more_suggestions => 'المزيد من الاقتراحات';

  @override
  String get my_orders => 'طلباتي';

  @override
  String my_reward_p_m(Object max, Object progress) {
    return 'مكافأتي ($progress / $max)';
  }

  @override
  String nItems(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count عناصر',
      one: 'عنصر واحد',
      zero: 'لا عناصر',
    );
    return '$_temp0';
  }

  @override
  String get name => 'الاسم';

  @override
  String get name_hint => 'أدخل اسمك';

  @override
  String get new_password => 'كلمة مرور جديدة';

  @override
  String get new_password_description =>
      'يجب أن تكون كلمة المرور الجديدة مختلفة عن كلمات المرور السابقة';

  @override
  String get no_Branch_selected => 'لم يتم اختيار فرع';

  @override
  String get no_description => 'لا يوجد وصف';

  @override
  String get no_recorded_data_found => 'لا توجد بيانات مسجلة';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get offer_products => 'منتجات العروض';

  @override
  String get on_boarding_subtitle1 =>
      'استمتع بكوب قهوة غني بالنكهة من كلارو كوفي في تطبيق واحد فقط';

  @override
  String get on_boarding_subtitle2 =>
      'تجاوز الانتظار، واستمتع بالعروض اليومية، واحصل على نقاط كلارو، والمزيد من العروض الحصرية المثيرة!';

  @override
  String get on_boarding_subtitle3 =>
      'قهوة يومك أصبحت أفضل. استمتع بمكافآت حصرية مع تطبيقنا';

  @override
  String get option => 'الخيار';

  @override
  String get or_sign_in_with => 'أو سجل الدخول باستخدام';

  @override
  String get order_now => 'اطلب الآن';

  @override
  String get order_ready_message => 'طلبك جاهز في الوقت المحدد';

  @override
  String get orders => 'الطلبات';

  @override
  String get otp_subtitle => 'أدخل رمز التحقق المرسل إلى هاتفك';

  @override
  String get our_branches => 'فروعنا';

  @override
  String get password => 'كلمة المرور';

  @override
  String get password_hint => '**** **** ****';

  @override
  String get password_mismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get payment_methods => 'طرق الدفع';

  @override
  String get payment_transfer => 'تحويل الدفع';

  @override
  String get phone => 'الهاتف المحمول';

  @override
  String get phone_hint => '55 701 5031';

  @override
  String get please_add_new_order_or_wait_for_order_to_appear_here =>
      'يرجى إضافة طلب جديد أو الانتظار حتى يظهر الطلب هنا';

  @override
  String get please_select_product_options => 'يرجى اختيار خيارات المنتج';

  @override
  String get point => 'نقطة';

  @override
  String get points => 'النقاط';

  @override
  String points_equality_desc_prefix(Object points) {
    return '$points نقطة تساوي';
  }

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get pull_to_refresh => 'اسحب للتحديث';

  @override
  String get qr => 'QR';

  @override
  String get qrCode => 'رمز QR';

  @override
  String get quantity => 'الكمية';

  @override
  String get ready => 'جاهز';

  @override
  String get recent_search => 'بحث حديث';

  @override
  String get recent_view => 'عرض حديث';

  @override
  String get recently_transactions => 'المعاملات الحديثة';

  @override
  String get resend_code => 'إعادة إرسال الرمز';

  @override
  String get saturday => 'السبت';

  @override
  String get scanToPay => 'امسح للدفع';

  @override
  String get search => 'بحث';

  @override
  String secsAgo(Object seconds) {
    return '$secondsث';
  }

  @override
  String get see_all => 'عرض الكل';

  @override
  String get select_branch => 'اختر فرع';

  @override
  String get select_options => 'اختر الخيارات';

  @override
  String get select_time => 'اختر الوقت';

  @override
  String get select_your_branch => 'اختر فرعك';

  @override
  String get server_error => 'خطأ في الخادم';

  @override
  String get settings => 'الإعدادات';

  @override
  String get share_the_Perks_with_the => 'شارك الامتيازات مع';

  @override
  String get short_password => 'كلمة المرور قصيرة';

  @override
  String get sign_in => 'تسجيل الدخول';

  @override
  String get sign_in_subtitle =>
      'مرحباً! سجّل الدخول باستخدام رقم هاتفك للمتابعة';

  @override
  String get sign_up => 'إنشاء حساب';

  @override
  String get signatures => 'التواقيع';

  @override
  String get skip => 'تخطي';

  @override
  String get something_went_wrong => 'حدث خطأ ما';

  @override
  String get special_offers => 'عروض خاصة';

  @override
  String get spin => 'دور';

  @override
  String get spin_and_win => 'دور & اربح';

  @override
  String get spinner => 'الدوار';

  @override
  String get spinner_products => 'منتجات العجلة';

  @override
  String get spinners => 'الدوارات';

  @override
  String get stop => 'توقف';

  @override
  String get subtotal => 'المجموع الفرعي';

  @override
  String successfully_added(Object item) {
    return 'تمت إضافة $item بنجاح';
  }

  @override
  String get sunday => 'الأحد';

  @override
  String get taxes => 'الضرايب';

  @override
  String get the_best_experience => 'أفضل تجربة';

  @override
  String get there_are_no_order_to_track => 'لا توجد طلبات للتتبع';

  @override
  String get thursday => 'الخميس';

  @override
  String get today => 'اليوم';

  @override
  String get todays_offers => 'عروض اليوم';

  @override
  String get top_requested_products => 'المنتجات الأكثر طلبًا';

  @override
  String get total_coffees_point => 'إجمالي نقاط القهوة';

  @override
  String get total_price => 'السعر الكلي';

  @override
  String get transfer => 'تحويل';

  @override
  String get transfer_amount => 'قيمة التحويل';

  @override
  String get transfer_to => 'تحويل ل';

  @override
  String get try_spinner_again => 'جرب عجلة الحظ مرة اخرى';

  @override
  String get try_your_luck => 'جرب حظك';

  @override
  String get tuesday => 'الثلاثاء';

  @override
  String unlock_h_m(num hours, num minutes) {
    String _temp0 = intl.Intl.pluralLogic(
      hours,
      locale: localeName,
      other: '$hoursس ',
      zero: '',
    );
    String _temp1 = intl.Intl.pluralLogic(
      minutes,
      locale: localeName,
      other: '$minutesد',
      zero: '',
    );
    return 'يفتح بعد $_temp0$_temp1';
  }

  @override
  String get unlock_later => 'افتح لاحقًا';

  @override
  String up_to_percent(Object percent) {
    return 'حتى $percent%';
  }

  @override
  String get use_points => 'استخدم النقاط';

  @override
  String get verify_code => 'تأكيد الرمز';

  @override
  String get view_cart => 'عرض السلة';

  @override
  String get wallet => 'محفظة';

  @override
  String get weak_password => 'كلمة المرور ضعيفة';

  @override
  String get wednesday => 'الأربعاء';

  @override
  String weeksAgo(Object weeks) {
    return '$weeksأ';
  }

  @override
  String yearsAgo(Object years) {
    return '$yearsس';
  }

  @override
  String get yesterday => 'أمس';

  @override
  String get youHaveWon => '🎉 لقد ربحت 🥳';

  @override
  String get your_booking_is_confirmed => 'تم تأكيد الحجز الخاص بك';

  @override
  String get branch_proximity_detection => 'اكتشاف قرب الفرع';

  @override
  String get proximity_tracking_enabled => 'تم تفعيل تتبع الموقع';

  @override
  String get enable_location_tracking_description =>
      'هل ترغب في تفعيل تتبع الموقع لتنبيه الفرع عند اقترابك؟';

  @override
  String get setting_up_location_tracking => 'جارٍ إعداد تتبع الموقع...';

  @override
  String get location_tracking_disabled => 'تم تعطيل تتبع الموقع';

  @override
  String get pay_with_credit_card => 'الدفع ببطاقة الائتمان';

  @override
  String get payment => 'الدفع';

  @override
  String get payment_successful => 'تم الدفع بنجاح';

  @override
  String get payment_failed => 'فشل الدفع';

  @override
  String get try_again => 'حاول مرة أخرى';

  @override
  String get reward_products => 'منتجات المكافآت';

  @override
  String get get_your_reward => 'احصل على مكافأتك';

  @override
  String get choose_your_reward => 'اختر مكافأتك';

  @override
  String get pay_one_and_get_one_free => 'ادفع واحد واحصل على واحد مجانًا';

  @override
  String get please_select_paid_drink => 'من فضلك اختار المشروب مدفوع الثمن';

  @override
  String get please_select_free_drink => 'من فضلك اختار المشروب المجاني';

  @override
  String get paid => 'مدفوع';

  @override
  String get choose_first_product => ' اختر المنتج الاول';

  @override
  String get choose_second_product => ' اختر المنتج الثاني';

  @override
  String get first => 'الأول';

  @override
  String get second => 'الثاني';

  @override
  String get get_free_drink => 'احصل على مشروب مجاني';

  @override
  String get update => 'تحديث';

  @override
  String get force_update => 'تحديث إجباري';

  @override
  String get invalid_points => 'نقاط غير صالحة';

  @override
  String get transfer_success => 'تم التحويل بنجاح';

  @override
  String get field_required => 'الحقل مطلوب';

  @override
  String get enter_email => 'أدخل البريد الإلكتروني';

  @override
  String get enter_email_or_phone => 'أدخل البريد الإلكتروني أو رقم الهاتف';

  @override
  String get sms_otp_uae_only =>
      'خدمة رمز التحقق عبر الرسائل متاحة فقط في دولة الإمارات';

  @override
  String get manual_otp_entry_required => 'يرجى إدخال رمز التحقق يدوياً';

  @override
  String get code_sent_successfully => 'تم إرسال الرمز بنجاح';

  @override
  String get pleaseSelectUAECountry => 'يرجى اختيار دولة الإمارات (+971)';

  @override
  String get bestSellers => 'الأكثر مبيعًا';

  @override
  String get dont_have_account_sign_up_now => 'لا يوجد حساب؟ سجّل الدخول الان';

  @override
  String get register_success => 'تم التسجيل بنجاح';

  @override
  String get sign_up_description =>
      'مرحباً! أنشئ حسابًا باستخدام رقم هاتفك للمتابعة';

  @override
  String order_number(Object number) {
    return 'رقم الطلب #$number';
  }

  @override
  String get newlyReleased => 'المنتجات الجديدة';

  @override
  String get date => 'التاريخ';

  @override
  String get products_selected => 'منتجات مختارة';

  @override
  String get are_you_sure_cancel_order => 'هل تريد الغاء الطلب';

  @override
  String get no => 'لا';

  @override
  String get yes => 'نعم';

  @override
  String get yes_cancel => 'نعم، إلغاء';

  @override
  String get edit_order => 'تعديل الطلب';

  @override
  String get order_summary => 'ملخص الطلب';

  @override
  String get original_subtotal => 'المجموع الاصلي';

  @override
  String get new_subtotal => 'المجموع الجديد';

  @override
  String get difference => 'الفرق';

  @override
  String get update_order => 'تحديث الطلب';

  @override
  String get remove => 'حذف';

  @override
  String get remove_product => 'حذف المنتج';

  @override
  String get from_the_order => 'من الطلب';

  @override
  String get are_you_sure_remove_product =>
      'هل أنت متأكد أنك تريد حذف هذا المنتج من';

  @override
  String get nearest_branch_updated => 'تم تحديث أقرب فرع بنجاح';

  @override
  String get ok => 'حسنًا';

  @override
  String get the_nearest_branch_is => 'أقرب فرع هو';

  @override
  String get auto_assigned_branch => 'تعيين فرع تلقائى';

  @override
  String get modify_feature => 'تبديل الميزة';
}
