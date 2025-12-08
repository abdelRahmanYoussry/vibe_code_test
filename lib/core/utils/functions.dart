import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../modules/app/spinner/widgets/spinner_reward/spinner_buy_one_get_one_page_params.dart';
import '../../modules/app/spinner/widgets/spinner_reward/spinner_products_page_params.dart';
import '../../modules/app/spinner/widgets/spinner_reward/spinner_reward_sheet_params.dart';
import '../localization/gen/loc.dart';
import '../navigation/nav.dart';
import '../widgets/dialogs/try_again_dialog/try_again_dialog.dart';
import 'data_utils.dart';

String mapToQueryParams(Map<String, String> params, [bool encode = true]) {
  List<String> queryParams = [];

  params.forEach((key, value) {
    late String encodedKey;
    late String encodedValue;
    if (encode) {
      encodedKey = Uri.encodeQueryComponent(key);
      encodedValue = Uri.encodeQueryComponent(value);
    } else {
      encodedKey = key;
      encodedValue = value;
    }
    queryParams.add('$encodedKey=$encodedValue');
  });

  return queryParams.join('&');
}

share(String title, String body) {
  final share = [
    '  Claroتطبيق',
    title,
    body,
  ].join('\n');

  SharePlus.instance.share(
    ShareParams(
      text: share,
      title: title,
    ),
  );
}

String parseHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = validateString(parse(document.body?.text).documentElement?.text);

  return parsedString;
}

bool containsHtml(String text) {
  final htmlPattern = RegExp(r"<\/?[a-zA-Z][^>]*>");
  return htmlPattern.hasMatch(text);
}

bool isMobileDevice(BuildContext context) {
  return MediaQuery.of(context).size.shortestSide < 600;
}

void handleSpinnerResult(BuildContext context, SpinnerRewardSheetParams params) {
  final resultType = params.result.type?.toLowerCase();

  switch (resultType) {
    case 'free_product':
      SpinnerProductsPageParams args = SpinnerProductsPageParams(
        title: Loc.of(context).get_free_drink,
      );
      Nav.spinnerProductPage.replace(context, args: args);
      break;
    case 'buy_drink_get_one_free':
      SpinnerBuyOneGetOnePageParams args = SpinnerBuyOneGetOnePageParams(
        title: Loc.of(context).pay_one_and_get_one_free,
        type: '43',
        rewardId: params.result.rewardId.toString(),
      );
      Nav.chooseTwoProductsPage.replace(context, args: args);
      break;
      case 'buy_sweet_get_one_free':
      SpinnerBuyOneGetOnePageParams args = SpinnerBuyOneGetOnePageParams(
        title: Loc.of(context).pay_one_and_get_one_free,
        type: '45',
        rewardId: params.result.rewardId.toString(),
      );
      Nav.chooseTwoProductsPage.replace(context, args: args);
      break;
    case 'discount':
      // First pop until root to clear the navigation stack
      Nav.root.popUntil(context);
      // Then push the coupons page
      Nav.coupons.push(context);
      break;

    case 'try_again':
      showDialog(
        context: context,
        builder: (context) => SingleButtonAlertDialog(
          title: Loc.of(context).better_luck_next_time,
          subtitle: Loc.of(context).try_spinner_again,
          buttonText: Loc.of(context).confirm,
          icon: Icon(Icons.refresh_rounded),
        ),
      ).then((_) {
        if (context.mounted) {
          Nav.root.popUntil(context);
        }
      });
      break;

    case 'stanb':
      Nav.root.replaceAll(context);
      break;

    default:
      Nav.root.popUntil(context);
      break;
  }
}

String convertUtcToLocalTime(String utcTimeString, String format) {
  try {
    // Parse UTC
    final DateTime utcTime = DateTime.parse(utcTimeString).toUtc();

    // Convert to local (device’s time zone)
    final DateTime localTime = utcTime.toLocal();

    // Format
    final DateFormat formatter = DateFormat(format);
    return formatter.format(localTime);
  } catch (e) {
    return utcTimeString;
  }
}
Future<void> launchMyUrl(String url) async {
  final Uri url0 = Uri.parse(url);

  try {
    !await launchUrl(url0);
  } on Exception {
    debugPrint('launchMyUrl error ${url0.toString()}');
  }
}

String? formatPhoneNumber(String? phone) {
  if (!validString(phone)) return null;

  // Remove any non-digit characters
  final digits = phone!.replaceAll(RegExp(r'\D'), '');

  // Check if it starts with common country codes
  if (digits.startsWith('971') && digits.length >= 10) {
    // UAE country code
    final countryCode = '+971';
    final phoneNumber = digits.substring(3);
    return '$countryCode $phoneNumber';
  } else if (digits.startsWith('1') && digits.length == 11) {
    // US/Canada country code
    final countryCode = '+1';
    final phoneNumber = digits.substring(1);
    return '$countryCode $phoneNumber';
  } else if (digits.startsWith('20') && digits.length >= 10) {
    // Egypt country code
    final countryCode = '+20';
    final phoneNumber = digits.substring(2);
    return '$countryCode $phoneNumber';
  }

  // Default: assume first 2-3 digits are country code
  if (digits.length > 7) {
    final countryCode = '+${digits.substring(0, 3)}';
    final phoneNumber = digits.substring(3);
    return '$countryCode $phoneNumber';
  }

  return phone; // Return original if can't format
}
