import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/products/models/product_model_api.dart';
import 'package:test_vibe/modules/app/qr_codes/models/qr_model.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'qr_product_item_theme.dart';

class QrProductItem extends StatelessWidget {
  const QrProductItem({
    super.key,
    required this.model,
    this.showProductType = true,
  });

  final QrModel model;
  final bool showProductType;

  @override
  Widget build(BuildContext context) {
    final qrProductItemTheme = QrProductItemTheme.of(context);
    return Column(
      children: [
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Nav.productDetails.push(context, args:demoApiProducts.first.id);
          },
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(8)),
                child: Pic(
                  model.product?.image ?? '',
                  fit: BoxFit.cover,
                  width: 80.w,
                  height: 80.w,
                ),
              ),
              SizedBox(width: 18.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      model.product?.name ?? '',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: qrProductItemTheme.titleTextStyle,
                      minFontSize: 8.sp,
                      maxFontSize: qrProductItemTheme.titleTextStyle.fontSize ?? 14.sp,
                      stepGranularity: 1.sp,
                    ),
                    if (showProductType)
                      Text(
                        model.product?.type ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: qrProductItemTheme.subtitleTextStyle,
                      ),
                  ],
                ),
              ),
              SizedBox(width: 18.w),
              IconButton(
                onPressed: () {
                  Nav.qrSheet.sheet(context);
                },
                icon: Pic(
                  Assets.icons.qrCode.path,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Divider(),
        SizedBox(height: 24.h),
      ],
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 175.w,
    mainAxisExtent: 200.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}
