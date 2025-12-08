import 'package:equatable/equatable.dart';

import '../../../../core/utils/states/loading_state.dart';
import '../../products/models/product_model_api.dart';
import '../model/qr_reward_model.dart';
import '../model/rewards_model.dart';

class RewardsState extends Equatable {
  final RewardsProgressState rewardsProgressState;
  final RewardsQrState rewardsQrState;
  final GetRewardsFreeProductsState getRewardsFreeProductsState;

  copyWith({
    RewardsProgressState? rewardsProgressState,
    RewardsQrState? rewardsQrState,
    GetRewardsFreeProductsState? getRewardsFreeProductsState,
  }) {
    return RewardsState(
      rewardsProgressState: rewardsProgressState ?? this.rewardsProgressState,
      rewardsQrState: rewardsQrState ?? this.rewardsQrState,
      getRewardsFreeProductsState: getRewardsFreeProductsState ?? this.getRewardsFreeProductsState,
    );
  }

  const RewardsState({
    this.rewardsProgressState = const RewardsProgressState(),
    this.rewardsQrState = const RewardsQrState(),
    this.getRewardsFreeProductsState = const GetRewardsFreeProductsState(),
  });

  @override
  List<Object?> get props => [
        rewardsProgressState,
        rewardsQrState,
        getRewardsFreeProductsState,
      ];
}

class RewardsProgressState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final RewardsResponseModel? data;

  const RewardsProgressState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  RewardsProgressState asLoading() => const RewardsProgressState(
        loadingState: LoadingState.loading(),
      );

  RewardsProgressState asLoadingSuccess({bool? success, required RewardsResponseModel data}) =>
      RewardsProgressState(success: success, data: data);

  RewardsProgressState asLoadingFailed(String error) => RewardsProgressState(
        error: error,
      );

  @override
  List<Object?> get props => [
        success,
        loadingState,
        error,
        data,
      ];
}

class RewardsQrState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final QrRewardResponseModel? data;

  const RewardsQrState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  RewardsQrState asLoading() => const RewardsQrState(
        loadingState: LoadingState.loading(),
      );

  RewardsQrState asLoadingSuccess({bool? success, required QrRewardResponseModel data}) =>
      RewardsQrState(success: success, data: data);

  RewardsQrState asLoadingFailed(String error) => RewardsQrState(
        error: error,
      );

  @override
  List<Object?> get props => [
        success,
        loadingState,
        error,
        data,
      ];
}


class GetRewardsFreeProductsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<ProductModelApi> data;

  const GetRewardsFreeProductsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data= const [],
  });

  GetRewardsFreeProductsState asLoading() => const GetRewardsFreeProductsState(
    loadingState: LoadingState.loading(),
  );

  GetRewardsFreeProductsState asLoadingSuccess({
    bool? success,
    required List<ProductModelApi> data,
  }) =>
      GetRewardsFreeProductsState(success: success, data: data);

  GetRewardsFreeProductsState asLoadingFailed(String error) => GetRewardsFreeProductsState(
    error: error,
  );

  GetRewardsFreeProductsState asReloading() => GetRewardsFreeProductsState(
    loadingState: const LoadingState.reloading(),
    data: data,
    error: error,
  );
  GetRewardsFreeProductsState asLoadingMoreSuccess(List<ProductModelApi> data) => GetRewardsFreeProductsState(
    data: [...this.data, ...data],
  );
  GetRewardsFreeProductsState asReloadingSuccess(List<ProductModelApi> data) => GetRewardsFreeProductsState(
    data: data,
  );

  GetRewardsFreeProductsState asReloadingFailed(String error) => GetRewardsFreeProductsState(
    data: data,
    error: error,
  );

  @override
  List<Object?> get props => [
    success,
    loadingState,
    error,
    data,
  ];
}
