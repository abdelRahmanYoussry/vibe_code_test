import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/product/widgets/add_cart_section/add_cart_section.dart';
import 'package:test_vibe/modules/app/products/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';


class ProductPage extends StatelessWidget {
  const ProductPage({
    super.key,
    required this.model,
  });

  final ProductModel model;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: Text(Loc.of(context).create_order),
      ),
      bottomNavigationBar: AddCartSection(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Pic(
              model.image,
              fit: BoxFit.cover,
              height: 224.h,
              width: double.infinity,
            ),
            SizedBox(height: 24.h),
            Padding(
              padding: SpacingTheme.of(context).pagePadding,
              child: Column(
                children: [
                  // ProductInfoWidget(
                  //   model: model,
                  // ),
                  // for (final item in model.customizations) ...[
                  //   SizedBox(height: 24.h),
                  //   ProductCustomization(
                  //     model: item,
                  //   ),
                  // ],
                  SizedBox(height: 14.h),
                  // AddCommentButton(),
                ],
              ),
            ),
            SizedBox(height: 14.h),
            Divider(),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
