import 'dart:io';

import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as tago;

import 'formats/short_fuzzy_time_format.dart';

abstract class FuzzyTime {
  static String formatShortMessages(BuildContext context, DateTime dateTime) {
    //todo get current locale
    final locale = Platform.localeName;
    //todo this should be when app starts or change language not here to save performance
    tago.setLocaleMessages('${locale}_short', ShortFuzzyTimeFormat(context: context));
    return tago.format(dateTime, locale: '${locale}_short');
  }
}
