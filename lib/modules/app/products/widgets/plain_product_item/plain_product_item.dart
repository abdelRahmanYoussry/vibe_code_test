import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/products/models/product_model_api.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'plain_product_item_theme.dart';

class PlainProductItem extends StatelessWidget {
  const PlainProductItem({
    super.key,
    required this.model,
  });

  final ProductModelApi model;

  @override
  Widget build(BuildContext context) {
    final productItem2Theme = PlainProductItemTheme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Nav.product.push(context, args: models[0] );
        debugPrint('aaaaaaaaaaaaaaaaaaaaaaa');
        Nav.productDetails.push(context, args: model.id);
      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: productItem2Theme.borderRadius,
          border: Border.fromBorderSide(productItem2Theme.borderSide),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Pic(
                    model.imageUrl??'',
                    fit: BoxFit.cover,
                  ),
                  // Add a transparent layer to ensure touch events work
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        Nav.productDetails.push(context, args: model.id);
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Expanded(
            //   child: Pic(
            //     model.imageUrl??'',
            //     fit: BoxFit.cover,
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    model.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: productItem2Theme.titleTextStyle,
                    minFontSize: 8,
                    maxFontSize: productItem2Theme.titleTextStyle.fontSize ?? 14.sp,
                    stepGranularity: 1,
                  ),
                  Text(
                    model.final_price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: productItem2Theme.priceTextStyle,
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
    maxCrossAxisExtent: 175.w,
    mainAxisExtent: 200.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}
