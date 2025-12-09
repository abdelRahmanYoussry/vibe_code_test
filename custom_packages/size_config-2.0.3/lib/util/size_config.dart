part of '../size_config.dart';

typedef ResponsiveBuild = Widget Function(
  BuildContext context,
  Orientation orientation,
);

class SizeConfigInit extends StatelessWidget {
  const SizeConfigInit({
    super.key,
    required this.builder,
    required this.referenceHeight,
    required this.referenceWidth,
    this.minFontSize,
    this.maxFontSize,
    this.minFontSizeScale,
    this.maxFontSizeScale,
  });

  final ResponsiveBuild builder;
  final double referenceHeight;
  final double referenceWidth;
  final double? minFontSize;
  final double? maxFontSize;
  final double? minFontSizeScale;
  final double? maxFontSizeScale;

  @override
  Widget build(BuildContext context) {
    /**
     * {SizeConfigInit} widget initialized the size_config package by takign reference height and width from user.
     * You can use this widget above MAterial app so that it is accecible all over the application.
     */

    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        _SizeConfig.init(
          orientation: orientation,
          constraints: constraints,
          referenceHeight: referenceHeight,
          referenceWidth: referenceWidth,
          minFontSize: minFontSize,
          maxFontSize: maxFontSize,
          minFontSizeScale: minFontSizeScale,
          maxFontSizeScale: maxFontSizeScale,
        );
        return builder(
          context,
          orientation,
        );
      });
    });
  }
}

class _SizeConfig {
  static late double _screenWidth; // MediaQuery.of(context).size.width
  static late double _screenHeight; // MediaQuery.of(context).size.height
  static double? _minFontSize;
  static double? _maxFontSize;
  static double? _minFontSizeScale;
  static double? _maxFontSizeScale;

  static late double _safeBlockHorizontal;
  static late double _safeBlockVertical;

  static late num _uiWidthPx;
  static late num _uiHeightPx;

  static double get _scaleWidth => _screenWidth / _uiWidthPx;

  static double get _scaleHeight => _screenHeight / _uiHeightPx;

  static double get _scaleText => _scaleHeight;

  static void init({
    required BoxConstraints constraints,
    required Orientation orientation,
    required num referenceHeight,
    required num referenceWidth,
    double? minFontSize,
    double? maxFontSize,
    double? minFontSizeScale,
    double? maxFontSizeScale,
  }) {
    /**
     * Initializes all the values required for the package to work
     */
    // media query object
    // _mediaQueryData = MediaQuery.of(context);
    // width and height using MediaQuery
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
    } else {
      _screenWidth = constraints.maxHeight;
      _screenHeight = constraints.maxWidth;
    }

    // reference screen size
    _uiWidthPx = referenceWidth;
    _uiHeightPx = referenceHeight;

    //minimum font size
    _minFontSize = minFontSize;
    //maximum font size
    _maxFontSize = maxFontSize;
    //minimum font size scale
    _minFontSizeScale = minFontSizeScale;
    //maximum font size scale
    _maxFontSizeScale = maxFontSizeScale;

    _safeBlockHorizontal = _screenWidth / 100;
    _safeBlockVertical = _scaleHeight / 100;
  }
}

class _SizeConfigPercentage extends _SizeConfig {
  static double relativeHeight({required num heightPercentage}) {
    /**
     * Enter Height Percentage with respect to screen size.
     */
    return _SizeConfig._safeBlockVertical * heightPercentage;
  }

  static double relativeWidth({required num widthPercentage}) {
    /**
     * Enter Width Percentage with respect to screen size.
     */
    return _SizeConfig._safeBlockHorizontal * widthPercentage;
  }
}

class _SizeConfigValue extends _SizeConfig {
  static double relativeFontSize({required num fontSize}) {
    /**
     * Changes size of fonts based on screen
     */
    double scale = _SizeConfig._scaleText;
    if (_SizeConfig._minFontSizeScale != null) {
      scale = max(scale, _SizeConfig._minFontSizeScale!);
    }
    if (_SizeConfig._maxFontSizeScale != null) {
      scale = min(scale, _SizeConfig._maxFontSizeScale!);
    }
    double value = fontSize * scale;
    if (_SizeConfig._minFontSize != null) {
      value = max(value, _SizeConfig._minFontSize!);
    }
    if (_SizeConfig._maxFontSize != null) {
      value = min(value, _SizeConfig._maxFontSize!);
    }
    return value;
  }

  static double relativeHeight({required num height}) {
    /**
     * Enter Height of widget you want and will change according to the size of screen.
     */
    return _SizeConfig._scaleHeight * height;
  }

  static double relativeWidth({required num width}) {
    /**
     * Enter Width of widget you want and will change according to the size of screen.
     */
    return _SizeConfig._scaleWidth * width;
  }
}
