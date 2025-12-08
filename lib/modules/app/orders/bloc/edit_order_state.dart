import 'package:equatable/equatable.dart';
import '../../../../core/models/global_model/global_response_model.dart';
import '../../../../core/utils/states/loading_state.dart';
import '../models/order_detail_model.dart';

class EditOrderState extends Equatable {
  final CancelOrderState cancelOrderState;
  final UpdateOrderState updateOrderState;
  final GetOrderDetailsState getOrderDetailsState;
  final UpdateOrderDetailsState updateOrderDetailsState;
  final DeleteOrderProductState deleteOrderProductState;

  const EditOrderState({
    this.cancelOrderState = const CancelOrderState(),
    this.updateOrderState = const UpdateOrderState(),
    this.getOrderDetailsState = const GetOrderDetailsState(),
    this.updateOrderDetailsState = const UpdateOrderDetailsState(),
    this.deleteOrderProductState = const DeleteOrderProductState(),
  });

  EditOrderState copyWith({
    CancelOrderState? cancelOrderState,
    UpdateOrderState? updateOrderState,
    GetOrderDetailsState? getOrderDetailsState,
    UpdateOrderDetailsState? updateOrderDetailsState,
    DeleteOrderProductState? deleteOrderProductState,
  }) {
    return EditOrderState(
      cancelOrderState: cancelOrderState ?? this.cancelOrderState,
      updateOrderState: updateOrderState ?? this.updateOrderState,
      getOrderDetailsState: getOrderDetailsState ?? this.getOrderDetailsState,
      updateOrderDetailsState:
          updateOrderDetailsState ?? this.updateOrderDetailsState,
      deleteOrderProductState:
          deleteOrderProductState ?? this.deleteOrderProductState,
    );
  }

  @override
  List<Object?> get props => [
        cancelOrderState,
        updateOrderState,
        getOrderDetailsState,
        updateOrderDetailsState,
        deleteOrderProductState,
      ];
}

class CancelOrderState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? data;

  const CancelOrderState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  CancelOrderState asLoading() => const CancelOrderState(
        loadingState: LoadingState.loading(),
      );

  CancelOrderState asLoadingSuccess({
    bool? success,
    required GlobalResponseModel data,
  }) =>
      CancelOrderState(success: success, data: data);

  CancelOrderState asLoadingFailed(String error) => CancelOrderState(
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

class UpdateOrderState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? data;

  const UpdateOrderState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  UpdateOrderState asLoading() => const UpdateOrderState(
        loadingState: LoadingState.loading(),
      );

  UpdateOrderState asLoadingSuccess({
    bool? success,
    required GlobalResponseModel data,
  }) =>
      UpdateOrderState(success: success, data: data);

  UpdateOrderState asLoadingFailed(String error) => UpdateOrderState(
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

class GetOrderDetailsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final OrderDetailResponseModel? data;

  const GetOrderDetailsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  GetOrderDetailsState asLoading() => const GetOrderDetailsState(
        loadingState: LoadingState.loading(),
      );

  GetOrderDetailsState asLoadingSuccess({
    bool? success,
    required OrderDetailResponseModel data,
  }) =>
      GetOrderDetailsState(success: success, data: data);

  GetOrderDetailsState asLoadingFailed(String error) => GetOrderDetailsState(
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

class UpdateOrderDetailsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final OrderDetailResponseModel? data;

  const UpdateOrderDetailsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  UpdateOrderDetailsState asLoading() => const UpdateOrderDetailsState(
        loadingState: LoadingState.loading(),
      );

  UpdateOrderDetailsState asLoadingSuccess({
    bool? success,
    required OrderDetailResponseModel data,
  }) =>
      UpdateOrderDetailsState(success: success, data: data);

  UpdateOrderDetailsState asLoadingFailed(String error) =>
      UpdateOrderDetailsState(
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

class DeleteOrderProductState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final OrderDetailResponseModel? data;

  const DeleteOrderProductState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  DeleteOrderProductState asLoading() => const DeleteOrderProductState(
        loadingState: LoadingState.loading(),
      );

  DeleteOrderProductState asLoadingSuccess({
    bool? success,
    required OrderDetailResponseModel data,
  }) =>
      DeleteOrderProductState(success: success, data: data);

  DeleteOrderProductState asLoadingFailed(String error) =>
      DeleteOrderProductState(
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
