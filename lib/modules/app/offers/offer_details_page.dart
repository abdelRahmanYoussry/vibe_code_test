import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/snack_bar/snack_bar.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_bloc.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_state.dart';
import 'package:test_vibe/modules/app/offers/widgets/offer_item/offers_multi_choose.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../../core/widgets/animated_list_grid/animated_list_grid.dart';
import '../../../core/di/di.dart';
import '../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../cart/add_to_cart_params.dart';
import 'models/special_offers_model.dart';

class OfferDetailsPage extends StatefulWidget {
  const OfferDetailsPage({
    super.key,
    required this.list,
  });

  final List<FlashSaleProductModel> list;

  @override
  State<OfferDetailsPage> createState() => _OfferDetailsPageState();
}

class _OfferDetailsPageState extends State<OfferDetailsPage> {
  late ScrollController _scrollController;
  late ValueNotifier<List<FlashSaleProductModel>> selectedProducts;
  int successfulAdditions = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    selectedProducts = ValueNotifier<List<FlashSaleProductModel>>([]);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    selectedProducts.dispose();
    super.dispose();
  }

  void _addProductsToCart(AddToCartBloc cartBloc) {
    successfulAdditions = 0;
    if (selectedProducts.value.isNotEmpty) {
      _addNextProduct(cartBloc, 0);
    }
  }

  void _addNextProduct(AddToCartBloc cartBloc, int index) {
    if (index < selectedProducts.value.length) {
      cartBloc.addToCart(
        params: AddToCartParams(
          productId: selectedProducts.value[index].id.toString(),
          quantity: '1',
          type: 'offer',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: AppBarTitleWithCart(title: Loc.of(context).offer_products),
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => di<AddToCartBloc>(),
        child: BlocListener<AddToCartBloc, AddToCartState>(
          listener: (context, state) {
            if (state.addToCartDataState.success != null && state.addToCartDataState.success!) {
              successfulAdditions++;

              if (successfulAdditions < selectedProducts.value.length) {
                // Add next product
                _addNextProduct(context.read<AddToCartBloc>(), successfulAdditions);
              } else {
                // All products added successfully
                Nav.cart.replace(context);
              }
            } else if (state.addToCartDataState.error != null) {
              SnackBarBuilder.showFeedBackMessage(
                context,
                state.addToCartDataState.error ?? Loc.of(context).server_error,
                isSuccess: false,
              );
            }
          },
          child: ValueListenableBuilder(
            valueListenable: selectedProducts,
            builder: (context, products, child) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (products.isNotEmpty)
                      Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: Text(
                          '${products.length} ${Loc.of(context).products_selected}',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    BlocSelector<AddToCartBloc, AddToCartState, AddToCartDataState>(
                      selector: (state) => state.addToCartDataState,
                      builder: (context, state) {
                        return CustomElevatedButton(
                          enabled: products.isNotEmpty,
                          loading: state.loadingState.loading,
                          onPressed: () {
                            if (products.isNotEmpty) {
                              _addProductsToCart(context.read<AddToCartBloc>());
                            }
                          },
                          child: Text(
                            products.isEmpty
                                ? Loc.of(context).apply
                                : '${Loc.of(context).add_to_cart} (${products.length})',
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedProducts,
        builder: (context, products, child) => Column(
          children: [
            Expanded(
              child: AnimatedListOrGrid(
                itemCount: widget.list.length,
                controller: _scrollController,
                gridDelegate: OfferMultiSelectProductItem.gridDelegate,
                isGrid: true,
                padding: SpacingTheme.of(context).pagePadding,
                itemBuilder: (context, index) => OfferMultiSelectProductItem(
                  model: widget.list[index],
                  selectedProducts: selectedProducts,
                ),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }
}
