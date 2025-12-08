import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/lists/vertical_list.dart';
import 'package:flutter/material.dart';
import '../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import 'models/special_offers_model.dart';
import 'widgets/offer_item/offer_item.dart';

class OffersPage extends StatelessWidget {
  const OffersPage({super.key, required this.flashSaleModelList});
  final List<FlashSaleModel> flashSaleModelList;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title:AppBarTitleWithCart(title: Loc.of(context).special_offers ,),
      ),
      body: Padding(
        padding: SpacingTheme.of(context).pagePadding,
        child: VerticalListView(
          itemCount: flashSaleModelList.length,
          separatorBuilder: (context, index) => SizedBox(height: OfferItem.gridDelegate.mainAxisSpacing),
          itemBuilder: (context, index) => OfferItem(model: flashSaleModelList[index]),
        ),
      ),
    );
  }
}
