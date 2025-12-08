import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/lists/horizontal_list.dart';
import 'package:test_vibe/core/widgets/section_label/section_label.dart';
import 'package:test_vibe/modules/app/products/bloc/products_bloc.dart';
import 'package:test_vibe/modules/app/products/widgets/product_item_with_add_button/product_item_with_add_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../products/bloc/products_state.dart';
import '../top_requested_products_section/all_top_requested_products/all_top_requsted_products_page_params.dart';


class NewlyReleasedProductsSection extends StatelessWidget {
  const NewlyReleasedProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final title = Loc.of(context).newlyReleased;
    return BlocProvider(
      create: (context) => di<ProductsBloc>()..newlyReleasedProducts(),
      child: BlocSelector<ProductsBloc, ProductsState, NewlyReleasedProductsDataState>(
        selector: (state) => state.newlyReleasedProductsDataState,
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
              Nav.newlyReleasedProducts.push(
                context,
                args: AllTopRequestedProductsPageParams(
                  title: title,
                  bloc: context.read<ProductsBloc>(),
                ),
              );
            },
            child: HorizontalListView(
              padding: SpacingTheme.of(context).pagePadding,
              itemCount:list.length,
              height: ProductItemWithAddButton.gridDelegate.mainAxisExtent!+5.h,
              separatorBuilder: (context, index) =>
                  SizedBox(width: ProductItemWithAddButton.gridDelegate.crossAxisSpacing),
              itemBuilder: (context, index) => ProductItemWithAddButton(
                apiModel: list[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
