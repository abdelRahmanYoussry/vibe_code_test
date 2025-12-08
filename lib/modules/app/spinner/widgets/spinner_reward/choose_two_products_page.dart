import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/loading/loading_more.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_bloc.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_state.dart';
import 'package:test_vibe/modules/app/products/widgets/plain_product_item/plain_product_item.dart';
import 'package:test_vibe/modules/app/spinner/widgets/spinner_reward/two_product_choice_item.dart';
import 'package:test_vibe/modules/app/spinners/bloc/spinners_bloc.dart';
import 'package:test_vibe/modules/app/spinners/bloc/spinners_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import '../../../../../../../../core/widgets/animated_list_grid/animated_list_grid.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/localization/gen/loc.dart';
import '../../../../../core/navigation/nav.dart';
import '../../../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../../../../../core/widgets/buttons/custom_elevated_button.dart';
import '../../../../../core/widgets/empty/empty_widget.dart';
import '../../../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../../../core/widgets/snack_bar/snack_bar.dart';
import '../../../cart/add_to_cart_params.dart';

class ChooseTwoProductsPage extends StatefulWidget {
  const ChooseTwoProductsPage({
    super.key,
    required this.title,
    required this.type,
    required this.rewardId,
  });

  final String title;
  final String type;
  final String rewardId;

  @override
  State<ChooseTwoProductsPage> createState() => _ChooseTwoProductsPageState();
}

class _ChooseTwoProductsPageState extends State<ChooseTwoProductsPage> {
  late ScrollController _scrollController;
  late ValueNotifier<String?> selectedFirstProductId;
  late ValueNotifier<String?> selectedSecondProductId;
  late SpinnersBloc _bloc;
  int successfulAdditions = 0; // Track successful cart additions

  @override
  void initState() {
    super.initState();
    selectedFirstProductId = ValueNotifier<String?>(null);
    selectedSecondProductId = ValueNotifier<String?>(null);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _bloc = di<SpinnersBloc>()..getSpinnerBuyOneGetOne(widget.type);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    selectedFirstProductId.dispose();
    selectedSecondProductId.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      debugPrint('bottom');
      _bloc.getMoreSpinnerBuyOneGetOne(widget.type);
    }
  }

  String _getCurrentInstruction() {
    if (selectedFirstProductId.value == null) {
      return Loc.of(context).choose_first_product;
    } else if (selectedSecondProductId.value == null) {
      return Loc.of(context).choose_second_product;
    }
    return '';
  }

  void _addProductsToCart(AddToCartBloc cartBloc) {
    successfulAdditions = 0; // Reset counter
    final products = [
      AddToCartParams(
        productId: selectedFirstProductId.value!,
        quantity: '1',
        type: 'spinner',
        isDrink: widget.type == 'drink' ? true : false,
        rewardId: widget.rewardId,
      ),
      AddToCartParams(
        productId: selectedSecondProductId.value!,
        quantity: '1',
        type: 'spinner',
        isDrink: widget.type == 'drink' ? true : false,
        rewardId: widget.rewardId,
      ),
    ];

    // Add first product
    cartBloc.addToCart(params: products[0]);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: AppBarTitleWithCart(title: widget.title),
      ),
      bottomNavigationBar: BlocProvider(
        create: (context) => di<AddToCartBloc>(),
        child: BlocListener<AddToCartBloc, AddToCartState>(
          listener: (context, state) {
            if (state.addToCartDataState.success != null && state.addToCartDataState.success!) {
              successfulAdditions++;

              if (successfulAdditions == 1) {
                // First product added successfully, add the second one
                context.read<AddToCartBloc>().addToCart(
                      params: AddToCartParams(
                        productId: selectedSecondProductId.value!,
                        quantity: '1',
                        type: 'spinner',
                        isDrink: widget.type == 'drink' ? true : false,
                        rewardId: widget.rewardId,
                      ),
                    );
              } else if (successfulAdditions == 2) {
                // Both products added successfully
                Nav.root.popUntil(context);
                Nav.cart.push(context);
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
            valueListenable: selectedFirstProductId,
            builder: (context, paidValue, child) {
              return ValueListenableBuilder(
                valueListenable: selectedSecondProductId,
                builder: (context, freeValue, child) {
                  return BlocSelector<AddToCartBloc, AddToCartState, AddToCartDataState>(
                    selector: (state) => state.addToCartDataState,
                    builder: (context, state) {
                      return Padding(
                        padding:  EdgeInsets.only(bottom: 20.h,left: 16.w,right: 16.w),
                        child: CustomElevatedButton(
                          enabled: selectedFirstProductId.value != null && selectedSecondProductId.value != null,
                          loading: state.loadingState.loading,
                          onPressed: () {
                            if (selectedFirstProductId.value != null && selectedSecondProductId.value != null) {
                              _addProductsToCart(context.read<AddToCartBloc>());
                            }
                          },
                          child: Text(Loc.of(context).apply),
                        ),
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
      body: BlocProvider.value(
        value: _bloc,
        child: BlocBuilder<SpinnersBloc, SpinnersState>(
          builder: (context, state) {
            final list = state.getSpinnerBuyOneGetOneFree.data;
            if (list.isEmpty && !state.getSpinnerBuyOneGetOneFree.loadingState.loading) {
              return Center(
                child: EmptyWidget(),
              );
            }
            if (state.getSpinnerBuyOneGetOneFree.loadingState.loading) {
              return SizedBox(
                height: 200.h,
                child: const Center(child: CircularLoadingWidget()),
              );
            }
            return Column(
              children: [
                ValueListenableBuilder(
                  valueListenable: selectedFirstProductId,
                  builder: (context, paidValue, _) {
                    return ValueListenableBuilder(
                      valueListenable: selectedSecondProductId,
                      builder: (context, freeValue, _) {
                        final instruction = _getCurrentInstruction();
                        if (instruction.isEmpty) return const SizedBox.shrink();

                        return Padding(
                          padding: SpacingTheme.of(context).pagePadding,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                instruction,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: selectedFirstProductId.value == null ? AppColors.brown33 : AppColors.red6E,
                                ),
                              ),
                              SizedBox(height: 16.h),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
                Expanded(
                  child: AnimatedListOrGrid(
                    itemCount: list.length,
                    controller: _scrollController,
                    gridDelegate: PlainProductItem.gridDelegate,
                    isGrid: true,
                    padding: SpacingTheme.of(context).pagePadding,
                    itemBuilder: (context, index) => TwoProductChoiceItem(
                      model: list[index],
                      selectedFirstProductId: selectedFirstProductId,
                      selectedSecondProductId: selectedSecondProductId,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                if (state.getSpinnerBuyOneGetOneFree.loadingState.reloading) const LoadingMore(),
              ],
            );
          },
        ),
      ),
    );
  }
}
