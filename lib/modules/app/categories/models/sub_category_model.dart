import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';
import '../../products/models/product_model_api.dart';

class SubCategoryModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;
  final bool is_featured;
  final List<ProductModelApi> products;

  const SubCategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.is_featured,
    required this.products,
  });

  SubCategoryModel copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    bool? is_featured,
    List<ProductModelApi>? products,
  }) {
    return SubCategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      is_featured: is_featured ?? this.is_featured,
      products: products ?? this.products,
    );
  }

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryModel(
      id: validateString(json['id']),
      name: validateString(json['name']),
      image: validateString(json['image']),
      description: validateString(json['description']),
      is_featured: validateBool(json['is_featured']),
      products: json['products'] != null
          ? validateJsonList(
        (json['products'] as List).cast<Map<String, dynamic>>(),
        ProductModelApi.fromJson,
      )
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'description': description,
      'is_featured': is_featured,
    };
  }

  @override
  List<Object?> get props => [
    id,
    name,
    image,
    description,
    is_featured,
    products,
  ];
}
