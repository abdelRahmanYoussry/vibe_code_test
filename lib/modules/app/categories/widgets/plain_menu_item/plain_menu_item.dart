import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../categories/bloc/categories_bloc.dart';
import '../../../categories/models/category_model.dart';
import '../../models/category_products_page_params.dart';
import 'plain_menu_item_theme.dart';

class PlainMenuItem extends StatelessWidget {
  const PlainMenuItem({
    super.key,
    required this.model,
    required this.bloc,

  });

  final CategoryModel model;
  final CategoriesBloc bloc;


  @override
  Widget build(BuildContext context) {
    final productItem2Theme = PlainMenuItemTheme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        // Navigate to the category page or perform any action
        // For example: Nav.category.push(context, args: model);
        debugPrint('Tapped on category: ${model.name}');


          Nav.subCategories.push(
            context,
            args: CategoryProductsPageParams(
              title: model.name,
              // bloc: bloc,
              categoryId: int.parse(model.id),
            ),
          );


      },
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: productItem2Theme.borderRadius,
          border: Border.fromBorderSide(productItem2Theme.borderSide),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Expanded(
            //   child: GestureDetector(
            //     onTap: () {
            //       Nav.categoryProducts.push(
            //         context,
            //         args: CategoryProductsPageParams(
            //           title: model.name,
            //           bloc: bloc,
            //           categoryId: int.parse(model.id),
            //         ),
            //       );
            //     },
            //     child: Pic(
            //       model.image,
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            // ),
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Pic(
                    validateString(model.image),
                    fit: BoxFit.cover,
                  ),
                  // Add a transparent layer to ensure touch events work
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
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
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    model.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: productItem2Theme.titleTextStyle,
                    minFontSize: 8,
                    maxFontSize: productItem2Theme.titleTextStyle.fontSize ?? 14.sp,
                    stepGranularity: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 175.w,
    mainAxisExtent: 200.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}
