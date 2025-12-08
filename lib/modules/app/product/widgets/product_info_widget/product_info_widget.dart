import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/modules/app/products/models/product_model_api.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'product_info_widget_theme.dart';

class ProductInfoWidget extends StatelessWidget {
  const ProductInfoWidget({
    super.key,
    required this.model,
  });

  final ProductModelApi model;

  @override
  Widget build(BuildContext context) {
    final productPageBodyTheme = ProductInfoWidgetTheme.of(context);
    debugPrint('Product Info Widget rebuild${model.name}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 24.h,
      children: [
        if (validString(model.name))
          Text(
            model.name,
            textAlign: TextAlign.start,
            style: productPageBodyTheme.titleTextStyle,
          ),
        if (validString(model.description))
          Text(
            model.description,
            textAlign: TextAlign.start,
            style: productPageBodyTheme.bodyTextStyle,
          ),
      ],
    );
  }
}
