import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/cart_count/cart_count_bloc.dart';
import '../../utils/cart_count/cart_count_state.dart';

class CartSelector extends StatelessWidget {
  const CartSelector({super.key, required this.builder});
  final Widget Function(BuildContext context, int cartCount) builder;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CartCountBloc, CartCountState, int>(
        bloc: CartCountBloc(),
        selector: (state) => state.cartCount,
        builder: (context, cartCount)=> builder(context,cartCount),);
  }
}
