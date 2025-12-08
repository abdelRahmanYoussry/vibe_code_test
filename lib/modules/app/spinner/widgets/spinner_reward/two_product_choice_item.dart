import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/widgets/pic.dart';
import '../../../products/models/product_model_api.dart';
import '../../../products/widgets/plain_product_item/plain_product_item_theme.dart';

class TwoProductChoiceItem extends StatelessWidget {
  const TwoProductChoiceItem({
    super.key,
    required this.model,
    required this.selectedFirstProductId,
    required this.selectedSecondProductId,
  });

  final ProductModelApi model;
  final ValueNotifier<String?> selectedFirstProductId;
  final ValueNotifier<String?> selectedSecondProductId;

  @override
  Widget build(BuildContext context) {
    final productItem2Theme = PlainProductItemTheme.of(context);
    return ValueListenableBuilder<String?>(
      valueListenable: selectedFirstProductId,
      builder: (context, paidId, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: selectedSecondProductId,
          builder: (context, freeId, _) {
            final isFirstSelected = paidId == model.id;
            final isSecondSelected = freeId == model.id;
            final isSelected = isFirstSelected || isSecondSelected;

            Color borderColor = productItem2Theme.borderSide.color;
            double borderWidth = productItem2Theme.borderSide.width;

            if (isFirstSelected) {
              borderColor = AppColors.brown33;
              borderWidth = 2.0;
            } else if (isSecondSelected) {
              borderColor = AppColors.red6E;
              borderWidth = 2.0;
            }

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => _handleTap(isFirstSelected, isSecondSelected),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: productItem2Theme.borderRadius,
                  border: Border.fromBorderSide(
                    BorderSide(color: borderColor, width: borderWidth),
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
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                              onTap: () => _handleTap(isFirstSelected, isSecondSelected),
                            ),
                          ),
                          // Show selection indicator
                          if (isSelected)
                            Positioned(
                              top: 8.h,
                              right: 8.w,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: isFirstSelected ? AppColors.brown33 : AppColors.red6E,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  isFirstSelected ? Loc.of(context).first : Loc.of(context).second,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
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
          },
        );
      },
    );
  }

  void _handleTap(bool isFirstSelected, bool isSecondSelected) {
    if (isFirstSelected) {
      // Unselect paid product
      selectedFirstProductId.value = null;
    } else if (isSecondSelected) {
      // Unselect free product
      selectedSecondProductId.value = null;
    } else {
      // Select product - prioritize paid selection if none selected
      if (selectedFirstProductId.value == null) {
        selectedFirstProductId.value = model.id;
      } else if (selectedSecondProductId.value == null) {
        selectedSecondProductId.value = model.id;
      } else {
        // Both slots taken, replace paid product
        selectedFirstProductId.value = model.id;
      }
    }
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 175.w,
    mainAxisExtent: 200.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}
