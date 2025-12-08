import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/widgets/pic.dart';
import '../../../products/widgets/plain_product_item/plain_product_item_theme.dart';
import '../../models/special_offers_model.dart';

class OfferPlainProductItem extends StatelessWidget {
  const OfferPlainProductItem({
    super.key,
    required this.model,
    required this.selectedProduct,
  });

  final FlashSaleProductModel model;
  final ValueNotifier<FlashSaleProductModel?> selectedProduct;

  @override
  Widget build(BuildContext context) {
    final productItem2Theme = PlainProductItemTheme.of(context);
    return ValueListenableBuilder<FlashSaleProductModel?>(
      valueListenable: selectedProduct,
      builder: (context, selectedId, _) {
        final isSelected = selectedId?.id == model.id;
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            if (isSelected) {
              selectedProduct.value = null;
            } else {
              selectedProduct.value = model;
            }
          },
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: productItem2Theme.borderRadius,
              border: Border.fromBorderSide(
                isSelected
                    ? BorderSide(color: Theme.of(context).primaryColor, width: 2.0)
                    : productItem2Theme.borderSide,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Pic(
                        model.image ?? '',
                        fit: BoxFit.cover,
                      ),
                      // Add a transparent layer to ensure touch events work
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            if (isSelected) {
                              selectedProduct.value = null;
                            } else {
                              selectedProduct.value = model;
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
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
                      SizedBox(height: 4.h),
                      // Quantity information
                      Text(
                        '${Loc.of(context).quantity}: ${model.quantity.toStringAsFixed(0)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      SizedBox(height: 2.h),
                      // Price information with strikethrough for original price
                      Row(
                        children: [
                          Text(
                            'AED ${model.original_price_for_quantity.toStringAsFixed(2)}',
                            style: productItem2Theme.priceTextStyle.copyWith(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'AED ${model.flash_sale_price_for_quantity.toStringAsFixed(2)}',
                            style: productItem2Theme.priceTextStyle.copyWith(
                              color: AppColors.red98,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      // Discount percentage
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: AppColors.red98.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Text(
                          '${Loc.of(context).discount} ${model.discountPercent.toStringAsFixed(0)}%',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.red98,
                                fontWeight: FontWeight.bold,
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
      },
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 175.w,
    mainAxisExtent: 240.h, // Increased height to accommodate more text
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}
