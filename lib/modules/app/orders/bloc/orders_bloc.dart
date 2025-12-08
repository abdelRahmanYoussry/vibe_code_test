import 'package:test_vibe/modules/app/orders/repo/orders_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import '../../../../core/utils/remote/api_helper.dart';
import 'orders_state.dart';

class OrdersBloc extends Cubit<OrdersState> {
  OrdersBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.ordersRepo,
  }) : super(const OrdersState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final OrdersRepo ordersRepo;

  int ordersPageNumber = 1;
  bool ordersIsLastPage = false;

  Future<void> getOrders(String type) async {
    ordersPageNumber = 1;
    emit(state.copyWith(getOrdersState: state.getOrdersState.asLoading()));
    final f = await ordersRepo.getOrders(ordersPageNumber.toString(), type);
    f.fold(
      (l) => emit(
        state.copyWith(
          getOrdersState: state.getOrdersState.asLoadingFailed(l),
        ),
      ),
      (r) {
        ordersPageNumber = 2;
        if (r.orders.length != 10) {
          ordersIsLastPage = true;
        } else {
          ordersIsLastPage = false;
        }
        emit(
          state.copyWith(
            getOrdersState: state.getOrdersState.asLoadingSuccess(data: r.orders, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreOrders(String type) async {
    if (state.getOrdersState.loadingState.loading || state.getOrdersState.loadingState.reloading || ordersIsLastPage) {
      return;
    }
    emit(state.copyWith(getOrdersState: state.getOrdersState.asReloading()));
    final f = await ordersRepo.getOrders(ordersPageNumber.toString(), type);
    f.fold(
      (l) => emit(
        state.copyWith(
          getOrdersState: state.getOrdersState.asReloadingFailed(l),
        ),
      ),
      (r) {
        ordersPageNumber += 1;
        if (r.orders.length != 10) {
          ordersIsLastPage = true;
        } else {
          ordersIsLastPage = false;
        }
        emit(
          state.copyWith(
            getOrdersState: state.getOrdersState.asLoadingMoreSuccess(r.orders),
          ),
        );
      },
    );
  }

  Future<void> getTrackOrder() async {
    emit(state.copyWith(getTrackOrderState: state.getTrackOrderState.asLoading()));
    final result = await ordersRepo.getTrackOrder();
    result.fold(
      (l) => emit(
        state.copyWith(
          getTrackOrderState: state.getTrackOrderState.asLoadingFailed(l),
        ),
      ),
      (r) => emit(
        state.copyWith(
          getTrackOrderState: state.getTrackOrderState.asLoadingSuccess(data: r,success: true),
        ),
      ),
    );
  }

  Future<void> addMinutesToOrder(int minutes) async {
    emit(state.copyWith(addMinutesToOrderState: state.addMinutesToOrderState.asLoading()));
    final result = await ordersRepo.addMinutesToOrder(minutes);
    result.fold(
      (l) => emit(
        state.copyWith(
          addMinutesToOrderState: state.addMinutesToOrderState.asLoadingFailed(l),
        ),
      ),
      (r) async {
        emit(
        state.copyWith(
          addMinutesToOrderState: state.addMinutesToOrderState.asLoadingSuccess(data: r, success: true),
        ),
      );
        await getTrackOrder();
      },
    );
  }

  Future<void> deleteOrder(int orderId) async {
    emit(state.copyWith(deleteOrderState: state.deleteOrderState.asLoading(),deletingOrderId: orderId));
    final result = await ordersRepo.deleteOrder( orderId);
    result.fold(
      (l) => emit(
        state.copyWith(
          deleteOrderState: state.deleteOrderState.asLoadingFailed(l),
          deletingOrderId: null,
        ),
      ),
      (r) async {
        emit(
        state.copyWith(
          deleteOrderState: state.deleteOrderState.asLoadingSuccess(data: r, success: true),
          deletingOrderId: null,
        ),
      );
        await getTrackOrder();
        await getOrders('active');
        eventBus.fire(GetUserOrdersEvent());
      },
    );
  }
}
