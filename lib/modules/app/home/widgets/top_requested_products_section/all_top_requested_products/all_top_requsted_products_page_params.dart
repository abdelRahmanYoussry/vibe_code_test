import 'package:test_vibe/modules/app/products/bloc/products_bloc.dart';
import 'package:equatable/equatable.dart';

class AllTopRequestedProductsPageParams extends Equatable {
  final String title;
  final ProductsBloc bloc;

  const AllTopRequestedProductsPageParams({required this.title, required this.bloc});

  @override
  List<Object?> get props => [
        title,
        bloc,
      ];
}
