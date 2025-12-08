import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/widgets/pic.dart';
import '../../../products/models/product_model_api.dart';
import '../../../products/widgets/plain_product_item/plain_product_item_theme.dart';

class ChooseProductItem extends StatelessWidget {
  const ChooseProductItem({
    super.key,
    required this.model,
    required this.selectedProductId,
    this.showPrice = true,
  });

  final ProductModelApi model;
  final ValueNotifier<String?> selectedProductId;
  final bool showPrice ;

  @override
  Widget build(BuildContext context) {
    final productItem2Theme = PlainProductItemTheme.of(context);
    return ValueListenableBuilder<String?>(
        valueListenable: selectedProductId,
        builder: (context, selectedId, _) {
          final isSelected = selectedId == model.id;
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (isSelected) {
                // Unselect if already selected
                selectedProductId.value = null;
              } else {
                // Select this product
                selectedProductId.value = model.id;
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
                          model.imageUrl ?? '',
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
                                selectedProductId.value = null;
                              } else {
                                selectedProductId.value = model.id;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
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
                        if (showPrice)
                        Text(
                          model.final_price,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: productItem2Theme.priceTextStyle.copyWith(color: AppColors.red98),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },);
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 175.w,
    mainAxisExtent: 200.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}
