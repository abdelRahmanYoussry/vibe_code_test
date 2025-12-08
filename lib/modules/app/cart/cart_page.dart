import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/empty/empty_widget.dart';
import 'package:test_vibe/core/widgets/lists/vertical_list.dart';
import 'package:test_vibe/modules/app/cart/add_to_cart_params.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_bloc.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_state.dart';
import 'package:test_vibe/modules/app/cart/widgets/cart_overview_section/cart_overview_section.dart';
import 'package:test_vibe/modules/app/cart/widgets/cart_product_item/cart_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/di/di.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import 'widgets/cart_suggested_products_section/cart_suggested_products_section.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final spacingTheme = SpacingTheme.of(context);
    // final models = [...demoApiCartItems];
    return BlocProvider(
      create: (context) => di<AddToCartBloc>()..getCartDetails(),
      child: BlocListener<AddToCartBloc, AddToCartState>(
        listener: (context, state) {
          if (state.addToCartDataState.success != null && state.addToCartDataState.success!) {
            context.read<AddToCartBloc>().getCartDetails(isSilent: true);
          }
        },
        child: Builder(
          builder: (context) {
            return CustomScaffold(
              appBar: CustomAppbar(
                title: Text(Loc.of(context).cart),
              ),
              body: BlocSelector<AddToCartBloc, AddToCartState, GetFromCartDataState>(
                selector: (state) {
                  return state.getFromCartDataState;
                },
                builder: (context, state) {
                  final list = state.data?.data?.content;
                  if (list == null && !state.loadingState.loading) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          EmptyWidget(
                            title: Loc.of(context).cart_is_empty,
                          ),
                          SizedBox(height: 24.h),
                          CartSuggestedProductsSection(
                            afterProductAdded: () {
                              BlocProvider.of<AddToCartBloc>(context).getCartDetails(isSilent: true);
                            },
                          ),
                        ],
                      ),
                    );
                  }
                  if (state.loadingState.loading) {
                    return Center(
                      child: SizedBox(
                        height: 100.h,
                        child: const Center(child: CircularLoadingWidget()),
                      ),
                    );
                  }
                  return CustomScrollView(
                    slivers: [
                      VerticalSliverListView(
                        padding: spacingTheme.pagePadding,
                        itemCount: list!.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: CartProductItem.gridDelegate.mainAxisSpacing),
                        itemBuilder: (context, index) {
                          // Convert map to list for use in ListView
                          final cartItems = list.values.toList();
                          return CartProductItem(
                            model: cartItems[index],
                            onQuantityChanged: (quantity) {
                              final cartItems = list.values.toList();
                              AddToCartParams params = AddToCartParams(
                                productId: cartItems[index].id.toString(),
                                quantity: quantity.toString(),
                                rowId: cartItems[index].rowId,
                                // options: cartItems[index].options,
                              );
                              BlocProvider.of<AddToCartBloc>(context).updateCart(params: params);
                            },
                            showCounter: cartItems[index].options.type == null,
                            onDelete: () {
                              final cartItems = list.values.toList();
                              debugPrint('row Id ${cartItems[index].rowId}');
                              BlocProvider.of<AddToCartBloc>(context).deleteFromCart(
                                productId: cartItems[index].rowId,
                                type: cartItems[index].options.type,
                              );
                            },
                          );
                        },
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                      SliverToBoxAdapter(
                        child: CartSuggestedProductsSection(
                          afterProductAdded: () {
                            BlocProvider.of<AddToCartBloc>(context).getCartDetails(isSilent: true);
                          },
                        ),
                      ),
                      SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                      SliverToBoxAdapter(
                        child: CartOverviewSection(
                          cartData: state.data!.data!,
                          enableCheckOut: state.data?.data!.content.isNotEmpty ?? false,
                          onCouponApplied: () {
                            BlocProvider.of<AddToCartBloc>(context).getCartDetails(isSilent: false);
                          },
                        ),
                      ),
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
