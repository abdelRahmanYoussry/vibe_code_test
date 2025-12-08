import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/modules/app/offers/widgets/offer_item/offer_item.dart';
import 'package:test_vibe/modules/app/offers/widgets/offers_carousel/offers_carousel_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:size_config/size_config.dart';

import '../../models/special_offers_model.dart';

class OffersCarousel extends StatelessWidget {
  const OffersCarousel({
    super.key,
    required this.models,
  });

  final List<FlashSaleModel> models;

  @override
  Widget build(BuildContext context) {
    final spacingTheme = SpacingTheme.of(context);
    return SizedBox(
      height: 225.h,
      width: double.infinity,
      child: FlutterCarousel.builder(
        options: OffersCarouselTheme.of(context).carouselOptions,
        itemCount: models.length,
        itemBuilder: (context, index, realIndex) => Padding(
          padding: spacingTheme.pagePadding,
          child: OfferItem(model: models[index]),
        ),
      ),
    );
  }
}
