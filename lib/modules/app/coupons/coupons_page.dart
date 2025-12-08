import 'package:test_vibe/core/components/page_label/page_label.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/empty/empty_widget.dart';
import 'package:test_vibe/core/widgets/lists/vertical_list.dart';
import 'package:test_vibe/modules/app/check_out/bloc/check_out_bloc.dart';
import 'package:test_vibe/modules/app/check_out/bloc/check_out_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../../core/di/di.dart';
import '../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import 'widgets/coupon_item.dart';

class CouponsPage extends StatelessWidget {
  const CouponsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final spacingTheme = SpacingTheme.of(context);
    return BlocProvider(
      create: (context) => di<CheckOutBloc>()..getCoupons(),
      child: BlocListener<CheckOutBloc, CheckOutState>(
        listener: (context, state) {},
        child: Builder(
          builder: (context) {
            return CustomScaffold(
              appBar: CustomAppbar(
                title:AppBarTitleWithCart(title: Loc.of(context).coupons ,),
              ),
              body: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                  BlocSelector<CheckOutBloc, CheckOutState, GetCouponsState>(
                    selector: (state) {
                      return state.getCouponsState;
                    },
                    builder: (context, state) {
                      final list = state.data;
                      if (list.isEmpty && !state.loadingState.loading) {
                        return SliverToBoxAdapter(child: const EmptyWidget());
                      }
                      if (state.loadingState.loading) {
                        return SliverToBoxAdapter(
                          child: SizedBox(
                            height: CouponItem.gridDelegate.mainAxisExtent ?? 0,
                            child: const Center(child: CircularLoadingWidget()),
                          ),
                        );
                      }
                      return SliverPadding(
                        padding: spacingTheme.pagePadding,
                        sliver: PageLabelSliver(
                          label: Loc.of(context).coupons_for_you,
                          sliver: MultiSliver(
                            children: [
                              VerticalSliverListView(
                                separatorBuilder: (context, index) =>
                                    SizedBox(height: CouponItem.gridDelegate.mainAxisSpacing),
                                itemCount: list.length,
                                itemBuilder: (context, index) => CouponItem(model: list[index]),
                              ),
                              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
