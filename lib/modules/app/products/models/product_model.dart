import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/models/currency_model.dart';
import 'package:test_vibe/core/models/price_model.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String name;
  final String type;
  final String desc;
  final PriceModel? price;
  final String image;
  final List<ProductCustomizationModel> customizations;

  const ProductModel({
    required this.id,
    required this.name,
    required this.type,
    required this.desc,
    required this.price,
    required this.image,
    required this.customizations,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: validateString(json['id']),
      name: validateString(json['name']),
      type: validateString(json['type']),
      desc: validateString(json['desc']),
      price: validateJson(json['price'], PriceModel.fromJson),
      image: validateString(json['image']),
      customizations: validateJsonList(json['customizations'], ProductCustomizationModel.fromJson),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        desc,
        price,
        image,
        customizations,
      ];
}

class ProductCustomizationModel extends Equatable {
  final String id;
  final String name;
  final List<ProductOptionModel> options;

  const ProductCustomizationModel({
    required this.id,
    required this.name,
    required this.options,
  });

  ProductCustomizationModel copyWith({
    String? id,
    String? name,
    List<ProductOptionModel>? options,
  }) {
    return ProductCustomizationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      options: options ?? this.options,
    );
  }

  factory ProductCustomizationModel.fromJson(Map<String, dynamic> json) {
    return ProductCustomizationModel(
      id: validateString(json['id']),
      name: validateString(json['name']),
      options: validateJsonList(json['options'], ProductOptionModel.fromJson),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        options,
      ];
}

class ProductOptionModel extends Equatable {
  final String id;
  final String name;
  final PriceModel? price;

  const ProductOptionModel({
    required this.id,
    required this.name,
    required this.price,
  });

  factory ProductOptionModel.fromJson(Map<String, dynamic> json) {
    return ProductOptionModel(
      id: validateString(json['id']),
      name: validateString(json['name']),
      price: validateJson(json['price'], PriceModel.fromJson),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        price,
      ];
}

final _customizations = [
  ProductCustomizationModel(
    id: '1',
    name: 'Sweetness Level',
    options: [
      ProductOptionModel(
        id: '1',
        name: 'Less Sweet',
        price: null,
      ),
      ProductOptionModel(
        id: '2',
        name: 'Normal',
        price: null,
      ),
      ProductOptionModel(
        id: '3',
        name: 'Extra Sweet ( AED 1.5 )',
        price: PriceModel(
          value: 1.5,
          label: 'AED 1.5',
          currency: demoCurrencies[0],
        ),
      ),
    ],
  ),
  ProductCustomizationModel(
    id: '2',
    name: 'Type Of Milk',
    options: [
      ProductOptionModel(
        id: '1',
        name: 'Normal Milk',
        price: null,
      ),
      ProductOptionModel(
        id: '2',
        name: 'Low Fat Milk',
        price: null,
      ),
      ProductOptionModel(
        id: '3',
        name: 'Oatly Milk ( AED 5.25 )',
        price: PriceModel(
          value: 5.25,
          label: 'AED 5.25',
          currency: demoCurrencies[0],
        ),
      ),
      ProductOptionModel(
        id: '4',
        name: 'Coconut Milk ( AED 5.25 )',
        price: PriceModel(
          value: 5.25,
          label: 'AED 5.25',
          currency: demoCurrencies[0],
        ),
      ),
      ProductOptionModel(
        id: '5',
        name: 'Almond Milk ( AED 5.25 )',
        price: PriceModel(
          value: 5.25,
          label: 'AED 5.25',
          currency: demoCurrencies[0],
        ),
      ),
      ProductOptionModel(
        id: '6',
        name: 'Lacto Free Milk ( AED 5.25 )',
        price: PriceModel(
          value: 5.25,
          label: 'AED 5.25',
          currency: demoCurrencies[0],
        ),
      ),
    ],
  ),
];

final demoProducts = [
  ProductModel(
    id: '1',
    name: 'Matcha Latte (Cold)',
    type: 'Ice Coffee',
    desc: 'A rich blend of Japanese matcha and creamy milk served iced for a refreshing and smooth taste',
    image: Assets.demo.productMatchaLatte.path,
    customizations: _customizations,
    price: PriceModel(
      value: 39.90,
      label: 'AED 39.90',
      currency: demoCurrencies[0],
    ),
  ),
  ProductModel(
    id: '2',
    name: 'Crème Matcha',
    type: 'Ice Coffee',
    desc: 'A rich blend of Japanese matcha and creamy milk served iced for a refreshing and smooth taste',
    image: Assets.demo.productCremeMatcha.path,
    customizations: _customizations,
    price: PriceModel(
      value: 39.90,
      label: 'AED 39.90',
      currency: demoCurrencies[0],
    ),
  ),
  ProductModel(
    id: '3',
    name: 'Hot Choco-Laro',
    type: 'Ice Coffee',
    desc: 'A rich blend of Japanese matcha and creamy milk served iced for a refreshing and smooth taste',
    image: Assets.demo.productHotChocoLaro.path,
    customizations: _customizations,
    price: PriceModel(
      value: 39.90,
      label: 'AED 39.90',
      currency: demoCurrencies[0],
    ),
  ),
  ProductModel(
    id: '4',
    name: 'Little Matcha',
    type: 'Ice Coffee',
    desc: 'A rich blend of Japanese matcha and creamy milk served iced for a refreshing and smooth taste',
    image: Assets.demo.productLittleMatcha.path,
    customizations: _customizations,
    price: PriceModel(
      value: 39.90,
      label: 'AED 39.90',
      currency: demoCurrencies[0],
    ),
  ),
  ProductModel(
    id: '5',
    name: 'Matcha Latte (Cold)',
    type: 'Ice Coffee',
    desc: 'An exquisite blend of Japanese matcha and creamy milk served iced for a refreshing and smooth taste',
    image: Assets.demo.productMatchaLatte.path,
    customizations: _customizations,
    price: PriceModel(
      value: 22.90,
      label: 'AED 22.90',
      currency: demoCurrencies[0],
    ),
  ),
];
