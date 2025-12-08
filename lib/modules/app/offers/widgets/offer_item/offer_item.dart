import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../models/special_offers_model.dart';
import 'offer_item_pic_clipper.dart';
import 'offer_item_theme.dart';

class OfferItem extends StatelessWidget {
  const OfferItem({
    super.key,
    required this.model,
  });

  final FlashSaleModel model;

  @override
  Widget build(BuildContext context) {
    final myTheme = OfferItemTheme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Nav.offerDetailsPage.push(context, args: model.products);
      },
      child: Container(
        height: gridDelegate.mainAxisExtent,
        clipBehavior: Clip.antiAlias,
        decoration: myTheme.backgroundDecoration,
        child: Row(
          children: [
            SizedBox(width: 13.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(height: 14.h),
                  Container(
                    decoration: myTheme.labelDecoration,
                    padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                    child: Text(
                      Loc.of(context).todays_offers,
                      style: myTheme.labelTextStyle,
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    Loc.of(context).get_special_offer,
                    style: myTheme.titleTextStyle,
                  ),
                  Text(
                    Loc.of(context).up_to_percent(model.title),
                    style: myTheme.subtitleTextStyle,
                  ),
                  SizedBox(height: 12.h),
                  ElevatedButton(
                    style: myTheme.buttonStyle,
                    onPressed: () {
                      Nav.offerDetailsPage.push(context, args: model.products);
                    },
                    child: Text(Loc.of(context).order_now),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            ClipPath(
              clipBehavior: Clip.antiAlias,
              clipper: OfferItemPictureClipper(),
              child: Stack(
                children: [
                  Pic(
                    model.image,
                    fit: BoxFit.cover,
                    width: 172.w,
                  ),
                  // Add transparent layer to ensure touch events work
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          Nav.offerDetailsPage.push(context, args: model.products);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 358.w,
    mainAxisExtent: 182.h,
    crossAxisSpacing: 25.w,
    mainAxisSpacing: 25.h,
  );
}
