part of '../size_config.dart';

extension SizeExtention on num {
  // get width based on ratio of mobile screen and reference screen
  double get w {
    try {
      return _SizeConfigValue.relativeWidth(width: this);
    } catch (err) {
      throw LateInitializationException();
    }
  }

// get height based on ratio of mobile screen and reference screen
  double get h {
    try {
      return _SizeConfigValue.relativeHeight(height: this);
    } catch (err) {
      throw LateInitializationException();
    }
  }

  // get value based on minimum height or width
  double get s {
    try {
      return min(_SizeConfigValue.relativeHeight(height: this), _SizeConfigValue.relativeWidth(width: this));
    } catch (err) {
      throw LateInitializationException();
    }
  }

  double get sp {
    try {
      return _SizeConfigValue.relativeFontSize(fontSize: this);
    } catch (err) {
      throw LateInitializationException();
    }
  }

  double get wp {
    try {
      return _SizeConfigPercentage.relativeWidth(widthPercentage: this);
    } catch (err) {
      throw LateInitializationException();
    }
  }

  double get hp {
    try {
      return _SizeConfigPercentage.relativeHeight(heightPercentage: this);
    } catch (err) {
      throw LateInitializationException();
    }
  }

  /// creates vertical space between two widgets which changes according to size of screen.
  Widget get verticalSpacer {
    try {
      return SizedBox(
        height: h,
      );
    } catch (err) {
      throw LateInitializationException();
    }
  }

  /// creates horizontal space between two widgets which changes according to size of screen.
  Widget get horizontalSpacer {
    try {
      return SizedBox(
        width: w,
      );
    } catch (err) {
      throw LateInitializationException();
    }
  }

  /// creates vertical space between two widgets which changes according to size of screen percent.
  Widget get verticalSpacerPercent {
    try {
      return SizedBox(
        height: hp,
      );
    } catch (err) {
      throw LateInitializationException();
    }
  }

  /// creates horizontal space between two widgets which changes according to size of screen percent.
  Widget get horizontalSpacerPercent {
    try {
      return SizedBox(
        width: wp,
      );
    } catch (err) {
      throw LateInitializationException();
    }
  }
}
