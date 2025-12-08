import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/lists/grid_list.dart';
import 'package:test_vibe/modules/app/products/models/product_model_api.dart';
import 'package:test_vibe/modules/app/products/widgets/plain_product_item/plain_product_item.dart';
import 'package:flutter/material.dart';


class ProductsPage extends StatelessWidget {
  const ProductsPage({
    super.key,
    required this.models,
    required this.title,
  });

  final List<ProductModelApi> models;
  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: Text(title),
      ),
      body: GridList(
        padding: SpacingTheme.of(context).pagePadding,
        gridDelegate: PlainProductItem.gridDelegate,
        itemCount: models.length,
        itemBuilder: (context, index) => PlainProductItem(
          model: models[index],
        ),
      ),
    );
  }
}
