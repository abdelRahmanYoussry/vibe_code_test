import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_bloc.dart';
import 'package:equatable/equatable.dart';


class AddCommentParams extends Equatable {
  final AddToCartBloc bloc;
  final int productId;

  const AddCommentParams({
    required this.productId,
    required this.bloc,
  });

  @override
  List<Object?> get props => [
        bloc,
        productId,
      ];
}
