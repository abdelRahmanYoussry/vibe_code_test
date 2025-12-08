import 'package:equatable/equatable.dart';
import '../../../../core/utils/states/loading_state.dart';
import '../../products/models/product_model_api.dart';
import '../models/spinner_model_new.dart';
import '../models/spinner_reward_model.dart';

class SpinnersState extends Equatable {
  final GetAllSpinnersState getAllSpinnersState;
  final SpinTheWheelState spinTheWheelState;
  final GetSpinnerFreeProductsState getSpinnerFreeProductsState;
  final GetSpinnerBuyOneGetOneFree getSpinnerBuyOneGetOneFree;

  copyWith({
    GetAllSpinnersState? getAllSpinnersState,
    SpinTheWheelState? spinTheWheelState,
    GetSpinnerFreeProductsState? getSpinnerFreeProductsState,
    GetSpinnerBuyOneGetOneFree? getSpinnerBuyOneGetOneFree,
  }) {
    return SpinnersState(
      getAllSpinnersState: getAllSpinnersState ?? this.getAllSpinnersState,
      spinTheWheelState: spinTheWheelState ?? this.spinTheWheelState,
      getSpinnerFreeProductsState: getSpinnerFreeProductsState ?? this.getSpinnerFreeProductsState,
      getSpinnerBuyOneGetOneFree: getSpinnerBuyOneGetOneFree ?? this.getSpinnerBuyOneGetOneFree,
    );
  }

  const SpinnersState({
    this.getAllSpinnersState = const GetAllSpinnersState(),
    this.spinTheWheelState = const SpinTheWheelState(),
    this.getSpinnerFreeProductsState = const GetSpinnerFreeProductsState(),
    this.getSpinnerBuyOneGetOneFree = const GetSpinnerBuyOneGetOneFree(),
  });

  @override
  List<Object?> get props => [
        getAllSpinnersState,
        spinTheWheelState,
        getSpinnerFreeProductsState,
        getSpinnerBuyOneGetOneFree,
      ];
}

class GetAllSpinnersState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<SpinnerModel> data;

  const GetAllSpinnersState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data = const [],
  });

  GetAllSpinnersState asLoading() => const GetAllSpinnersState(
        loadingState: LoadingState.loading(),
      );

  GetAllSpinnersState asLoadingSuccess({bool? success, required List<SpinnerModel> data}) =>
      GetAllSpinnersState(success: success, data: data);

  GetAllSpinnersState asLoadingFailed(String error) => GetAllSpinnersState(
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

class SpinTheWheelState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final SpinnerRewardResult? data;

  const SpinTheWheelState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  SpinTheWheelState asLoading() => const SpinTheWheelState(
        loadingState: LoadingState.loading(),
      );

  SpinTheWheelState asLoadingSuccess({bool? success, SpinnerRewardResult? data}) =>
      SpinTheWheelState(success: success, data: data);

  SpinTheWheelState asLoadingFailed(String error) => SpinTheWheelState(
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

class GetSpinnerFreeProductsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<ProductModelApi> data;

  const GetSpinnerFreeProductsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data = const [],
  });

  GetSpinnerFreeProductsState asLoading() => const GetSpinnerFreeProductsState(
        loadingState: LoadingState.loading(),
      );

  GetSpinnerFreeProductsState asLoadingSuccess({
    bool? success,
    required List<ProductModelApi> data,
  }) =>
      GetSpinnerFreeProductsState(success: success, data: data);

  GetSpinnerFreeProductsState asLoadingFailed(String error) => GetSpinnerFreeProductsState(
        error: error,
      );

  GetSpinnerFreeProductsState asReloading() => GetSpinnerFreeProductsState(
        loadingState: const LoadingState.reloading(),
        data: data,
        error: error,
      );

  GetSpinnerFreeProductsState asLoadingMoreSuccess(List<ProductModelApi> data) => GetSpinnerFreeProductsState(
        data: [...this.data, ...data],
      );

  GetSpinnerFreeProductsState asReloadingSuccess(List<ProductModelApi> data) => GetSpinnerFreeProductsState(
        data: data,
      );

  GetSpinnerFreeProductsState asReloadingFailed(String error) => GetSpinnerFreeProductsState(
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

class GetSpinnerBuyOneGetOneFree extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<ProductModelApi> data;

  const GetSpinnerBuyOneGetOneFree({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data = const [],
  });

  GetSpinnerBuyOneGetOneFree asLoading() => const GetSpinnerBuyOneGetOneFree(
        loadingState: LoadingState.loading(),
      );

  GetSpinnerBuyOneGetOneFree asLoadingSuccess({
    bool? success,
    required List<ProductModelApi> data,
  }) =>
      GetSpinnerBuyOneGetOneFree(success: success, data: data);

  GetSpinnerBuyOneGetOneFree asLoadingFailed(String error) => GetSpinnerBuyOneGetOneFree(
        error: error,
      );

  GetSpinnerBuyOneGetOneFree asReloading() => GetSpinnerBuyOneGetOneFree(
        loadingState: const LoadingState.reloading(),
        data: data,
        error: error,
      );

  GetSpinnerBuyOneGetOneFree asLoadingMoreSuccess(List<ProductModelApi> data) => GetSpinnerBuyOneGetOneFree(
        data: [...this.data, ...data],
      );

  GetSpinnerBuyOneGetOneFree asReloadingSuccess(List<ProductModelApi> data) => GetSpinnerBuyOneGetOneFree(
        data: data,
      );

  GetSpinnerBuyOneGetOneFree asReloadingFailed(String error) => GetSpinnerBuyOneGetOneFree(
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
