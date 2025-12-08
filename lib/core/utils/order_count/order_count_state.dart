import 'package:equatable/equatable.dart';

import '../data_utils.dart';

class OrderCountState extends Equatable {
  final int orderCount;

  const OrderCountState({
    this.orderCount = 0 ,
  });

  OrderCountState copyWith({
    int? orderCount,
    bool notificationNull = false,
  }) =>
      OrderCountState(
        orderCount: notificationNull ? validateInt(orderCount) : orderCount ?? this.orderCount,
      );


  @override
  List<Object?> get props => [orderCount];
}
