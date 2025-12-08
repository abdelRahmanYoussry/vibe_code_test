import 'package:test_vibe/core/utils/order_count/order_count_bloc.dart';
import 'package:test_vibe/core/utils/order_count/order_count_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class OrdersSelector extends StatelessWidget {
  const OrdersSelector({super.key, required this.builder});
  final Widget Function(BuildContext context, int orderCount) builder;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OrderCountBloc, OrderCountState, int>(
      bloc: OrderCountBloc(),
      selector: (state) => state.orderCount,
      builder: (context, orderCount)=> builder(context,orderCount),);
  }
}
