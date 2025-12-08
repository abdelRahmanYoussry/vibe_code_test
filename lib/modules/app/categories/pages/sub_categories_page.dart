import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/core/widgets/empty/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:test_vibe/core/widgets/loading/loading_more.dart';
import 'package:test_vibe/modules/app/categories/bloc/categories_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/widgets/animated_list_grid/animated_list_grid.dart';
import '../../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../../../../core/widgets/appbars/custom_appbar.dart';
import '../../../../core/widgets/custom_scaffold.dart';
import '../../../../core/widgets/lists/horizontal_list.dart';
import '../../../../core/widgets/loading/circular_loading_widget.dart';
import '../../products/widgets/plain_product_item/plain_product_item.dart';
import '../bloc/categories_state.dart';
import '../models/sub_category_model.dart';

class SubCategoriesPage extends StatefulWidget {
  const SubCategoriesPage({
    super.key,
    required this.title,
    // required this.bloc,
    required this.categoryId,
  });

  final String title;
  // final CategoriesBloc bloc;
  final int categoryId;

  @override
  State<SubCategoriesPage> createState() => _SubCategoriesPageState();
}

class _SubCategoriesPageState extends State<SubCategoriesPage> {
  late ScrollController _scrollController;
  late ScrollController _tabScrollController;
  late ValueNotifier<int> selectedTabIndex;

  @override
  void initState() {
    super.initState();
    // widget.bloc.getSubCategories(widget.categoryId);
    context.read<CategoriesBloc>().getSubCategories(widget.categoryId);
    _scrollController = ScrollController();
    _tabScrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    selectedTabIndex = ValueNotifier<int>(0);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabScrollController.dispose();
    selectedTabIndex.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      debugPrint('bottom');
      // widget.bloc.getMoreSubCategories(widget.categoryId);
      context.read<CategoriesBloc>().getMoreSubCategories(widget.categoryId);
    }
  }

  Widget _buildCustomTabBar(List<SubCategoryModel> subCategories) {
    if (subCategories.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: ValueListenableBuilder<int>(
        valueListenable: selectedTabIndex,
        builder: (context, selectedIndex, child) {
          return HorizontalListView(
            controller: _tabScrollController,
            itemCount: subCategories.length,
            height: 60.h,
            separatorBuilder: (context, index) => SizedBox(width: 8.w),
            itemBuilder: (context, index) {
              final isSelected = selectedIndex == index;
              final subCategory = subCategories[index];
              return GestureDetector(
                onTap: () {
                  selectedTabIndex.value = index;
                  // Scroll to center the selected tab
                  _scrollToSelectedTab(index, subCategories.length);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.brown33 : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      subCategory.name.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.brown33,
                      ),
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

  void _scrollToSelectedTab(int selectedIndex, int totalTabs) {
    if (_tabScrollController.hasClients) {
      final screenWidth = MediaQuery.of(context).size.width;
      final itemWidth = 120.w; // Approximate width of each tab
      final spacing = 8.w;

      // Calculate the position to scroll to center the selected tab
      final targetPosition = (selectedIndex * (itemWidth + spacing)) - (screenWidth / 2) + (itemWidth / 2);

      _tabScrollController.animateTo(
        targetPosition.clamp(0.0, _tabScrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Widget _buildProductGrid(SubCategoryModel subCategory) {
    if (subCategory.products.isEmpty) {
      return Column(
        children: [
          SizedBox(height: 80.h), // Space for floating tab bar
          const Expanded(
            child: Center(child: EmptyWidget()),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 60.h), // Add space for the floating tab bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Text(
            subCategory.name,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
        Expanded(
          child: AnimatedListOrGrid(
            controller: _scrollController,
            itemCount: subCategory.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemBuilder: (context, index) {
              return PlainProductItem(
                model: subCategory.products[index],
              );
            },
            isGrid: true,
          ),
        ),
        SizedBox(height: 30.h), // Bottom padding
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: AppBarTitleWithCart(title: widget.title),
      ),
      body: BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
          final subCategories = state.allSubCategoriesDataState.data;

          if (subCategories.isEmpty && !state.allSubCategoriesDataState.loadingState.loading) {
            return const Center(child: EmptyWidget());
          }

          if (state.allSubCategoriesDataState.loadingState.loading) {
            return const Center(child: CircularLoadingWidget());
          }

          // Debug print to check data
          // debugPrint('SubCategories count: ${subCategories.length}');
          // for (int i = 0; i < subCategories.length; i++) {
          //   debugPrint('SubCategory $i: ${subCategories[i].name} - Products: ${subCategories[i].products.length}');
          // }

          return Stack(
            children: [
              // Background content (products)
              ValueListenableBuilder<int>(
                valueListenable: selectedTabIndex,
                builder: (context, selectedIndex, child) {
                  if (subCategories.isEmpty) return const SizedBox.shrink();

                  final currentIndex = selectedIndex.clamp(0, subCategories.length - 1);
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    child: _buildProductGrid(subCategories[currentIndex]),
                  );
                },
              ),

              // Transparent custom tab bar overlay
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withValues(alpha: 0.2),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: _buildCustomTabBar(subCategories),
                ),
              ),

              // Loading indicator for more content
              if (state.allSubCategoriesDataState.loadingState.reloading)
                const Positioned(
                  bottom: 20,
                  left: 0,
                  right: 0,
                  child: Center(child: LoadingMore()),
                ),
            ],
          );
        },
      ),
    );
  }
}
