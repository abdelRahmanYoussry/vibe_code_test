
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';

import '../../cache/cache_helper.dart';
import '../../theme/constants/app_strings.dart';

class DeviceInfoClass {
  final deviceInfo = DeviceInfoPlugin();
  final CacheHelper cacheHelper;

  DeviceInfoClass({required this.cacheHelper});
  Future<int> getAndroidSdkVersion() async {
    final androidInfo = await deviceInfo.androidInfo;
    final androidSdkVersion = androidInfo.version.sdkInt;
    cacheHelper.put(kAndroidDeviceVersion, androidSdkVersion);
    final kAndroidDeviceVersion2 = await cacheHelper.get(kAndroidDeviceVersion);

    debugPrint(kAndroidDeviceVersion2.toString());
    return androidSdkVersion;
  }
}
