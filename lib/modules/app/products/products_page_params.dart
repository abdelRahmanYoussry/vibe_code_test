import 'package:test_vibe/modules/app/products/models/product_model_api.dart';
import 'package:equatable/equatable.dart';

class ProductsPageParams extends Equatable {
  final String title;
  final List<ProductModelApi> models;

  const ProductsPageParams({required this.title, required this.models});

  @override
  List<Object?> get props => [
        title,
        models,
      ];
}
