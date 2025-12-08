import 'package:test_vibe/core/widgets/loading/loading_more.dart';
import 'package:test_vibe/modules/app/categories/bloc/categories_bloc.dart';
import 'package:test_vibe/modules/app/categories/widgets/plain_menu_item/plain_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/extensions/spacing_theme.dart';
import '../../../../core/widgets/animated_list_grid/animated_list_grid.dart';
import '../../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../../../../core/widgets/appbars/custom_appbar.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../bloc/categories_state.dart';

class MenusPage extends StatefulWidget {
  const MenusPage({
    super.key,
    required this.title,
    required this.bloc,
  });

  final String title;
  final CategoriesBloc bloc;

  @override
  State<MenusPage> createState() => _MenusPageState();
}

class _MenusPageState extends State<MenusPage> {
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
      widget.bloc.getMoreCategories();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: AppBarTitleWithCart(title: widget.title),
      ),
      body: BlocProvider.value(
        value: widget.bloc,
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            final models = state.allCategoriesDataState.data;
            return  Column(
              children: [
                Expanded(
                  child: AnimatedListOrGrid(
                    itemBuilder:(context, index) => PlainMenuItem(
                      model: models[index],
                      bloc: widget.bloc ,
                    ) ,
                    padding: SpacingTheme.of(context).pagePadding ,
                    gridDelegate: PlainMenuItem.gridDelegate ,
                    controller: _scrollController,
                    itemCount: models.length ,
                    isGrid: true,

                  ),
                ),
                if (state.allCategoriesDataState.loadingState.reloading)
                  const Center(child: LoadingMore()),
              ],
            );

          },
        ),
      ),
    );
  }
}
