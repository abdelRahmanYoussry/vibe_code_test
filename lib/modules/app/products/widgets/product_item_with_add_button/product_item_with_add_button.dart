import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/buttons/custom_gesture_detector.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/cart/add_to_cart_params.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_bloc.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_state.dart';
import 'package:test_vibe/modules/app/products/models/product_model_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/widgets/snack_bar/snack_bar.dart';
import 'product_item_with_add_button_theme.dart';

class ProductItemWithAddButton extends StatelessWidget {
  const ProductItemWithAddButton({
    super.key,
    required this.apiModel,
    this.afterProductAdded,
    this.addProductMethod,
  });

  final ProductModelApi apiModel;
  final VoidCallback? afterProductAdded;
  final VoidCallback? addProductMethod;

  @override
  Widget build(BuildContext context) {
    var productItemTheme = ProductItemWithAddButtonTheme.of(context);
    return BlocProvider(
      create: (context) => di<AddToCartBloc>(),
      child: BlocListener<AddToCartBloc, AddToCartState>(
        listener: (context, state) {
          if (state.addToCartDataState.success != null && state.addToCartDataState.success!) {
            AddToCartSnackBarBuilder.showFeedBackMessage(
              context,
              state.addToCartDataState.data?.data?.totalPrice.toString() ?? '',
              state.addToCartDataState.data?.data?.count.toString() ?? '',
            );
            if (afterProductAdded != null) {
              afterProductAdded!();
            }
          } else if (state.addToCartDataState.error != null) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.addToCartDataState.error ?? '',
              isSuccess: false,
            );
          }
        },
        child: Builder(
          builder: (context) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Nav.productDetails.push(context, args: apiModel.id);
              },
              child: SizedBox(
                width: gridDelegate.maxCrossAxisExtent,
                height: gridDelegate.mainAxisExtent,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 135.h,
                      width: 120.w,
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
                                      apiModel.imageUrl ?? '',
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
                                          Nav.productDetails.push(context, args: apiModel.id);
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            bottom: 0,
                            end: 0,
                            child: Transform.translate(
                              offset: Offset(7.5.w, 7.5.h),
                              child: CustomGestureDetector(
                                behavior: HitTestBehavior.opaque, // Ensure it captures gestures
                                onPressed: () {
                                  // BlocProvider.of<AddToCartBloc>(context)
                                  //     .addToCart(params: AddToCartParams(productId: apiModel.id, quantity: '1'));
                                  // Nav.productDetails.push(context, args: apiModel.id);
                                  if (apiModel.productOptions.isNotEmpty) {
                                    Nav.productDetails.push(context, args: apiModel.id);
                                  } else {
                                    if(addProductMethod != null) {
                                      addProductMethod!();
                                      return;
                                    }
                                    BlocProvider.of<AddToCartBloc>(context)
                                        .addToCart(params: AddToCartParams(productId: apiModel.id, quantity: '1'));
                                  }
                                },
                                padding: EdgeInsets.only(
                                  top: 12.w,
                                  left: 12.w,
                                ),
                                child: Container(
                                  width: 36.w,
                                  height: 36.w,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).colorScheme.primary,
                                    border: Border.all(
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                      width: 4.sp,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    size: 20.sp,
                                    color: Theme.of(context).scaffoldBackgroundColor,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 9.h),
                    AutoSizeText(
                      apiModel.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: productItemTheme.titleTextStyle,
                      stepGranularity: 1,
                      minFontSize: 10,
                      maxFontSize: 14,
                    ),
                    AutoSizeText(
                      apiModel.slug,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: productItemTheme.subtitleTextStyle,
                      stepGranularity: 0.1,
                      minFontSize: 10,
                      maxFontSize: 14,
                    ),
                    SizedBox(height: 2.h),
                    AutoSizeText(
                      apiModel.final_price,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: productItemTheme.priceTextStyle,
                      stepGranularity: 1,
                      minFontSize: 10,
                      maxFontSize: 12,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 120.w,
    mainAxisExtent: 200.h,
    crossAxisSpacing: 14.w,
    mainAxisSpacing: 14.h,
  );
}
