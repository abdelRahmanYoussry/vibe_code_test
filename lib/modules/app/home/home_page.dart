import 'dart:async';

import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/modules/app/categories/widgets/categories_section/categories_section.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/home_appbar.dart';
import 'package:test_vibe/modules/app/home/widgets/home_nav_links_section/home_nav_links_section.dart';
import 'package:test_vibe/modules/app/home/widgets/newly_released_products_section/newly_released_products_section.dart';
import 'package:test_vibe/modules/app/home/widgets/signatures_products_section/signatures_products_section.dart';
import 'package:test_vibe/modules/app/home/widgets/special_offers_section/special_offers_section.dart';
import 'package:test_vibe/modules/app/home/widgets/top_requested_products_section/top_requested_products_section.dart';
import 'package:test_vibe/modules/app/offers/bloc/offers_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/utils/remote/api_helper.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import '../orders/bloc/orders_bloc.dart';
import '../orders/bloc/orders_state.dart';
import '../orders/widgets/active_order_details/active_order_details.dart';
import '../rewards/my_rewards_progress_section/my_rewards_progress_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? refreshOrdersSubscription;

  @override
  void initState() {
    refreshOrdersSubscription = eventBus.on<GetUserOrdersEvent>().listen((event) {
      context.read<OrdersBloc>().getTrackOrder();
    });
    super.initState();
  }

  @override
  dispose() {
    refreshOrdersSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      overridePageName: Nav.home,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          HomeAppBar(),
        ],
        body: RefreshIndicator(
          onRefresh: () async {
            await Future.wait([
              context.read<SpecialOffersBloc>().getAllSpecialOffers(),
              context.read<OrdersBloc>().getTrackOrder(),
            ]);
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: BlocSelector<OrdersBloc, OrdersState, GetTrackOrderState>(
                  selector: (state) => state.getTrackOrderState,
                  builder: (context, state) {
                    final data = state.data;
                    if (state.loadingState.loading) {
                      return SizedBox(
                        height: 100.h,
                        child: const Center(child: CircularLoadingWidget()),
                      );
                    }
                    if (data != null && !state.loadingState.loading) {
                      return Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: ActiveOrderDetails(
                          model: data,
                          onAddMinutes: (int minutes) {
                            return context.read<OrdersBloc>().addMinutesToOrder(minutes);
                          },
                        ),
                      );
                    }
                    return SizedBox.shrink();
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 15.h)),
              SliverToBoxAdapter(child: CategoriesSection()),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(child: TopRequestedProductsSection()),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(child: NewlyReleasedProductsSection()),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(child: HomeNavLinksSection()),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(child: SpecialOffersSection(offersBloc: context.read<SpecialOffersBloc>())),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(child: MyRewardsProgressSection()),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverSignaturesProductsSection(),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
            ],
          ),
        ),
      ),
    );
  }
}
