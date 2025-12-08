import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/lists/horizontal_list.dart';
import 'package:test_vibe/core/widgets/section_label/section_label.dart';
import 'package:test_vibe/modules/app/categories/bloc/categories_bloc.dart';
import 'package:test_vibe/modules/app/categories/widgets/category_item/category_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/localization/gen/loc.dart';
import '../../../../../core/widgets/loading/circular_loading_widget.dart';
import '../../models/menus_page_params.dart';
import '../../bloc/categories_state.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final title = Loc.of(context).menu;
    return BlocProvider(
      create: (context) => di<CategoriesBloc>()..getCategories(),
      child: BlocSelector<CategoriesBloc, CategoriesState, AllCategoriesDataState>(
        selector: (state) {
          return state.allCategoriesDataState;
        },
        builder: (context, state) {
          final list = state.data;
          if (list.isEmpty && !state.loadingState.loading) {
            return const SizedBox();
          }
          if (state.loadingState.loading) {
            return SizedBox(
              height: CategoryItem.gridDelegate.mainAxisExtent ?? 0,
              child: const Center(child: CircularLoadingWidget()),
            );
          }
          return SectionLabel(
            label: title,
            labelPadding: SpacingTheme.of(context).pagePadding,
            onSeeMorePressed: () {
              Nav.menus.push(
                context,
                args: MenusPageParams(title: title, bloc: context.read<CategoriesBloc>()),
              );
            },
            child: HorizontalListView(
              padding: SpacingTheme.of(context).pagePadding,
              itemCount: list.length,
              height: CategoryItem.gridDelegate.mainAxisExtent ?? 0,
              separatorBuilder: (context, index) => SizedBox(width: CategoryItem.gridDelegate.crossAxisSpacing),
              itemBuilder: (context, index) => CategoryItem(model: list[index],bloc: context.read<CategoriesBloc>() ,),
            ),
          );
        },
      ),
    );
  }
}
