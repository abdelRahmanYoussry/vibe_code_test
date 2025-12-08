import 'dart:ui';

import 'package:test_vibe/core/utils/color_utils.dart';

abstract class AppColors {
  static Color get white => Color(0xffFFFFFF);

  static Color get whiteWithOpacity => Color(0xfffffefa);

  static Color get black => Color(0xff000000);

  static Color get black_20p => mixColors(white, black, .2);

  static Color get redD1 => Color(0xffD15252);

  static Color get red6E => Color(0xff6E3D2C);

  static Color get redEB => Color(0xffEB4335);

  static Color get green34 => Color(0xff34C759);

  static Color get green37 => Color(0xff37AE77);

  static Color get brown31f => Color(0xff33231F);

  static Color get brown33 => Color(0xff32231e);

  static Color get yellowFFCC => Color(0xffFFCC01);

  static Color get olive53 => Color(0xff536F7A);

  static Color get redF7 => Color(0xffF7500A);

  static Color get blue3A => Color(0xff3AA4F8);

  static Color get redD8 => Color(0xffD82F2A);

  static Color get red98 => Color(0xff980000);

  static Color get green67 => Color(0xff679F32);

  static Color get yellowF5 => Color(0xffF5D680);

  static Color get yellowF5_50p => mixColors(white, yellowF5, .5);

  static Color get yellowFC => Color(0xffFCF9F0);

  static Color get yellowSocColor => Color(0xffFFF7E1);

  static Color get yellowFF => Color(0xffFFF5D6);

  static Color get yellowFF_20p => mixColors(white, yellowFF, .2);

  static Color get yellowFF_50p => mixColors(white, yellowFF, .5);

  static Color get greyD9 => Color(0xffD9D9D9);

  static Color get greyD9_59p => mixColors(white, greyD9, .59);

  static Color get greyE1 => Color(0xffE1E1E1);

  static Color get greyE2 => Color(0xffE2E3E2);

  static Color get greyE6 => Color(0xffE6E6E6);

  static Color get greyE6_26p => mixColors(white, greyE6, .26);

  static Color get grey9E => Color(0xff9EA5A6);

  static Color get grey9A => Color(0xff9A9A9A);

  static Color get grey60 => Color(0xff606060);

  static Color get greyF5 => Color(0xfffffcf5);

  static Color get grey79 => Color(0xff79747E);

  static Color get greyF0 => Color(0xfffffbf0);

  static Color get greyE8 => Color(0xffecebe8);

  static Color get grey79_40p => mixColors(white, grey79, .26);

  static Color get black09 => Color(0xff090909);

  static Color get black29 => Color(0xff292D32);

  static Color get successColor => Color(0xFF4CD080);
}
