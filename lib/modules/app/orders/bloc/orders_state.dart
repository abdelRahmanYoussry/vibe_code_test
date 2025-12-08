import 'package:test_vibe/modules/app/orders/models/order_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/models/global_model/global_response_model.dart';
import '../../../../core/utils/states/loading_state.dart';
import '../models/track_order_model.dart';

class OrdersState extends Equatable {
  final GetOrdersState getOrdersState;
  final GetTrackOrderState getTrackOrderState;
  final AddMinutesToOrderState addMinutesToOrderState;
  final DeleteOrderState deleteOrderState;
  final int? deletingOrderId; // Add this
  copyWith({
    GetOrdersState? getOrdersState,
    GetTrackOrderState? getTrackOrderState,
    AddMinutesToOrderState? addMinutesToOrderState,
    DeleteOrderState? deleteOrderState,
    int? deletingOrderId,
  }) {
    return OrdersState(
      getOrdersState: getOrdersState ?? this.getOrdersState,
      getTrackOrderState: getTrackOrderState ?? this.getTrackOrderState,
      addMinutesToOrderState: addMinutesToOrderState ?? this.addMinutesToOrderState,
      deleteOrderState: deleteOrderState ?? this.deleteOrderState,
      deletingOrderId: deletingOrderId ?? this.deletingOrderId,
    );
  }

  const OrdersState({
    this.getOrdersState = const GetOrdersState(),
    this.getTrackOrderState = const GetTrackOrderState(),
    this.addMinutesToOrderState = const AddMinutesToOrderState(),
    this.deleteOrderState = const DeleteOrderState(),
    this.deletingOrderId,
  });

  @override
  List<Object?> get props => [
        getOrdersState,
        getTrackOrderState,
        addMinutesToOrderState,
        deleteOrderState,
        deletingOrderId,
      ];
}

class GetOrdersState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final List<OrderModel> data;

  const GetOrdersState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data = const [],
  });

  GetOrdersState asLoading() => const GetOrdersState(
        loadingState: LoadingState.loading(),
      );

  GetOrdersState asLoadingSuccess({
    bool? success,
    required List<OrderModel> data,
  }) =>
      GetOrdersState(success: success, data: data);

  GetOrdersState asLoadingFailed(String error) => GetOrdersState(
        error: error,
      );

  GetOrdersState asReloading() => GetOrdersState(
        loadingState: const LoadingState.reloading(),
        data: data,
        error: error,
      );

  GetOrdersState asLoadingMoreSuccess(List<OrderModel> data) => GetOrdersState(
        data: [...this.data, ...data],
      );

  GetOrdersState asReloadingSuccess(List<OrderModel> data) => GetOrdersState(
        data: data,
      );

  GetOrdersState asReloadingFailed(String error) => GetOrdersState(
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

class GetTrackOrderState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final TrackOrderModel? data;

  const GetTrackOrderState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  GetTrackOrderState asLoading() => const GetTrackOrderState(
        loadingState: LoadingState.loading(),
      );

  GetTrackOrderState asLoadingSuccess({
    bool? success,
    required TrackOrderModel data,
  }) =>
      GetTrackOrderState(success: success, data: data);

  GetTrackOrderState asLoadingFailed(String error) => GetTrackOrderState(
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

class AddMinutesToOrderState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? data;

  const AddMinutesToOrderState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  AddMinutesToOrderState asLoading() => const AddMinutesToOrderState(
        loadingState: LoadingState.loading(),
      );

  AddMinutesToOrderState asLoadingSuccess({
    bool? success,
    required GlobalResponseModel data,
  }) =>
      AddMinutesToOrderState(success: success, data: data);

  AddMinutesToOrderState asLoadingFailed(String error) => AddMinutesToOrderState(
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

class DeleteOrderState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? data;

  const DeleteOrderState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });

  DeleteOrderState asLoading() => const DeleteOrderState(
        loadingState: LoadingState.loading(),
      );

  DeleteOrderState asLoadingSuccess({
    bool? success,
    required GlobalResponseModel data,
  }) =>
      DeleteOrderState(success: success, data: data);

  DeleteOrderState asLoadingFailed(String error) => DeleteOrderState(
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
