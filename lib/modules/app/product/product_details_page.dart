import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_bloc.dart';
import 'package:test_vibe/modules/app/product/widgets/add_cart_section/add_cart_section.dart';
import 'package:test_vibe/modules/app/product/widgets/add_comment/add_comment_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/di/di.dart';
import '../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../../../core/widgets/empty/empty_widget.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../core/widgets/snack_bar/snack_bar.dart';
import '../cart/bloc/add_to_cart_state.dart';
import '../products/bloc/products_bloc.dart';
import '../products/bloc/products_state.dart';
import 'widgets/add_comment/add_comment_button.dart';
import 'widgets/product_customization/product_customization.dart';
import 'widgets/product_info_widget/product_info_widget.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({
    super.key,
    required this.productId,
  });

  final int productId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  final Map<String, String?> selectedOptions = {};

  void handleOptionSelected(String optionId, String? selectedValue) {
    setState(() {
      selectedOptions[optionId] = selectedValue;
    });
    debugPrint('Selected options: ${selectedOptions.values}'); // For debugging
  }

  int selectedQuantity = 1;

  void handleQuantityChanged(int quantity) {
    setState(() {
      selectedQuantity = quantity;
    });
    debugPrint('Selected quantity: $quantity');
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddToCartBloc>(
          create: (context) => di<AddToCartBloc>(),
        ),
        BlocProvider<ProductsBloc>(
          create: (context) => di<ProductsBloc>()..getProductDetails(productId: widget.productId),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddToCartBloc, AddToCartState>(
            listener: (context, state) {
              if (state.addToCartDataState.success != null && state.addToCartDataState.success!) {
                AddToCartSnackBarBuilder.showFeedBackMessage(
                  context,
                  state.addToCartDataState.data?.data?.totalPrice.toString() ?? '',
                  state.addToCartDataState.data?.data?.count.toString() ?? '',
                );
              } else if (state.addToCartDataState.error != null) {
                SnackBarBuilder.showFeedBackMessage(
                  context,
                  state.addToCartDataState.error ?? Loc.of(context).server_error,
                  isSuccess: false,
                );
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            return BlocSelector<ProductsBloc, ProductsState, GetProductDetailsState>(
              selector: (state) {
                return state.productDetailsState;
              },
              builder: (context, state) {
                final model = state.data;
                if (model == null && !state.loadingState.loading) {
                  return CustomScaffold(
                    appBar: CustomAppbar(
                      title: AppBarTitleWithCart(title: Loc.of(context).create_order ,),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          EmptyWidget(
                            title: Loc.of(context).cart_is_empty,
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (state.loadingState.loading) {
                  return CustomScaffold(
                    appBar: CustomAppbar(
                      title: AppBarTitleWithCart(title: Loc.of(context).create_order ,),
                    ),
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300.h,
                            child: const Center(child: CircularLoadingWidget()),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return CustomScaffold(
                  appBar: CustomAppbar(
                    title: AppBarTitleWithCart(title: Loc.of(context).create_order ,),
                  ),
                  bottomNavigationBar: BlocSelector<AddToCartBloc, AddToCartState, AddToCartDataState>(
                    selector: (state) {
                      return state.addToCartDataState;
                    },
                    builder: (context, state) {
                      return AddCartSection(
                        initial: selectedQuantity,
                        onQuantityChanged: handleQuantityChanged,
                        loading: state.loadingState.loading,
                        price: calculatePrice(model),
                        onAddToCartPressed: (quantity) {
                          // final productOptions = model?.productOptions ?? [];
                          // if(productOptions.isNotEmpty && selectedOptions.isEmpty){
                          //   SnackBarBuilder.showFeedBackMessage(
                          //     context,
                          //     Loc.of(context).please_select_product_options,
                          //     isSuccess: false,
                          //   );
                          //   return;
                          // }
                          context.read<AddToCartBloc>().formatAndAddToCart(
                                productModel: model!,
                                selectedOptions: selectedOptions,
                                quantity: quantity,
                              );
                        },
                      );
                    },
                  ),
                  body: SingleChildScrollView(
                    child: Column(
                      children: [
                        Pic(
                          model?.imageUrl ?? '',
                          fit: BoxFit.cover,
                          height: 224.h,
                          width: double.infinity,
                        ),
                        SizedBox(height: 24.h),
                        Padding(
                          padding: SpacingTheme.of(context).pagePadding,
                          child: Column(
                            children: [
                              ProductInfoWidget(
                                model: model!,
                              ),
                              for (final item in model.productOptions) ...[
                                SizedBox(height: 24.h),
                                ProductCustomization(
                                  model: item,
                                  onOptionSelected: handleOptionSelected,
                                ),
                              ],
                              SizedBox(height: 14.h),
                              AddCommentButton(
                                params: AddCommentParams(
                                  bloc: context.read<AddToCartBloc>(),
                                  productId: int.parse(model.id),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Divider(),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  String calculatePrice(dynamic model) {
    if (model == null) return "";

    double basePrice = double.tryParse(model.price.toString()) ?? 0.0;
    double additionalPrice = 0.0;

    selectedOptions.forEach((optionId, value) {
      if (value != null) {
        try {
          final matchingOptions = model.productOptions.where((option) => option.id.toString() == optionId).toList();

          if (matchingOptions.isNotEmpty) {
            final option = matchingOptions.first;
            final matchingValues = option.values.where((v) => v.id.toString() == value).toList();

            if (matchingValues.isNotEmpty) {
              final selectedValue = matchingValues.first;

              // Extract number from format_price string (e.g. " + AED 2.00 ")
              if (selectedValue.formatPrice != null) {
                String priceStr = selectedValue.formatPrice.replaceAll('+', '').replaceAll('AED', '').trim();
                additionalPrice += double.tryParse(priceStr) ?? 0.0;
              }
            }
          }
        } catch (e) {
          debugPrint('Error calculating price: ${e.toString()}');
        }
      }
    });

    double totalPrice = (basePrice + additionalPrice) * selectedQuantity;
    return totalPrice.toStringAsFixed(1);
  }
}
