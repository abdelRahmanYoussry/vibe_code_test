import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/loading/loading_more.dart';
import 'package:test_vibe/modules/app/products/bloc/products_bloc.dart';
import 'package:test_vibe/modules/app/products/widgets/plain_product_item/plain_product_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/widgets/animated_list_grid/animated_list_grid.dart';
import '../../../../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../../../../products/bloc/products_state.dart';

class AllTopRequestedProductsPage extends StatefulWidget {
  const AllTopRequestedProductsPage({
    super.key,
    required this.title,
    required this.bloc,
  });

  final String title;
  final ProductsBloc bloc;

  @override
  State<AllTopRequestedProductsPage> createState() => _AllTopRequestedProductsPageState();
}

class _AllTopRequestedProductsPageState extends State<AllTopRequestedProductsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      debugPrint('bottom');
      widget.bloc.getMoreTopRequestedProducts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title:AppBarTitleWithCart(title: widget.title),
      ),
      body: BlocProvider.value(
        value: widget.bloc,
        child: BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            final list = state.topRequestedProductsDataState.data;
            return Column(
              children: [
                Expanded(
                  child: AnimatedListOrGrid(
                    itemCount: list.length,
                    controller: _scrollController,
                    gridDelegate: PlainProductItem.gridDelegate,
                    isGrid: true,
                    padding: SpacingTheme.of(context).pagePadding,
                    itemBuilder: (context, index) => PlainProductItem(
                      model: list[index],
                    ),
                  ),
                ),
                if(state.topRequestedProductsDataState.loadingState.reloading) const LoadingMore(),
              ],
            );
          },
        ),
      ),
    );
  }
}
