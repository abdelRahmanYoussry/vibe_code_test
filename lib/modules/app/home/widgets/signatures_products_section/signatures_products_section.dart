import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/lists/grid_list.dart';
import 'package:test_vibe/core/widgets/section_label/section_label.dart';
import 'package:test_vibe/modules/app/products/bloc/products_bloc.dart';
import 'package:test_vibe/modules/app/products/widgets/plain_product_item/plain_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../products/bloc/products_state.dart';
import '../top_requested_products_section/all_top_requested_products/all_top_requsted_products_page_params.dart';

class SliverSignaturesProductsSection extends StatelessWidget {
  const SliverSignaturesProductsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final title = Loc.of(context).signatures;
    return BlocProvider(
      create: (context) => di<ProductsBloc>()..getSignaturesProducts(),
      child: BlocSelector<ProductsBloc, ProductsState, AllSignaturesProductsDataState>(
        selector: (state) => state.signaturesProductsDataState,
        builder: (context, state) {
          final list = state.data;
          if (list.isEmpty && !state.loadingState.loading) {
            return const SliverToBoxAdapter(child: SizedBox());
          }
          if (state.loadingState.loading) {
            return SliverToBoxAdapter(
              child: SizedBox(
                height: 200.h,
                child: const Center(child: CircularLoadingWidget()),
              ),
            );
          }
          return SliverSectionLabel(
            label: title,
            labelPadding: SpacingTheme.of(context).pagePadding,
            onSeeMorePressed: () {
              Nav.allSignaturesProducts.push(
                context,
                args: AllTopRequestedProductsPageParams(
                  title: title,
                  bloc: context.read<ProductsBloc>(),
                ),
              );
            },
            sliver: SliverGridList(
              padding: SpacingTheme.of(context).pagePadding,
              gridDelegate: PlainProductItem.gridDelegate,
              itemCount: list.length,
              itemBuilder: (context, index) => PlainProductItem(
                model: list[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
