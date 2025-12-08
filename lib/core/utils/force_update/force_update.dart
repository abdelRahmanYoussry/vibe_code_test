import 'dart:io';

import 'package:test_vibe/core/utils/safe_utils.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../data_utils.dart';
import '../functions.dart';


abstract class ForceUpdate {
  static Future init() async {
    try {
      await FirebaseRemoteConfig.instance.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(minutes: 1),
          minimumFetchInterval: const Duration(seconds: 30),
        ),

      );
      await FirebaseRemoteConfig.instance.fetchAndActivate();
    } catch (e) {
      debugPrint('Firebase Remote Config initialization failed: $e');
      // Continue without crashing the app
    }
  }

  static Future<bool> checkUpdate() async {
    try {
      final packageInfo = await PackageInfo.fromPlatform();
      final localVersion = packageInfo.version;

      if (Platform.isAndroid) {
        final remoteVersion = FirebaseRemoteConfig.instance.getString('claro_android_version_live');
        debugPrint('${remoteVersion}remoteVersion${localVersion}localVersion');
        return isVersionHigher(remoteVersion, localVersion);
      }
      if (Platform.isIOS) {
        final remoteVersion = FirebaseRemoteConfig.instance.getString('claro_ios_version_live');
        return isVersionHigher(remoteVersion, localVersion);
      }
    } catch (e) {
      debugPrint('Failed to check for updates: $e');
    }
    return false;
  }

  static bool isVersionHigher(String a, String b) {
    var aList = a.safeSplit('.');
    if (aList.isEmpty) {
      aList = [a];
    }
    var bList = b.safeSplit('.');
    if (bList.isEmpty) {
      bList = [b];
    }
    for (int i = 0; i < aList.length || i < bList.length; i++) {
      final aI = validateInt(aList.safeElementAt(i));
      final bI = validateInt(bList.safeElementAt(i));
      if (aI > bI) {
        return true;
      } else if (aI < bI) {
        return false;
      }
    }
    return false;
  }

  static Future<bool> openStore() async {
    final info = await PackageInfo.fromPlatform();
    final package = info.packageName;
    if (Platform.isAndroid) {
      await launchMyUrl('https://play.google.com/store/apps/details?id=$package');
      return true;
    }
    if (Platform.isIOS) {
      await launchMyUrl('https://apps.apple.com/app/id$package');
      return true;
    }
    return false;
  }
}
