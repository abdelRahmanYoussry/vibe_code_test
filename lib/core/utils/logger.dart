import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'data_utils.dart';

void logger(String title, Object? val) {
  if (kDebugMode) {
    String? message;
    try {
      message = prettify(val);
    } catch (e) {
      message = val?.toString();
    }
    log('$message', name: title);
  }
}
