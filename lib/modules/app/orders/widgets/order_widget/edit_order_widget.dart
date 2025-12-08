import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/core/widgets/quantity_counter/quantity_counter.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/assets/gen/assets.gen.dart';
import '../../../../../core/localization/gen/loc.dart';
import '../../../../../core/navigation/nav.dart';
import '../../../../../core/theme/constants/app_colors.dart';

import '../../../../../core/utils/data_utils.dart';
import '../../../cart/widgets/cart_product_item/cart_product_item_theme.dart';
import '../../../qr_codes/widgets/qr_product_item/qr_product_item_theme.dart';
import '../../models/order_model.dart';

class EditOrderItem extends StatelessWidget {
  final OrderProductModel product;
  final int quantity;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;
  final bool showCounter;

  const EditOrderItem({
    super.key,
    required this.product,
    required this.onQuantityChanged,
    required this.onRemove,
    this.showCounter = true,
    this.quantity = 1,
  });

  @override
  Widget build(BuildContext context) {
    final qrProductItemTheme = QrProductItemTheme.of(context);
    final cartProductItemTheme = CartProductItemTheme.of(context);
    return Container(
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: BorderRadius.circular(12),
      //   boxShadow: [
      //     BoxShadow(
      //       color: Colors.black.withOpacity(0.05),
      //       blurRadius: 8,
      //       offset: const Offset(0, 2),
      //     ),
      //   ],
      // ),
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
                            product.imageUrl?.url ?? '',
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
                                Nav.productDetails
                                    .push(context, args: product.id);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!showCounter && validString(product.offerDescription))
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
                        margin: EdgeInsets.only(
                          bottom: 15.h,
                          right: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.red6E,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          product.offerDescription,
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
                            product.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: cartProductItemTheme.titleTextStyle,
                            minFontSize: 8.sp,
                            maxFontSize:
                                qrProductItemTheme.titleTextStyle.fontSize ??
                                    14.sp,
                            stepGranularity: 1.sp,
                          ),
                        ),
                        IconButton(
                          style:
                              cartProductItemTheme.deleteButtonStyle.copyWith(
                            padding: WidgetStateProperty.all(
                                EdgeInsets.symmetric(horizontal: 8.w)),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            alignment: Alignment.topCenter,
                            minimumSize:
                                WidgetStateProperty.all(Size(24.w, 24.h)),
                          ),
                          onPressed: () {
                            onRemove.call();
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
                        // if (model.options.options is Map && model.options.options.isNotEmpty)
                        //   ...(model.options.options as Map<String, dynamic>).entries.map(
                        //         (entry) {
                        //       // final optionId = entry.key;
                        //       final optionValues = entry.value;
                        //       // final optionName = model.options.optionInfo?[optionId] ?? '';
                        //       if (optionValues is List && optionValues.isNotEmpty) {
                        //         final values = optionValues
                        //             .map(
                        //               (item) => item is Map ? item['option_value']?.toString() ?? '' : '',
                        //         )
                        //             .join(', ');
                        //         return AutoSizeText(
                        //           values,
                        //           maxLines: 1,
                        //           overflow: TextOverflow.ellipsis,
                        //           style: cartProductItemTheme.bodyTextStyle,
                        //           minFontSize: 8,
                        //           maxFontSize: cartProductItemTheme.bodyTextStyle.fontSize ?? 14,
                        //           stepGranularity: 1,
                        //         );
                        //       }
                        //       return SizedBox();
                        //     },
                        //   ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Row(
                  children: [
                    if (product.isFreeOffer || validateBool(product.isOffer))
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 4.h),
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
                              validString(product.offerDescription)
                                  ? product.offerDescription
                                  : Loc.of(context).free,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (quantity > 1)
                              Text(
                                ' x$quantity',
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
                          product.formattedPrice,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: cartProductItemTheme.priceTextStyle,
                        ),
                      ),
                    if (showCounter)
                      Expanded(
                        child: QuantityCounter(
                          onChanged: (value) {
                            onQuantityChanged.call(value);
                          },
                          initial: quantity,
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
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 358.w,
    mainAxisExtent: 174.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}
