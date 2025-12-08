import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/loading/loading_more.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_bloc.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_state.dart';
import 'package:test_vibe/modules/app/products/widgets/plain_product_item/plain_product_item.dart';
import 'package:test_vibe/modules/app/rewards/bloc/rewards_state.dart';
import 'package:test_vibe/modules/app/spinner/widgets/spinner_reward/choose_plain_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../../../../../core/widgets/animated_list_grid/animated_list_grid.dart';
import '../../../../../../core/di/di.dart';
import '../../../../../../core/localization/gen/loc.dart';
import '../../../../../../core/navigation/nav.dart';
import '../../../../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../../../../../../core/widgets/buttons/custom_elevated_button.dart';
import '../../../../../../core/widgets/empty/empty_widget.dart';
import '../../../../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../../../../core/widgets/snack_bar/snack_bar.dart';
import '../../../cart/add_to_cart_params.dart';
import '../../bloc/rewards_bloc.dart';

class RewardProductsPage extends StatefulWidget {
  const RewardProductsPage({
    super.key,
    required this.title,
  });

  final String title;



  @override
  State<RewardProductsPage> createState() => _RewardProductsPageState();
}

class _RewardProductsPageState extends State<RewardProductsPage> {
  late ScrollController _scrollController;
  late ValueNotifier<String?> selectedProductId;
  late RewardsBloc _bloc;

  @override
  void initState() {
    super.initState();
    selectedProductId = ValueNotifier<String?>(null);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _bloc = di<RewardsBloc>()..getRewardFreeProducts();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    selectedProductId.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      debugPrint('bottom');
      _bloc.getMoreRewardFreeProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: AppBarTitleWithCart(
          title: widget.title,
        ),
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => di<AddToCartBloc>(),
        child: BlocListener<AddToCartBloc, AddToCartState>(
          listener: (context, state) {
            if (state.addToCartDataState.success != null && state.addToCartDataState.success!) {
              Nav.root.popUntil(context);
              Nav.cart.push(context);
            } else if (state.addToCartDataState.error != null) {
              SnackBarBuilder.showFeedBackMessage(
                context,
                state.addToCartDataState.error ?? Loc.of(context).server_error,
                isSuccess: false,
              );
            }
          },
          child: ValueListenableBuilder(
            valueListenable: selectedProductId,
            builder: (context, value, child) {
              return Padding(
                padding: SpacingTheme.of(context).pagePadding.add(EdgeInsets.only(bottom: 16.h, top: 10.h)),
                child: BlocSelector<AddToCartBloc, AddToCartState, AddToCartDataState>(
                  selector: (state) {
                    return state.addToCartDataState;
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      enabled: selectedProductId.value != null,
                      loading: state.loadingState.loading,
                      onPressed: () {
                        if (selectedProductId.value != null) {
                          context.read<AddToCartBloc>().addToCart(
                                params: AddToCartParams(
                                  productId: selectedProductId.value!,
                                  quantity: '1',
                                  type: 'buy_x_get_y',
                                  isFreeDrink: true,
                                ),
                              );
                        }
                      },
                      child: Text(Loc.of(context).apply),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: selectedProductId,
        builder: (context, value, child) {
          return BlocProvider.value(
            value: _bloc,
            child: BlocBuilder<RewardsBloc, RewardsState>(
              builder: (context, state) {
                final list = state.getRewardsFreeProductsState.data;
                if (list.isEmpty && !state.getRewardsFreeProductsState.loadingState.loading) {
                  return Center(
                    child: EmptyWidget(),
                  );
                }
                if (state.getRewardsFreeProductsState.loadingState.loading) {
                  return SizedBox(
                    height: 200.h,
                    child: const Center(child: CircularLoadingWidget()),
                  );
                }
                return Column(
                  children: [
                    Expanded(
                      child: AnimatedListOrGrid(
                        itemCount: list.length,
                        controller: _scrollController,
                        gridDelegate: PlainProductItem.gridDelegate,
                        isGrid: true,
                        padding: SpacingTheme.of(context).pagePadding,
                        itemBuilder: (context, index) => ChooseProductItem(
                          model: list[index],
                          selectedProductId: selectedProductId,
                          showPrice:false ,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    if (state.getRewardsFreeProductsState.loadingState.reloading) const LoadingMore(),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}
