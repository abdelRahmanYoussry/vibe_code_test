import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/constants/app_bools.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/empty/empty_widget.dart';
import 'package:test_vibe/core/widgets/lists/vertical_list.dart';
import 'package:test_vibe/modules/app/spinners/bloc/spinners_bloc.dart';
import 'package:test_vibe/modules/app/spinners/bloc/spinners_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/di/di.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import 'widgets/spinner_item/spinner_item.dart';

class SpinnersPage extends StatefulWidget {
  const SpinnersPage({super.key});

  @override
  State<SpinnersPage> createState() => _SpinnersPageState();
}

class _SpinnersPageState extends State<SpinnersPage> {
  @override
  void initState() {
    AppBools.showSpinners = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: Text(Loc.of(context).spinners),
        elevated: false,
      ),
      body: BlocProvider(
        create: (context) => di<SpinnersBloc>()..getAllSpinners(),
        child: BlocListener<SpinnersBloc, SpinnersState>(
          listener: (context, state) {},
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 32.h)),
              BlocSelector<SpinnersBloc, SpinnersState, GetAllSpinnersState>(
                selector: (state) {
                  return state.getAllSpinnersState;
                },
                builder: (context, state) {
                  final list = state.data;
                  if (list.isEmpty && !state.loadingState.loading) {
                    return SliverToBoxAdapter(child: const EmptyWidget());
                  }
                  if (state.loadingState.loading) {
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: SpinnerItem.gridDelegate.mainAxisExtent ?? 0,
                        child: const Center(child: CircularLoadingWidget()),
                      ),
                    );
                  }
                  return VerticalSliverListView(
                    padding: SpacingTheme.of(context).pagePadding,
                    itemCount: list.length,
                    separatorBuilder: (context, index) => SizedBox(height: SpinnerItem.gridDelegate.mainAxisSpacing),
                    itemBuilder: (context, index) => SpinnerItem(model: list[index]),
                  );
                },
              ),
              SliverToBoxAdapter(child: SizedBox(height: 50.h)),
            ],
          ),
        ),
      ),
    );
  }
}
