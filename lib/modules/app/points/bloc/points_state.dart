import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/states/loading_state.dart';
import '../models/point_model_new.dart';
import '../models/wallet_balance_model.dart';

class PointsState extends Equatable {
  final GetHistoryPointsState getHistoryPoints;
  final GetPointsState getPointsState;
  final TransferPointsState transferPointsState;

  copyWith({
    GetHistoryPointsState? getHistoryPoints,
    GetPointsState? getPointsState,
    TransferPointsState? transferPointsState,
  }) {
    return PointsState(
      getHistoryPoints: getHistoryPoints ?? this.getHistoryPoints,
      getPointsState: getPointsState ?? this.getPointsState,
      transferPointsState: transferPointsState ?? this.transferPointsState,
    );
  }

  const PointsState({
    this.getHistoryPoints = const GetHistoryPointsState(),
    this.getPointsState = const GetPointsState(),
    this.transferPointsState = const TransferPointsState(),
  });

  @override
  List<Object?> get props => [
        getHistoryPoints,
        getPointsState,
        transferPointsState,
      ];
}

class GetHistoryPointsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final PointsResponse? data;

  const GetHistoryPointsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  GetHistoryPointsState asLoading() => const GetHistoryPointsState(
        loadingState: LoadingState.loading(),
      );

  GetHistoryPointsState asLoadingSuccess({
    bool? success,
    PointsResponse? data,
  }) =>
      GetHistoryPointsState(success: success, data: data);

  GetHistoryPointsState asLoadingFailed(String error) => GetHistoryPointsState(
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

class GetPointsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final PointsWalletData? data;

  const GetPointsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  GetPointsState asLoading() => const GetPointsState(
        loadingState: LoadingState.loading(),
      );

  GetPointsState asLoadingSuccess({
    bool? success,
    PointsWalletData? data,
  }) =>
      GetPointsState(success: success, data: data);

  GetPointsState asLoadingFailed(String error) => GetPointsState(
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

class TransferPointsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? data;

  const TransferPointsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  TransferPointsState asLoading() => const TransferPointsState(
        loadingState: LoadingState.loading(),
      );

  TransferPointsState asLoadingSuccess({
    bool? success,
    GlobalResponseModel? data,
  }) =>
      TransferPointsState(success: success, data: data);

  TransferPointsState asLoadingFailed(String error) => TransferPointsState(
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
