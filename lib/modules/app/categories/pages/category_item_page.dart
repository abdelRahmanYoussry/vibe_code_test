import 'package:test_vibe/core/widgets/empty/empty_widget.dart';
import 'package:test_vibe/modules/app/categories/widgets/plain_menu_item/plain_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:test_vibe/core/widgets/loading/loading_more.dart';
import 'package:test_vibe/modules/app/categories/bloc/categories_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/extensions/spacing_theme.dart';
import '../../../../core/widgets/animated_list_grid/animated_list_grid.dart';
import '../../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../../../../core/widgets/appbars/custom_appbar.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/loading/circular_loading_widget.dart';
import '../bloc/categories_state.dart';
import '../../products/widgets/plain_product_item/plain_product_item.dart';


class CategoryItemsPage extends StatefulWidget {
  const CategoryItemsPage({
    super.key,
    required this.title,
    // required this.bloc,
    required this.categoryId,
  });

  final String title;
  // final CategoriesBloc bloc;
  final int categoryId ;

  @override
  State<CategoryItemsPage> createState() => _CategoryItemsPageState();
}

class _CategoryItemsPageState extends State<CategoryItemsPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    // widget.bloc.getCategoryProducts(widget.categoryId);
    context.read<CategoriesBloc>().getCategoryProducts(widget.categoryId);
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
      // widget.bloc.getMoreCategoryProducts(widget.categoryId);
      context.read<CategoriesBloc>().getMoreCategoryProducts(widget.categoryId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: AppBarTitleWithCart(title: widget.title),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          final models = state.allCategoryProductsDataState.data;
          if (models.isEmpty && !state.allCategoryProductsDataState.loadingState.loading) {
            return Center(child: const EmptyWidget());
          }
          if(state.allCategoryProductsDataState.loadingState.loading){
            return const Center(child: CircularLoadingWidget());
          }
          return  Column(
            children: [
              Expanded(
                child: AnimatedListOrGrid(
                  itemBuilder:(context, index) => PlainProductItem(
                    model: models[index],

                  ) ,
                  padding: SpacingTheme.of(context).pagePadding ,
                  gridDelegate: PlainMenuItem.gridDelegate ,
                  controller: _scrollController,
                  itemCount: models.length ,
                  isGrid: true,

                ),
              ),
              if (state.allCategoryProductsDataState.loadingState.reloading)
                const Center(child: LoadingMore()),
            ],
          );

        },
      ),
    );
  }
}
