part of '../size_config.dart';

class LateInitializationException implements Exception {
  @override
  String toString() {
    super.toString();
    return "SizeConfig().init() not called !";
  }
}
