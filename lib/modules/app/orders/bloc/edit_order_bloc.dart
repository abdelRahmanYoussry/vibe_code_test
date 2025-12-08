import 'package:test_vibe/modules/app/orders/models/update_order_params.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../repo/orders_repo.dart';
import 'edit_order_state.dart';

class EditOrderBloc extends Cubit<EditOrderState> {
  EditOrderBloc({
    required this.ordersRepo,
  }) : super(const EditOrderState());

  final OrdersRepo ordersRepo;

  Future<void> getOrderDetails(int orderId) async {
    emit(state.copyWith(getOrderDetailsState: state.getOrderDetailsState.asLoading()));
    final result = await ordersRepo.getOrderDetails(orderId);
    result.fold(
      (error) => emit(
        state.copyWith(
          getOrderDetailsState: state.getOrderDetailsState.asLoadingFailed(error),
        ),
      ),
      (response) => emit(
        state.copyWith(
          getOrderDetailsState: state.getOrderDetailsState.asLoadingSuccess(data: response, success: true),
        ),
      ),
    );
  }

  Future<void> updateOrderDetails(int orderId, UpdateOrderParams params) async {
    emit(state.copyWith(updateOrderDetailsState: state.updateOrderDetailsState.asLoading()));
    final result = await ordersRepo.updateOrderDetails(orderId, params);
    result.fold(
      (error) => emit(
        state.copyWith(
          updateOrderDetailsState: state.updateOrderDetailsState.asLoadingFailed(error),
        ),
      ),
      (response) => emit(
        state.copyWith(
          updateOrderDetailsState: state.updateOrderDetailsState.asLoadingSuccess(data: response, success: true),
        ),
      ),
    );
    debugPrint('22222222222222222222222222222222222222222');
    eventBus.fire(GetUserOrdersEvent());
  }

  Future<void> deleteOrderProduct(int orderId, int productId) async {
    emit(state.copyWith(deleteOrderProductState: state.deleteOrderProductState.asLoading()));
    final result = await ordersRepo.deleteOrderProduct(orderId, productId);
    result.fold(
      (error) => emit(
        state.copyWith(
          deleteOrderProductState: state.deleteOrderProductState.asLoadingFailed(error),
        ),
      ),
      (response) => emit(
        state.copyWith(
          deleteOrderProductState: state.deleteOrderProductState.asLoadingSuccess(data: response, success: true),
        ),
      ),
    );
    // await  getOrderDetails(orderId);
    // eventBus.fire(GetUserOrdersEvent());
  }
}
