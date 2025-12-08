import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/utils/color_utils.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({
    super.key,
    this.brightness,
    this.width,
    this.height,
  });

  final Brightness? brightness;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final brightness = this.brightness ?? (isApplicationDarkMode(context) ? Brightness.dark : Brightness.light);
    return Pic(
      brightness == Brightness.dark ? Assets.icons.logoLight.path : Assets.icons.logoDark.path,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
