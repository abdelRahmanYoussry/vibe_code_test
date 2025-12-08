import 'dart:async';

import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/utils/remote/api_helper.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/modules/app/orders/bloc/orders_state.dart';
import 'package:test_vibe/modules/app/orders/widgets/active_order_details/active_order_details.dart';
import 'package:test_vibe/modules/app/orders/widgets/order_widget/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/widgets/animated_list_grid/animated_list_grid.dart';
import '../../../core/widgets/empty/empty_widget.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../core/widgets/loading/loading_more.dart';
import '../../../core/widgets/snack_bar/snack_bar.dart';
import '../root/bloc/root_bloc.dart';
import 'bloc/orders_bloc.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> with AutomaticKeepAliveClientMixin {
  late ScrollController _scrollController;
  late final ValueNotifier<String> selectType;
  StreamSubscription? _tabSubscription;
  StreamSubscription? refreshOrdersSubscription;

  // Add this to maintain state when switching tabs
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    selectType = ValueNotifier<String>('active');
    refreshOrdersSubscription = eventBus.on<GetUserOrdersEvent>().listen((event) {
      context.read<OrdersBloc>().getOrders(selectType.value);
      context.read<OrdersBloc>().getTrackOrder();
    });
    // Listen to root tab changes
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   final rootBloc = BlocProvider.of<RootBloc>(context, listen: false);
    //   _tabSubscription = rootBloc.stream.listen((state) {
    //     if (state.currentIndex == RootIndex.orders && mounted) {
    //       // Refresh data when orders tab becomes active
    //       context.read<OrdersBloc>().getOrders(selectType.value);
    //       context.read<OrdersBloc>().getTrackOrder();
    //     }
    //   });
    // });
    // Load data immediately when page is created
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Force refresh data when page loads
      context.read<OrdersBloc>().getOrders(selectType.value);
      // context.read<OrdersBloc>().getTrackOrder();

      final rootBloc = BlocProvider.of<RootBloc>(context, listen: false);
      _tabSubscription = rootBloc.stream.listen((state) {
        if (state.currentIndex == RootIndex.orders && mounted) {
          debugPrint('Orders tab is active');
          // Refresh data when orders tab becomes active
          context.read<OrdersBloc>().getOrders(selectType.value);
          context.read<OrdersBloc>().getTrackOrder();
        }
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabSubscription?.cancel();
    refreshOrdersSubscription?.cancel();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      debugPrint('bottom');
      context.read<OrdersBloc>().getMoreOrders(selectType.value);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final spacingTheme = SpacingTheme.of(context);
    final tabs = [
      (
        text: Loc.of(context).my_orders,
        tab: Tab(text: Loc.of(context).active),
      ),
      (
        text: Loc.of(context).completed_orders,
        tab: Tab(text: Loc.of(context).completed),
      ),
      (
        text: Loc.of(context).canceled_orders,
        tab: Tab(text: Loc.of(context).canceled),
      ),
    ];
    return BlocListener<OrdersBloc, OrdersState>(
      listenWhen: (previous, current) {
        return previous.addMinutesToOrderState != current.addMinutesToOrderState ||
        previous.deleteOrderState != current.deleteOrderState
        ;
      },
      listener: (context, state) {
        if (state.addMinutesToOrderState.error != null) {
          SnackBarBuilder.showFeedBackMessage(
            context,
            state.addMinutesToOrderState.error ?? Loc.of(context).server_error,
            isSuccess: false,
          );
        } else if (state.deleteOrderState.error != null) {
          SnackBarBuilder.showFeedBackMessage(
            context,
            state.deleteOrderState.error ?? Loc.of(context).server_error,
            isSuccess: false,
          );
        }
      },
      child: Builder(
        builder: (context) {
          return ValueListenableBuilder(
            valueListenable: selectType,
            builder: (context, value, child) {
              return CustomScaffold(
                overridePageName: Nav.orders,
                appBar: CustomAppbar(
                  title: Text(Loc.of(context).orders),
                  overridePageName: Nav.orders,
                  showBackButton: false,
                ),
                body: DefaultTabController(
                  length: tabs.length,
                  child: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) => [
                      BlocSelector<OrdersBloc, OrdersState, GetTrackOrderState>(
                        selector: (state) {
                          return state.getTrackOrderState;
                        },
                        builder: (context, state) {
                          final data = state.data;
                          if (data == null && !state.loadingState.loading) {
                            return SliverToBoxAdapter(
                              child: Center(
                                child: SizedBox.shrink(),
                              ),
                            );
                          }
                          if (state.loadingState.loading) {
                            return SliverToBoxAdapter(
                              child: SizedBox(
                                height: 100.h,
                                child: const Center(child: CircularLoadingWidget()),
                              ),
                            );
                          }
                          return SliverAppBar(
                            automaticallyImplyLeading: false,
                            pinned: false,
                            floating: true,
                            snap: true,
                            expandedHeight: 265.h,
                            flexibleSpace: FlexibleSpaceBar(
                              background: BlocSelector<OrdersBloc, OrdersState, AddMinutesToOrderState>(
                                selector: (state) {
                                  return state.addMinutesToOrderState;
                                },
                                builder: (context, state) {
                                  return ActiveOrderDetails(
                                    model: data!,
                                    addMinutesLoading: state.loadingState.loading,
                                    onAddMinutes: (int minutes) {
                                      return context.read<OrdersBloc>().addMinutesToOrder(minutes);
                                    },
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: _HeaderDelegate(
                          maxHeight: 80.h,
                          minHeight: 50.h,
                          child: Container(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            padding: spacingTheme.pagePadding,
                            child: TabBar(
                              tabs: [for (final tab in tabs) tab.tab],
                              onTap: (value) {
                                selectType.value = tabs[value].tab.text?.toLowerCase() ?? '';
                                debugPrint('value: ${selectType.value}');
                                context.read<OrdersBloc>().getOrders(selectType.value);
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                    body: TabBarView(
                      children: [
                        for (final tab in tabs)
                          BlocSelector<OrdersBloc, OrdersState, GetOrdersState>(
                            selector: (state) {
                              return state.getOrdersState;
                            },
                            builder: (context, state) {
                              final list = state.data;
                              if (list.isEmpty && !state.loadingState.loading) {
                                return Center(
                                  child: EmptyWidget(),
                                );
                              }
                              if (state.loadingState.loading) {
                                return const Center(child: CircularLoadingWidget());
                              }

                              return AnimatedListOrGrid(
                                padding: spacingTheme.pagePadding.add(
                                  EdgeInsets.only(top: 24.h),
                                ),
                                itemCount: list.length,
                                isGrid: false,
                                controller: _scrollController,
                                itemBuilder: (context, index) {
                                  if (index == list.length - 1 && state.loadingState.reloading) {
                                    return const Center(child: LoadingMore());
                                  }
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if (index == 0)
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 8.0),
                                          child: Text(
                                            tab.text,
                                            style: Theme.of(context).textTheme.titleMedium,
                                          ),
                                        ),
                                      BlocSelector<OrdersBloc, OrdersState, bool>(
                                        selector: (state) {
                                          return state.deleteOrderState.loadingState.loading &&
                                              state.deletingOrderId == list[index].orderId;
                                        },
                                        builder: (context, isDeleteLoading) {
                                          return OrderProductItem(
                                            model: list[index],
                                            showProductType: true,
                                            isOffer: list[index].products.first.isOffer,
                                            onCancelOrder: () {
                                              context.read<OrdersBloc>().deleteOrder(list[index].orderId);
                                            },
                                            isDeleteLoading: isDeleteLoading ,
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _HeaderDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_HeaderDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight || minHeight != oldDelegate.minHeight || child != oldDelegate.child;
  }
}
