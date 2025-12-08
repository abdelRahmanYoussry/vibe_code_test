import 'dart:async';

import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/section_label/section_label.dart';
import 'package:test_vibe/modules/app/rewards/bloc/rewards_bloc.dart';
import 'package:test_vibe/modules/app/rewards/bloc/rewards_state.dart';
import 'package:test_vibe/modules/app/rewards/widgets/rewards_progress/rewards_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/di/di.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../../../../core/widgets/loading/circular_loading_widget.dart';

class MyRewardsProgressSection extends StatefulWidget {
  const MyRewardsProgressSection({super.key});

  @override
  State<MyRewardsProgressSection> createState() => _MyRewardsProgressSectionState();
}

class _MyRewardsProgressSectionState extends State<MyRewardsProgressSection> {
  StreamSubscription? refreshRewardsSubscription;
  late RewardsBloc _bloc;
  @override
  void initState() {
    _bloc = di<RewardsBloc>()..getRewardsProgress();
    refreshRewardsSubscription=eventBus.on<RefreshBuyXGetYEvent>().listen((event) {
     _bloc.getRewardsProgress();
    });
    super.initState();
  }


  @override
  void dispose() {
    // Cancel the subscription before disposing
    refreshRewardsSubscription?.cancel();
    // Close the bloc to prevent memory leaks
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // final progress = 5;
    // final max = 5;
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocSelector<RewardsBloc, RewardsState, RewardsProgressState>(
        selector: (state) {
          return state.rewardsProgressState;
        },
        builder: (context, state) {
          final data = state.data;
          final bool userHasFreeCub = (data?.data.progress?.freePending??0) >=1;
          if (data == null && !state.loadingState.loading) {
            return const SizedBox();
          }
          if (state.loadingState.loading) {
            return SizedBox(
              height: 100.h,
              child: const Center(child: CircularLoadingWidget()),
            );
          }
          return Padding(
            padding: SpacingTheme.of(context).pagePadding,
            child: SectionLabel(
              label: Loc.of(context).buyFiveGetOne,
              isRichText: true,
              label2: Loc.of(context).fREE,
              showNumbersOfFreeCubs: validString(data?.data.progress_message),
              numbersOfFreeCubs: data?.data.progress_message,
              labelStyle: TextStyle(
                color: AppColors.red6E,
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
              child: RewardsProgress(
                max: data?.data.buyQty??5,
                progress: userHasFreeCub? (data?.data.buyQty??5)  :data?.data.progress?.currentProgress ?? 0,
              ),
            ),
          );
        },
      ),
    );
  }
}
