import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/app/local_provider.dart';
import 'package:flutter/widgets.dart';

import '../cache/cache_helper.dart';
import '../theme/constants/app_strings.dart';
import '../utils/remote/api_helper.dart';


class LangRepo {
  final ApiHelper apiHelper;
  final CacheHelper cacheHelper;
  final LocaleProvider localeProvider ;

  String? lang;

  LangRepo({
    required this.apiHelper,
    required this.cacheHelper,
    required this.localeProvider,
  });

  // Sets the language using Flutter's built-in localization system.
  // You need to rebuild the app with the new locale.
  Future<Either<String, Unit>> setLang(String lang, BuildContext context) async {
    try {
      this.lang = lang;
      await cacheHelper.put(kUserLangKey, lang);

      // To set the locale in Flutter (without easy_localization),
      // you typically use a state management solution to update the locale.
      // This is a placeholder for how you might do it:
      //
      // MyApp.setLocale(context, Locale(lang));
      //
      // You must implement `setLocale` in your app's root widget
      // which should call `setState` to rebuild the MaterialApp with the new locale.
      //
      // Example:
      // MyApp.of(context)?.setLocale(Locale(lang));

      // Remove the following comment and implement your own locale change logic.
      // MyApp.of(context)?.setLocale(Locale(lang));
      localeProvider.setLocale(lang);

      return const Right(unit);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }

  Future<Either<String, String>> getLang() async {
    try {
      final kLang = await cacheHelper.get(kUserLangKey);
      lang = kLang ?? 'en';
      return Right(lang!);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }
}
