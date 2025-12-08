import 'package:test_vibe/core/app/app_bloc.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/widgets/my_location_widget/bloc/branches_bloc.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/widgets/my_location_widget/bloc/branches_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/widgets/animated_list_grid/animated_list_grid.dart';
import '../../../core/widgets/empty/empty_widget.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../core/widgets/loading/loading_more.dart';
import 'models/branch_model.dart';
import 'widgets/branch_item/branch_item.dart';

class BranchesPage extends StatefulWidget {
  const BranchesPage({super.key, this.selectedBranch, required this.bloc});

  final BranchModel? selectedBranch;
  final BranchesBloc bloc;

  @override
  State<BranchesPage> createState() => _BranchesPageState();
}

class _BranchesPageState extends State<BranchesPage> {
  late final ValueNotifier<BranchModel?> selectedBranchNotifier;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    final user=AppBloc().state.user;
    selectedBranchNotifier = ValueNotifier(widget.selectedBranch??user?.store_locator);
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    selectedBranchNotifier.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      debugPrint('bottom');
      widget.bloc.getMoreBranches();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc..getBranches(),
      child: BlocListener<BranchesBloc, BranchesState>(
        listenWhen: (previous, current) => previous.assignBranchToUserState != current.assignBranchToUserState,
        listener: (context, state) {
           if(state.assignBranchToUserState.success !=null && state.assignBranchToUserState.success!) {
            Nav.root.replaceAll(context);
           }
        },
        child: CustomScaffold(
          appBar: CustomAppbar(
            title: Text(Loc.of(context).our_branches),
          ),
          body: BlocBuilder<BranchesBloc, BranchesState>(
            builder: (context, state) {
              final list = state.allBranchesDataState.data;
              if (list.isEmpty && !state.allBranchesDataState.loadingState.loading) {
                return Center(child: const EmptyWidget());
              }
              if (state.allBranchesDataState.loadingState.loading) {
                return const Center(child: CircularLoadingWidget());
              }
              return Builder(
                builder: (context) {
                  return ValueListenableBuilder(
                    valueListenable: selectedBranchNotifier,
                    builder: (context, value, child) {
                      return Column(
                        children: [
                          SizedBox(height: 20.h),
                          Expanded(
                            child: ValueListenableBuilder(
                              valueListenable: selectedBranchNotifier,
                              builder: (context, selectedBranch, child) => AnimatedListOrGrid(
                                padding: SpacingTheme.of(context).pagePadding,
                                itemCount: list.length,
                                controller: _scrollController,
                                isGrid: false,
                                itemBuilder: (context, index) => BranchItem(
                                  model: list[index],
                                  checked: selectedBranch?.id == list[index].id,
                                  onTap: () {
                                    selectedBranchNotifier.value = list[index];
                                  },
                                ),
                              ),
                            ),
                          ),
                          if (state.allBranchesDataState.loadingState.reloading) const Center(child: LoadingMore()),
                          Padding(
                            padding: SpacingTheme.of(context).pagePadding,
                            child: CustomElevatedButton(
                              loading: state.assignBranchToUserState.loadingState.loading,
                              enabled: selectedBranchNotifier.value != null,
                              onPressed: () {
                                int? branchId = int.tryParse(
                                  selectedBranchNotifier.value?.id ?? '',
                                );
                                if (branchId != null) {
                                  BlocProvider.of<BranchesBloc>(context).assignBranchToUser(branchId: branchId);
                                }

                                // Navigator.of(context).pop(selectedBranchNotifier.value);
                              },
                              child: Text(Loc.of(context).confirm),
                            ),
                          ),
                          SizedBox(height: 50.h),
                        ],
                      );
                    },
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
