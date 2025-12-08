import 'package:test_vibe/modules/app/rewards/repo/rewards_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import 'rewards_state.dart';

class RewardsBloc extends Cubit<RewardsState> {
  RewardsBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.rewardsRepo,
  }) : super(const RewardsState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
 final RewardsRepo rewardsRepo;

  int rewardFreeProductsPageNumber = 1;
  bool rewardFreeProductsIsLastPage = false;

  Future<void> getRewardsProgress() async {
    emit(state.copyWith(rewardsProgressState: state.rewardsProgressState.asLoading()));
    final f = await rewardsRepo.getRewardsProgress();
    f.fold(
      (l) => emit(
        state.copyWith(
          rewardsProgressState: state.rewardsProgressState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            rewardsProgressState: state.rewardsProgressState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getQrItemRewards() async {
    emit(state.copyWith(rewardsQrState: state.rewardsQrState.asLoading()));
    final f = await rewardsRepo.getQrRewards();
    f.fold(
      (l) => emit(
        state.copyWith(
          rewardsQrState: state.rewardsQrState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            rewardsQrState: state.rewardsQrState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getRewardFreeProducts() async {
    rewardFreeProductsPageNumber = 1;
    emit(state.copyWith(getRewardsFreeProductsState: state.getRewardsFreeProductsState.asLoading()));
    final f = await rewardsRepo.getRewardsProducts(rewardFreeProductsPageNumber.toString());
    f.fold(
          (l) => emit(
        state.copyWith(
          getRewardsFreeProductsState: state.getRewardsFreeProductsState.asLoadingFailed(l),
        ),
      ),
          (r) {
        rewardFreeProductsPageNumber = 2;
        if (r.length != 10) {
          rewardFreeProductsIsLastPage = true;
        } else {
          rewardFreeProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            getRewardsFreeProductsState: state.getRewardsFreeProductsState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreRewardFreeProducts() async {
    if (state.getRewardsFreeProductsState.loadingState.loading ||
        state.getRewardsFreeProductsState.loadingState.reloading ||
        rewardFreeProductsIsLastPage) {
      return;
    }
    emit(state.copyWith(getRewardsFreeProductsState: state.getRewardsFreeProductsState.asReloading()));
    final f = await rewardsRepo.getRewardsProducts(rewardFreeProductsPageNumber.toString());
    f.fold(
          (l) => emit(
        state.copyWith(
          getRewardsFreeProductsState: state.getRewardsFreeProductsState.asReloadingFailed(l),
        ),
      ),
          (r) {
        rewardFreeProductsPageNumber += 1;
        if (r.length != 10) {
          rewardFreeProductsIsLastPage = true;
        } else {
          rewardFreeProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            getRewardsFreeProductsState: state.getRewardsFreeProductsState.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }
}
