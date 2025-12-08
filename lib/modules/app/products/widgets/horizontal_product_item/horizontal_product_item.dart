import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../categories/models/category_products_page_params.dart';
import '../../models/product_model_api.dart';
import 'horizontal_product_item_theme.dart';

class HorizontalProductItem extends StatelessWidget {
  const HorizontalProductItem({
    super.key,
    required this.model,
    this.isSearch = false,
  });

  final ProductModelApi model;
  final bool isSearch;

  @override
  Widget build(BuildContext context) {
    var productItemTheme = HorizontalProductItemTheme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (isSearch) {
          if(model.type == 'product') {
            Nav.productDetails.push(context, args: model.id);
          }
          else if(model.type == 'category') {
            Nav.subCategories.push(
              context,
              args: CategoryProductsPageParams(
                title: model.name,
                // bloc: bloc,
                categoryId: int.parse(model.id),
              ),
            );
          }
        } else {
          Nav.productDetails.push(context, args: model.id);
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                clipBehavior: Clip.antiAlias,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Pic(
                  isSearch ? model.media ?? '' : model.imageUrl ?? '',
                  fit: BoxFit.cover,
                  width: 80.w,
                  height: 80.w,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      model.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: productItemTheme.titleTextStyle,
                      stepGranularity: 1.sp,
                      minFontSize: 4.sp,
                      maxFontSize: productItemTheme.titleTextStyle.fontSize ?? 4.sp,
                    ),
                    AutoSizeText(
                      model.slug,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: productItemTheme.subtitleTextStyle,
                      stepGranularity: 1.sp,
                      minFontSize: 4.sp,
                      maxFontSize: productItemTheme.subtitleTextStyle.fontSize ?? 4.sp,
                    ),
                    SizedBox(height: 4.h),
                    if(validString(model.formattedPrice)|| validString(model.final_price))
                    AutoSizeText(
                      isSearch ? validateString(model.formattedPrice, '-') : validateString(model.final_price, '-'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: productItemTheme.priceTextStyle,
                      stepGranularity: 1.sp,
                      minFontSize: 4.sp,
                      maxFontSize: productItemTheme.priceTextStyle.fontSize ?? 4.sp,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(),
        ],
      ),
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 120.w,
    mainAxisExtent: 200.h,
    crossAxisSpacing: 14.w,
    mainAxisSpacing: 24.h,
  );
}
