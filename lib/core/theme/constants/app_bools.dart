import 'package:test_vibe/core/theme/constants/app_strings.dart';

import '../../cache/cache_helper.dart';
import '../../di/di.dart';

final cashHeader = di<CacheHelper>();

abstract class AppBools {

  static  bool showSpinners = true;

} Future<bool> isLogin () async =>  await cashHeader.get(kUserKey) != null ;
