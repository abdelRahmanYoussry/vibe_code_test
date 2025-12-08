import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/lists/horizontal_list.dart';
import 'package:test_vibe/core/widgets/section_label/section_label.dart';
import 'package:test_vibe/modules/app/products/products_page_params.dart';
import 'package:test_vibe/modules/app/products/widgets/product_item_with_add_button/product_item_with_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../products/bloc/products_bloc.dart';
import '../../../products/bloc/products_state.dart';

class CartSuggestedProductsSection extends StatelessWidget {
  const CartSuggestedProductsSection({
    super.key,
    this.afterProductAdded,
    this.addProductMethod,
  });

  final VoidCallback? afterProductAdded;
  final VoidCallback? addProductMethod;


  @override
  Widget build(BuildContext context) {
    final title = Loc.of(context).more_suggestions;
    return BlocProvider(
      create: (context) => di<ProductsBloc>()..getTopRequestedProducts(),
      child: BlocSelector<ProductsBloc, ProductsState, AllTopRequestedProductsDataState>(
        selector: (state) {
          return state.topRequestedProductsDataState;
        },
        builder: (context, state) {
          final list = state.data;
          if (list.isEmpty && !state.loadingState.loading) {
            return const SizedBox();
          }
          if (state.loadingState.loading) {
            return SizedBox(
              height: ProductItemWithAddButton.gridDelegate.mainAxisExtent ?? 0,
              child: const Center(child: CircularLoadingWidget()),
            );
          }
          return SectionLabel(
            label: title,
            labelPadding: SpacingTheme.of(context).pagePadding,
            onSeeMorePressed: () {
              Nav.products.push(
                context,
                args: ProductsPageParams(
                  title: title,
                  models: list,
                ),
              );
            },
            child: HorizontalListView(
              padding: SpacingTheme.of(context).pagePadding,
              itemCount: list.length,
              height: ProductItemWithAddButton.gridDelegate.mainAxisExtent!,
              separatorBuilder: (context, index) =>
                  SizedBox(width: ProductItemWithAddButton.gridDelegate.crossAxisSpacing),
              itemBuilder: (context, index) => ProductItemWithAddButton(
                apiModel: list[index],
                afterProductAdded: afterProductAdded ,
                addProductMethod: addProductMethod,
              ),
            ),
          );
        },
      ),
    );
  }
}
