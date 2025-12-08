import 'package:test_vibe/modules/app/orders/repo/orders_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/di.dart';
import 'order_count_state.dart';

class OrderCountBloc extends Cubit<OrderCountState> {
  OrderCountBloc._(this.ordersRepo) : super(const OrderCountState());
  final OrdersRepo ordersRepo;

  factory OrderCountBloc() {
    if (!di.isRegistered<OrderCountBloc>()) {
      di.registerSingleton<OrderCountBloc>(OrderCountBloc._(di()));
    }
    return di<OrderCountBloc>();
  }

  @override
  Future<void> close() {
    di.unregister<OrderCountBloc>();
    return super.close();
  }

  setData(int orderCount) {
    emit(state.copyWith(orderCount: orderCount));
  }
  getOrdersCount() =>ordersRepo.getOrders('1', 'active');

  clear() => emit(state.copyWith(notificationNull: true));
}
