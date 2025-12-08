import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/fields/search_field/search_field.dart';
import 'package:test_vibe/core/widgets/lists/vertical_list.dart';
import 'package:test_vibe/core/widgets/loading/circular_loading_widget.dart';
import 'package:test_vibe/core/widgets/section_label/section_label.dart';
import 'package:test_vibe/modules/app/products/widgets/horizontal_product_item/horizontal_product_item.dart';
import 'package:test_vibe/modules/app/search/bloc/search_bloc.dart';
import 'package:test_vibe/modules/app/search/bloc/search_state.dart';
import 'package:test_vibe/modules/app/search/widgets/recent_search_item/recent_search_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/di/di.dart';
import '../../../core/widgets/empty/empty_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late final TextEditingController searchController;
  late ScrollController _scrollController;
  late final ValueNotifier<bool> showResultsNotifier;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    _scrollController = ScrollController();
    showResultsNotifier = ValueNotifier<bool>(true);
  }

  @override
  void dispose() {
    searchController.dispose();
    _scrollController.dispose();
    showResultsNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final spacingTheme = SpacingTheme.of(context);
    return BlocProvider(
      create: (context) => di<SearchBloc>()..getSearchRecentView(),
      child: BlocListener<SearchBloc, SearchState>(
        listener: (context, state) {},
        child: Builder(
          builder: (context) {
            return CustomScaffold(
              appBar: CustomAppbar(
                title: Text(Loc.of(context).search),
              ),
              body: Column(
                children: [
                  SizedBox(height: 12.h),
                  Padding(
                    padding: spacingTheme.pagePadding,
                    child: SizedBox(
                      height: 55.h,
                      child: SearchField(
                        controller: searchController,
                        clientSearch: true,
                        onFieldSubmitted: (value) {
                          if (value != null && value.trim().isNotEmpty) {
                            BlocProvider.of<SearchBloc>(context).getSearchProducts(keyWords: value);
                            showResultsNotifier.value = false;
                          } else {
                            BlocProvider.of<SearchBloc>(context).getSearchRecentView();
                            showResultsNotifier.value = true;
                          }
                        },
                        onClearPressed: () {
                          BlocProvider.of<SearchBloc>(context).getSearchRecentView();
                          showResultsNotifier.value = true;
                        },
                      ),
                    ),
                  ),
                  ValueListenableBuilder(
                    valueListenable: showResultsNotifier,
                    builder: (context, value, child) {
                      return BlocBuilder<SearchBloc, SearchState>(
                        builder: (context, state) {
                          final isSearchActive = state.searchProductsDataState.data.isNotEmpty ||
                              state.searchProductsDataState.loadingState.loading;
                          final searchProductsList = state.searchProductsDataState.data;
                          debugPrint('searchProductsList: ${searchProductsList.length}');
                          final searchedRecentProducts = state.searchRecentViewState.data?.searchedProducts ?? [];
                          final searchedRecentViewProducts = state.searchRecentViewState.data?.viewedProducts ?? [];
                          if (isSearchActive && state.searchProductsDataState.loadingState.loading) {
                            return Expanded(
                              child: Center(child: CircularLoadingWidget()),
                            );
                          } else if (!isSearchActive && state.searchRecentViewState.loadingState.loading) {
                            return Expanded(
                              child: Center(child: CircularLoadingWidget()),
                            );
                          }

                          if ((isSearchActive&& searchController.text.isNotEmpty) || showResultsNotifier.value == false) {
                            return Expanded(
                              child: searchProductsList.isEmpty
                                  ? Center(child: EmptyWidget())
                                  : CustomScrollView(
                                      controller: _scrollController,
                                      slivers: [
                                        SliverPadding(
                                          padding: spacingTheme.pagePadding.add(
                                            EdgeInsets.symmetric(vertical: 16.h),
                                          ),
                                          sliver: SliverList(
                                            delegate: SliverChildBuilderDelegate(
                                              (context, index) => Padding(
                                                padding: EdgeInsets.only(bottom: 8.h),
                                                child: HorizontalProductItem(model: searchProductsList[index],isSearch: true,),
                                              ),
                                              childCount: searchProductsList.length,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                            );
                          } else {
                            return Expanded(
                              child: CustomScrollView(
                                controller: _scrollController,
                                slivers: [
                                  SliverToBoxAdapter(child: SizedBox(height: 24.h)),
                                  searchedRecentProducts.isEmpty
                                      ? SliverToBoxAdapter(child: SizedBox())
                                      : SliverPadding(
                                          padding: EdgeInsets.only(bottom: 26.h),
                                          sliver: SliverSectionLabel(
                                            label: Loc.of(context).recent_search,
                                            labelPadding: spacingTheme.pagePadding,
                                            sliver: VerticalSliverListView(
                                              padding: spacingTheme.pagePadding,
                                              itemCount: searchedRecentProducts.length,
                                              separatorBuilder: (context, index) => SizedBox(height: 8.h),
                                              itemBuilder: (context, index) => RecentSearchItem(
                                                model: searchedRecentProducts[index],
                                                onTapPressed: () {
                                                  searchController.text = searchedRecentProducts[index].name;
                                                  BlocProvider.of<SearchBloc>(context).getSearchProducts(
                                                    keyWords: searchedRecentProducts[index].name,
                                                  );
                                                },
                                                onClearPressed: () {
                                                  BlocProvider.of<SearchBloc>(context).clearSearchRecentView(
                                                    searchedRecentProducts[index].id,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                  searchedRecentViewProducts.isEmpty
                                      ? SliverToBoxAdapter(child: SizedBox())
                                      : SliverSectionLabel(
                                          label: Loc.of(context).recent_view,
                                          labelPadding: spacingTheme.pagePadding,
                                          labelContentGap: 16.h,
                                          sliver: VerticalSliverListView(
                                            padding: spacingTheme.pagePadding,
                                            itemCount: searchedRecentViewProducts.length,
                                            separatorBuilder: (context, index) =>
                                                SizedBox(height: HorizontalProductItem.gridDelegate.mainAxisSpacing),
                                            itemBuilder: (context, index) =>
                                                HorizontalProductItem(model: searchedRecentViewProducts[index]),
                                          ),
                                        ),
                                ],
                              ),
                            );
                          }
                        },
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
