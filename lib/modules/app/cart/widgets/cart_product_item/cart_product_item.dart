import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/core/widgets/quantity_counter/quantity_counter.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/theme/constants/app_colors.dart';
import '../../models/add_to_cart_model.dart';
import 'cart_product_item_theme.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem({
    super.key,
    required this.model,
    this.onQuantityChanged,
    this.onDelete,
    this.showCounter = true,
  });

  final CartItemModel model;
  final void Function(int quantity)? onQuantityChanged;
  final void Function()? onDelete;
  final bool showCounter;

  @override
  Widget build(BuildContext context) {
    final cartProductItemTheme = CartProductItemTheme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Nav.productDetails.push(context, args: model.id);
      },
      child: Container(
        height: gridDelegate.mainAxisExtent! + 10.h,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          border: Border.all(
            color: showCounter ? AppColors.greyE1 : AppColors.red6E,
            width: showCounter ? 1.sp : 2.sp,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 96.w,
              height: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      clipBehavior: Clip.antiAlias,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: Pic(
                              model.options.image ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned.fill(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  Nav.productDetails.push(context, args: model.id);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children: [
                  //     if (!showCounter && model.options.offer_description != null)
                  //       Container(
                  //         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  //         margin: EdgeInsets.only(bottom: 15.h,),
                  //         decoration: BoxDecoration(
                  //           color: AppColors.red6E,
                  //           borderRadius: BorderRadius.circular(4),
                  //         ),
                  //         child: Text(
                  //           model.options.offer_description ?? '',
                  //           style: cartProductItemTheme.bodyTextStyle.copyWith(color: Colors.white),
                  //         ),
                  //       ),
                  //     Row(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       mainAxisSize: MainAxisSize.min,
                  //       children: [
                  //         Expanded(
                  //           child: AutoSizeText(
                  //             model.name,
                  //             maxLines: 1,
                  //             overflow: TextOverflow.ellipsis,
                  //             style: cartProductItemTheme.titleTextStyle,
                  //             minFontSize: 8,
                  //             maxFontSize: cartProductItemTheme.titleTextStyle.fontSize ?? 14,
                  //             stepGranularity: 1,
                  //           ),
                  //         ),
                  //         IconButton(
                  //           style: cartProductItemTheme.deleteButtonStyle.copyWith(
                  //             padding: WidgetStateProperty.all(EdgeInsets.zero),
                  //             tapTargetSize: MaterialTapTargetSize.padded,
                  //             alignment: Alignment.topCenter,
                  //           ),
                  //           onPressed: () {
                  //             onDelete?.call();
                  //           },
                  //           icon: Pic(
                  //             Assets.icons.trash.path,
                  //             inherit: true,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //     if (model.options.options is Map && model.options.options.isNotEmpty)
                  //       ...(model.options.options as Map<String, dynamic>).entries.map(
                  //         (entry) {
                  //           final optionId = entry.key;
                  //           final optionValues = entry.value;
                  //           final optionName = model.options.optionInfo?[optionId] ?? '';
                  //
                  //           if (optionValues is List && optionValues.isNotEmpty) {
                  //             // Join multiple option values if present
                  //             final values = optionValues
                  //                 .map(
                  //                   (item) => item is Map ? item['option_value']?.toString() ?? '' : '',
                  //                 )
                  //                 .join(', ');
                  //             return AutoSizeText(
                  //               values,
                  //               maxLines: 1,
                  //               overflow: TextOverflow.ellipsis,
                  //               style: cartProductItemTheme.bodyTextStyle,
                  //               minFontSize: 8,
                  //               maxFontSize: cartProductItemTheme.bodyTextStyle.fontSize ?? 14,
                  //               stepGranularity: 1,
                  //             );
                  //           }
                  //           return SizedBox();
                  //         },
                  //       ),
                  //   ],
                  // ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!showCounter && validString(model.options.offer_description))
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          margin: EdgeInsets.only(
                            bottom: 15.h,
                            right: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.red6E,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            model.options.offer_description ?? '',
                            maxLines: 2,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              model.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: cartProductItemTheme.titleTextStyle,
                              minFontSize: 8,
                              maxFontSize: cartProductItemTheme.titleTextStyle.fontSize ?? 14,
                              stepGranularity: 1,
                            ),
                          ),
                          IconButton(
                            style: cartProductItemTheme.deleteButtonStyle.copyWith(
                              padding: WidgetStateProperty.all(EdgeInsets.symmetric(horizontal: 8.w)),
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              alignment: Alignment.topCenter,
                              minimumSize: WidgetStateProperty.all(Size(24.w, 24.h)),
                            ),
                            onPressed: () {
                              onDelete?.call();
                            },
                            icon: Pic(
                              Assets.icons.trash.path,
                              inherit: true,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (model.options.options is Map && model.options.options.isNotEmpty)
                            ...(model.options.options as Map<String, dynamic>).entries.map(
                              (entry) {
                                // final optionId = entry.key;
                                final optionValues = entry.value;
                                // final optionName = model.options.optionInfo?[optionId] ?? '';
                                if (optionValues is List && optionValues.isNotEmpty) {
                                  final values = optionValues
                                      .map(
                                        (item) => item is Map ? item['option_value']?.toString() ?? '' : '',
                                      )
                                      .join(', ');
                                  return AutoSizeText(
                                    values,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: cartProductItemTheme.bodyTextStyle,
                                    minFontSize: 8,
                                    maxFontSize: cartProductItemTheme.bodyTextStyle.fontSize ?? 14,
                                    stepGranularity: 1,
                                  );
                                }
                                return SizedBox();
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    children: [
                      if ((model.options.ifFreeDrink ?? false)|| validateBool(model.options.isFree))
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          margin: EdgeInsets.only(
                            bottom: 15.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.red6E,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              Text(
                                model.options.free_drink_title ?? Loc.of(context).free,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if(model.qty>1)
                                Text(
                                  ' x${model.qty}',
                                  maxLines: 1,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                            ],
                          ),
                        )
                      else
                        Expanded(
                          child: Text(
                            model.subtotal,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: cartProductItemTheme.priceTextStyle,
                          ),
                        ),
                      if (showCounter)
                        Expanded(
                          child: QuantityCounter(
                            onChanged: (value) {
                              onQuantityChanged?.call(value);
                            },
                            initial: model.qty,
                          ),
                        ),
                      SizedBox(width: 16.w),
                    ],
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
    mainAxisExtent: 174.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}
