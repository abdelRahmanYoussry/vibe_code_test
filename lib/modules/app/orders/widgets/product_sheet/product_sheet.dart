import 'package:test_vibe/modules/app/orders/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/sheets/custom_sheet/custom_sheet.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/utils/data_utils.dart';
import '../../../../../core/widgets/pic.dart';
import '../../../product/widgets/product_info_widget/product_info_widget_theme.dart';

class ProductDetailsSheet extends StatefulWidget {
  const ProductDetailsSheet({super.key, required this.model});

  final OrderProductModel model;

  @override
  State<ProductDetailsSheet> createState() => _ProductDetailsSheetState();
}

class _ProductDetailsSheetState extends State<ProductDetailsSheet> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSheet(
      title: Text(widget.model.name),
      builder: (context) => Column(
        children: [
          Pic(
            widget.model.imageUrl?.url??'',
            fit: BoxFit.cover,
            height: 224.h,
            width: double.infinity,
            imageBuilder: (provider) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image(
                  image: provider,
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
          SizedBox(height: 16.h),
          ProductInfoWidgetNew(
            model: widget.model,
          ),
          SizedBox(height: 16.h),
          Divider(),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${Loc.of(context).total_price}:',
                style: TextStyle(fontSize: 16.sp),
              ),
              Text(
                widget.model.formattedPrice ,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
class ProductInfoWidgetNew extends StatelessWidget {
  const ProductInfoWidgetNew({
    super.key,
    required this.model,
  });

  final OrderProductModel model;

  @override
  Widget build(BuildContext context) {
    final productPageBodyTheme = ProductInfoWidgetTheme.of(context);
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
            model.description??'No description',
            textAlign: TextAlign.start,
            style: productPageBodyTheme.bodyTextStyle,
          ),
      ],
    );
  }
}
