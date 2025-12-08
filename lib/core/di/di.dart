import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:test_vibe/core/repos/lang_repo.dart';
// import 'package:test_vibe/core/network/api_helper.dart';

final di = GetIt.instance;

Future initDI() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  di.registerSingleton(sharedPreferences);
  di.registerSingleton(Dio());

  // TODO: Register Repositories

  // TODO: Register Blocs
}
