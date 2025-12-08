import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

Color colorFromHex(String src, [Color? def]) {
  def ??= AppColors.black;
  String hex = src;

  if (hex.startsWith('#')) {
    hex = hex.replaceFirst('#', '');
  }

  switch (hex.length) {
    case 1:
      // input 'a'
      // output 'ffaaaaaa'
      final c = hex[0];
      hex = 'ff$c$c$c$c$c$c';
      break;
    case 2:
      // input 'e6'
      // output 'ffe6e6e6'
      final c1 = hex[0];
      final c2 = hex[1];
      hex = 'ff$c1$c2$c1$c2$c1$c2';
      break;
    case 3:
      // input 'e26'
      // output 'ffee2266'
      final r = hex[0];
      final g = hex[1];
      final b = hex[2];
      hex = 'ff$r$r$g$g$b$b';
      break;
    case 4:
      // input '9e26'
      // output '99ee2266'
      final a = hex[0];
      final r = hex[1];
      final g = hex[2];
      final b = hex[3];
      hex = '$a$a$r$r$g$g$b$b';
      break;
    case 5:
      // input 'abe26'
      // output 'abee2266'
      final a1 = hex[0];
      final a2 = hex[1];
      final r = hex[2];
      final g = hex[3];
      final b = hex[4];
      hex = '$a1$a2$r$r$g$g$b$b';
      break;
    case 6:
      // input 'e6e6e6'
      // output 'ffe6e6e6'
      final r1 = hex[0];
      final r2 = hex[1];
      final g1 = hex[2];
      final g2 = hex[3];
      final b1 = hex[4];
      final b2 = hex[5];
      hex = 'ff$r1$r2$g1$g2$b1$b2';
      break;
    case 7:
      // input 'be6e6e6'
      // output 'bbe6e6e6'
      final a = hex[0];
      final r1 = hex[1];
      final r2 = hex[2];
      final g1 = hex[3];
      final g2 = hex[4];
      final b1 = hex[5];
      final b2 = hex[6];
      hex = '$a$a$r1$r2$g1$g2$b1$b2';
      break;
    case 8:
      // input 'abe6e6e6'
      // output 'abe6e6e6'
      final a1 = hex[0];
      final a2 = hex[1];
      final r1 = hex[2];
      final r2 = hex[3];
      final g1 = hex[4];
      final g2 = hex[5];
      final b1 = hex[6];
      final b2 = hex[7];
      hex = '$a1$a2$r1$r2$g1$g2$b1$b2';
      break;
    default:
      return def;
  }

  final code = int.tryParse(hex, radix: 16);

  if (code == null) {
    return def;
  }

  try {
    return Color(code);
  } catch (e) {
    return def;
  }
}

Color mixColors(Color a, Color b, double t) => Color.lerp(a, b, t) ?? a;

extension ColorX on Color {
  Color withWhite(double opacity) => mixColors(this, AppColors.white, opacity);
}

enum Elevation {
  k0,
  k1,
  k2,
  k3,
  k4,
  k6,
  k8,
  k9,
  k12,
  k16,
  k24,
}

List<BoxShadow>? getElevation(BuildContext context, Elevation elevation, [Color? color, double offsetY = 0]) =>
    kElevationToShadow[int.tryParse(elevation.name.replaceFirst('k', '')) ?? 0]
        ?.map(
          (e) => BoxShadow(
            spreadRadius: e.spreadRadius,
            offset: e.offset.translate(0, offsetY),
            blurStyle: e.blurStyle,
            blurRadius: e.blurRadius,
            color: color ?? Theme.of(context).shadowColor,
          ),
        )
        .toList();

bool isApplicationDarkMode(BuildContext context) => isSystemDarkMode();

bool isSystemDarkMode() {
  var brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;
  return isDarkMode;
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
