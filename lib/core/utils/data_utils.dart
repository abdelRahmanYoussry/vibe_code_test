import 'dart:convert';
import 'dart:ui';

import 'package:test_vibe/core/utils/safe_utils.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:mime/mime.dart';

bool validString(dynamic src) => src?.toString().trim().isNotEmpty == true && src?.toString().trim() != 'false' && src?.toString().trim() != 'null';

String validateString(dynamic src, [String def = '']) => validString(src) ? src.toString() : def;

List<int> validateIntList(dynamic src, [List<int> def = const []]) {
  if (src != null && src is List && src.isNotEmpty) {
    return src.whereType<int>().toList();
  }
  return def;
}

bool validList<E>(dynamic src) => src != null && src is List<E> && src.isNotEmpty;

bool validateBool(dynamic o, [bool def = false, bool Function(dynamic o)? validator]) => (validator?.call(o) ?? validBool(o) ? o : def);

bool validBool(dynamic o) => o != null && o is bool;

bool isSuccess(dynamic o) => o?.toString() == 'true' || o?.toString() == '1';

bool isHttpLink(String link) {
  return link.contains("http");
}

bool isArabic(String text) {
  // final englishPattern = RegExp(r'^[a-zA-Z0-9!@#\$&*~]+$');
  // final arabicPattern = RegExp(r'^[\u0600-\u06FF\u0750-\u077F\u08A0-\u08FF\uFB50-\uFDFF\uFE70-\uFEFF]+$');
  // printLog('isArabic: ${arabicPattern.hasMatch(text)}');
  // var locale = const Locale('ar'); // Set the locale to Arabic
  Bidi.hasAnyRtl(
    text,
  );
  return Bidi.hasAnyRtl(
    text,
  );
}

TextAlign getTextAlign(String src) {
  if (isArabic(src)) {
    return TextAlign.right;
  }
  return TextAlign.left;
}

List<E> validateList<E>(dynamic src, [List<E> def = const []]) => validList(src) ? src : def;

bool validMap<K, V>(dynamic src) => src != null && src is Map<K, V> && src.isNotEmpty;

Map<K, V> validateMap<K, V>(dynamic src, [Map<K, V> def = const {}]) => validMap(src) ? src : def;

bool validInt(dynamic src) => int.tryParse(src.toString()) != null;

int validateInt(dynamic src, [int def = 0]) => int.tryParse(validateString(src?.toString())) ?? def;

bool stringNotNullOrEmpty(String? s) => s != null && s.isNotEmpty;

bool validDouble(dynamic src) => double.tryParse(validateString(src)) != null;

double validateDouble(dynamic src, [double def = 0]) => double.tryParse(validateString(src)) ?? def;

E validateEnum<E extends Enum>(List<E> enums, dynamic src, [E? def]) => enums.safeFirstWhere((e) => e.name == src.toString()) ?? (def ?? enums.first);

E? validateEnumNullable<E extends Enum>(List<E> enums, dynamic src) => enums.safeFirstWhere((e) => e.name == src.toString());

bool isTrue(dynamic src) => src?.toString() == 'true' || src?.toString() == '1';

T? validateJson<T>(dynamic src, T Function(Map<String, dynamic> json) fromJson) => validMap<String, dynamic>(src) ? fromJson(src) : null;

List<T> validateJsonList<T>(dynamic src, T Function(Map<String, dynamic> e) fromJson) {
  if (src != null && src is List && src.isNotEmpty) {
    return src.whereType<Map<String, dynamic>>().map((e) => fromJson(e)).toList();
  }
  return <T>[];
}

List<T> validateJsonListWithOption<T, F>(dynamic src, dynamic option, T Function(Map<String, dynamic> e, F option) fromJson) {
  if (src != null && src is List && src.isNotEmpty) {
    return src.whereType<Map<String, dynamic>>().map((e) => fromJson(e, option)).toList();
  }
  return <T>[];
}

bool validEmail(String? src) => src == null ? false : RegExp(r"""^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""").hasMatch(src);

bool validName(String? src) => src != null && src.isNotEmpty == true && src.length >= 3;

bool validCardNameHolder(String? src) => src != null && src.isNotEmpty == true && src.length >= 3;

bool validCardNumber(String? src) => src != null && src.isNotEmpty == true && src.length >= 16;

bool validTransferPoints(int? points, {int min = 1, int max = 6000}) =>
    points != null && points >= min && points <= max;

bool validCardExpiry(String? src) {
  if (src == null || src.isEmpty) {
    return false;
  }
  final parts = src.split('/');
  if (parts.length != 2) {
    return false;
  }
  final month = int.tryParse(parts[0]);
  final year = int.tryParse(parts[1]);
  if (month == null || year == null || month < 1 || month > 12) {
    return false;
  }
  final now = DateTime.now();
  final expiryDate = DateTime(year + (year < now.year ? 100 : 0), month);
  return expiryDate.isAfter(now);
}

bool validCardCVV(String? src) => src != null && src.isNotEmpty == true && src.length >= 3;

bool validPasswordLength(String? src) => src != null && src.isNotEmpty == true && src.length >= 6;

bool validPasswordContent(String? value) {
  return true;
  // String pattern = r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{6,}$";
  // RegExp regExp = RegExp(pattern);
  // return regExp.hasMatch(convertSpace(value));
}

String convertSpace(String value) => value.replaceAll(String.fromCharCode(8206), ' ').replaceAll(String.fromCharCode(8207), ' ').replaceAll(String.fromCharCode(32), ' ');

bool isImage(String path, [List<int>? bytes]) {
  List<int>? _bytes = bytes;
  if (_bytes != null) {
    try {
      _bytes = base64Decode(path);
    } catch (_) {}
  }
  final mimeStr = lookupMimeType(path, headerBytes: _bytes);
  if (mimeStr == null) {
    return false;
  }
  final fileTypes = mimeStr.safeSplit('/');
  return fileTypes.contains('image');
}

bool isVideo(String path, [List<int>? bytes]) {
  List<int>? _bytes = bytes;
  if (_bytes != null) {
    try {
      _bytes = base64Decode(path);
    } catch (_) {}
  }
  final mimeStr = lookupMimeType(path, headerBytes: _bytes);
  if (mimeStr == null) {
    return false;
  }
  final fileTypes = mimeStr.safeSplit('/');
  return fileTypes.contains('video');
}

bool isAudio(String path, [List<int>? bytes]) {
  List<int>? _bytes = bytes;
  if (_bytes != null) {
    try {
      _bytes = base64Decode(path);
    } catch (_) {}
  }
  final mimeStr = lookupMimeType(path, headerBytes: _bytes);
  if (mimeStr == null) {
    return false;
  }
  final fileTypes = mimeStr.safeSplit('/');
  return fileTypes.contains('audio');
}

String removeHtml(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body?.text).documentElement?.text ?? '';
  return parsedString;
}

prettify(Object? val) => val == null ? '' : JsonEncoder.withIndent('\t', (object) => '$object').convert(val);
