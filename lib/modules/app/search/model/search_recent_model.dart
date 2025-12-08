import 'package:equatable/equatable.dart';

import '../../products/models/product_model_api.dart';

class SearchRecentModel extends Equatable {
  final List<ProductModelApi> viewedProducts;
  final List<SearchedProductModel> searchedProducts;

  const SearchRecentModel({
    required this.viewedProducts,
    required this.searchedProducts,
  });

  factory SearchRecentModel.fromJson(Map<String, dynamic> json) {
    return SearchRecentModel(
      viewedProducts: (json['data']['viewed_products'] as List)
          .map((item) => ProductModelApi.fromJson(item))
          .toList(),
      searchedProducts: (json['data']['searched_products'] as List)
          .map((item) => SearchedProductModel.fromJson(item))
          .toList(),
    );
  }

  @override
  List<Object?> get props => [
    viewedProducts,
    searchedProducts,
  ];
}
class SearchedProductModel  extends Equatable {
  final int id;
  final String name;

  const SearchedProductModel({
    required this.id,
    required this.name,
  });

  factory SearchedProductModel.fromJson(Map<String, dynamic> json) {
    return SearchedProductModel(
      id: json['id'],
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
  ];
}

final List<SearchedProductModel> demoSearchedProducts = [
  SearchedProductModel(id: 1, name: 'Product A'),
  SearchedProductModel(id: 2, name: 'Product B'),
  SearchedProductModel(id: 3, name: 'Product C'),
];
