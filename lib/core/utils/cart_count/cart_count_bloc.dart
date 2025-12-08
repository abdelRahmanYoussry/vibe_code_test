import 'package:test_vibe/modules/app/cart/repo/add_to_cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../di/di.dart';
import 'cart_count_state.dart';

class CartCountBloc extends Cubit<CartCountState> {
  CartCountBloc._(this.addToCartRepo) : super(const CartCountState());
  final AddToCartRepo addToCartRepo;

  factory CartCountBloc() {
    if (!di.isRegistered<CartCountBloc>()) {
      di.registerSingleton<CartCountBloc>(CartCountBloc._(di()));
    }
    return di<CartCountBloc>();
  }

  @override
  Future<void> close() {
    di.unregister<CartCountBloc>();
    return super.close();
  }

  setData(int cartCount) {
    emit(state.copyWith(cartCount: cartCount));
  }
  getCartCount() =>addToCartRepo.getCart();

  clear() => emit(state.copyWith(notificationNull: true));
}
