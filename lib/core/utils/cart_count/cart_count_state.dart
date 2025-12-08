import 'package:equatable/equatable.dart';

import '../data_utils.dart';

class CartCountState extends Equatable {
  final int cartCount;

  const CartCountState({
    this.cartCount = 0 ,
  });

  CartCountState copyWith({
    int? cartCount,
    bool notificationNull = false,
  }) =>
      CartCountState(
        cartCount: notificationNull ? validateInt(cartCount) : cartCount ?? this.cartCount,
      );


  @override
  List<Object?> get props => [cartCount];
}
