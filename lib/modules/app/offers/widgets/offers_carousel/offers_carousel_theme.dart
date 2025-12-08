import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';

class OffersCarouselTheme extends ThemeExtension<OffersCarouselTheme> {
  static OffersCarouselTheme of(BuildContext context) => Theme.of(context).extension<OffersCarouselTheme>()!;

  final FlutterCarouselOptions carouselOptions;

  const OffersCarouselTheme({
    required this.carouselOptions,
  });

  @override
  ThemeExtension<OffersCarouselTheme> copyWith({FlutterCarouselOptions? carouselOptions}) => OffersCarouselTheme(
        carouselOptions: carouselOptions ?? this.carouselOptions,
      );

  @override
  ThemeExtension<OffersCarouselTheme> lerp(covariant ThemeExtension<OffersCarouselTheme>? other, double t) {
    if (other is! OffersCarouselTheme) {
      return this;
    }
    return OffersCarouselTheme(
      carouselOptions: other.carouselOptions,
    );
  }
}
