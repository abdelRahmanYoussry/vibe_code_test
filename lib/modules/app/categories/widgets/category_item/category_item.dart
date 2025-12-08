import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/categories/models/category_model.dart';
import 'package:test_vibe/modules/app/categories/widgets/category_item/category_item_theme.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/theme/constants/app_colors.dart';
import '../../models/category_products_page_params.dart';
import '../../bloc/categories_bloc.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
    required this.model,
    required this.bloc,
  });

  final CategoryModel model;
  final CategoriesBloc bloc;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Nav.subCategories.push(
          context,
          args: CategoryProductsPageParams(
            title: model.name,
           // bloc: bloc,
           categoryId: int.parse(model.id),
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.brown33,
                  ),
                  child: Pic(
                    model.image,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(  // This constrains the Material widget
                  child: Material(
                    color: Colors.transparent,
                    child: GestureDetector(
                      onTap: () {
                        Nav.subCategories.push(
                          context,
                          args: CategoryProductsPageParams(
                            title: model.name,
                            // bloc: bloc,
                            categoryId: int.parse(model.id),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            model.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CategoryItemTheme.of(context).titleTextStyle,
          ),
        ],
      ),
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 83.w,
    mainAxisExtent: 109.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 16.h,
  );
}
