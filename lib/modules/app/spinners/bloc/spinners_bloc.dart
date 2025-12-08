import 'package:test_vibe/modules/app/spinners/repo/spinners_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import '../models/spinner_reward_model.dart';
import 'spinners_state.dart';

class SpinnersBloc extends Cubit<SpinnersState> {
  SpinnersBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.spinnersRepo,
  }) : super(const SpinnersState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final SpinnersRepo spinnersRepo;

  int spinnerFreeProductsPageNumber = 1;
  bool spinnerFreeProductsIsLastPage = false;

  int spinnerBuyOneGetOnePageNumber = 1;
  bool spinnerBuyOneGetOneIsLastPage = false;

  Future<void> getAllSpinners() async {
    emit(state.copyWith(getAllSpinnersState: state.getAllSpinnersState.asLoading()));
    final f = await spinnersRepo.getAllSpinners();
    f.fold(
      (l) => emit(
        state.copyWith(
          getAllSpinnersState: state.getAllSpinnersState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            getAllSpinnersState: state.getAllSpinnersState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<SpinnerRewardResult?> spinTheWheel(int spinnerId) async {
    emit(state.copyWith(spinTheWheelState: state.spinTheWheelState.asLoading()));
    final result = await spinnersRepo.spinTheWheel(spinnerId);

    return result.fold(
      (error) {
        emit(state.copyWith(spinTheWheelState: state.spinTheWheelState.asLoadingFailed(error)));
        return null;
      },
      (rewardResult) {
        emit(
          state.copyWith(
            spinTheWheelState: state.spinTheWheelState.asLoadingSuccess(success: true, data: rewardResult),
          ),
        );
        return rewardResult;
      },
    );
  }

  Future<void> getSpinnerFreeProducts() async {
    spinnerFreeProductsPageNumber = 1;
    emit(state.copyWith(getSpinnerFreeProductsState: state.getSpinnerFreeProductsState.asLoading()));
    final f = await spinnersRepo.getSpinnerFreeProducts(spinnerFreeProductsPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          getSpinnerFreeProductsState: state.getSpinnerFreeProductsState.asLoadingFailed(l),
        ),
      ),
      (r) {
        spinnerFreeProductsPageNumber = 2;
        if (r.length != 10) {
          spinnerFreeProductsIsLastPage = true;
        } else {
          spinnerFreeProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            getSpinnerFreeProductsState: state.getSpinnerFreeProductsState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreSpinnerFreeProducts() async {
    if (state.getSpinnerFreeProductsState.loadingState.loading ||
        state.getSpinnerFreeProductsState.loadingState.reloading ||
        spinnerFreeProductsIsLastPage) {
      return;
    }
    emit(state.copyWith(getSpinnerFreeProductsState: state.getSpinnerFreeProductsState.asReloading()));
    final f = await spinnersRepo.getSpinnerFreeProducts(spinnerFreeProductsPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          getSpinnerFreeProductsState: state.getSpinnerFreeProductsState.asReloadingFailed(l),
        ),
      ),
      (r) {
        spinnerFreeProductsPageNumber += 1;
        if (r.length != 10) {
          spinnerFreeProductsIsLastPage = true;
        } else {
          spinnerFreeProductsIsLastPage = false;
        }
        emit(
          state.copyWith(
            getSpinnerFreeProductsState: state.getSpinnerFreeProductsState.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }

  Future<void> getSpinnerBuyOneGetOne(String type) async {
    spinnerBuyOneGetOnePageNumber = 1;
    emit(state.copyWith(getSpinnerBuyOneGetOneFree: state.getSpinnerBuyOneGetOneFree.asLoading()));
    final f = await spinnersRepo.getBuyOneGetOneFreeProducts(spinnerBuyOneGetOnePageNumber.toString(), type);
    f.fold(
      (l) => emit(
        state.copyWith(
          getSpinnerBuyOneGetOneFree: state.getSpinnerBuyOneGetOneFree.asLoadingFailed(l),
        ),
      ),
      (r) {
        spinnerBuyOneGetOnePageNumber = 2;
        if (r.length != 10) {
          spinnerBuyOneGetOneIsLastPage = true;
        } else {
          spinnerBuyOneGetOneIsLastPage = false;
        }
        emit(
          state.copyWith(
            getSpinnerBuyOneGetOneFree: state.getSpinnerBuyOneGetOneFree.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreSpinnerBuyOneGetOne(String type) async {
    if (state.getSpinnerBuyOneGetOneFree.loadingState.loading ||
        state.getSpinnerBuyOneGetOneFree.loadingState.reloading ||
        spinnerBuyOneGetOneIsLastPage) {
      return;
    }
    emit(state.copyWith(getSpinnerBuyOneGetOneFree: state.getSpinnerBuyOneGetOneFree.asReloading()));
    final f = await spinnersRepo.getBuyOneGetOneFreeProducts(spinnerBuyOneGetOnePageNumber.toString(), type);
    f.fold(
      (l) => emit(
        state.copyWith(
          getSpinnerBuyOneGetOneFree: state.getSpinnerBuyOneGetOneFree.asReloadingFailed(l),
        ),
      ),
      (r) {
        spinnerBuyOneGetOnePageNumber += 1;
        if (r.length != 10) {
          spinnerBuyOneGetOneIsLastPage = true;
        } else {
          spinnerBuyOneGetOneIsLastPage = false;
        }
        emit(
          state.copyWith(
            getSpinnerBuyOneGetOneFree: state.getSpinnerBuyOneGetOneFree.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }
}
