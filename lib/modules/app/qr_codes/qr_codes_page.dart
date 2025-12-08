import 'package:test_vibe/core/components/page_label/page_label.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/lists/vertical_list.dart';
import 'package:test_vibe/modules/app/qr_codes/models/qr_model.dart';
import 'package:test_vibe/modules/app/qr_codes/widgets/qr_product_item/qr_product_item.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';

class QrCodesPage extends StatelessWidget {
  const QrCodesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final spacingTheme = SpacingTheme.of(context);
    final models = [...demoQrs];
    return CustomScaffold(
      appBar: CustomAppbar(
        title: Text(Loc.of(context).qrCode),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 12.h)),
          SliverPadding(
            padding: spacingTheme.pagePadding,
            sliver: PageLabelSliver(
              label: Loc.of(context).scanToPay,
              sliver: MultiSliver(
                children: [
                  VerticalSliverListView(
                    separatorBuilder: (context, index) => SizedBox(),
                    itemCount: models.length,
                    itemBuilder: (context, index) => QrProductItem(model: models[index]),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
