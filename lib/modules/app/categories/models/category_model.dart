import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String image;
  final bool is_featured;

  const CategoryModel({
    required this.id,
    required this.name,
    required this.image,
    required this.description,
    required this.is_featured,
  });

  CategoryModel copyWith({
    String? id,
    String? name,
    String? image,
    String? description,
    bool? is_featured,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      description: description ?? this.description,
      is_featured: is_featured ?? this.is_featured,
    );
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: validateString(json['id']),
      name: validateString(json['name']),
      image: validateString(json['image']),
      description: validateString(json['description']),
      is_featured: validateBool(json['is_featured']),
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
      ];
}
