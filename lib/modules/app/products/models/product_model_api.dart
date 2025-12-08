import 'package:equatable/equatable.dart';

import '../../../../core/utils/data_utils.dart';

class ProductModelApi extends Equatable {
  final String id;
  final String name;
  final String sku;
  final int? viewsCount;
  final String description;
  final String slug;
  final bool isOutOfStock;
  final String stockStatusLabel;
  final double price;
  final String final_price;
  final String tax_price;
  final double original_price;
  final String formattedPrice;
  final String? imageUrl;
  final String? media;
  final String? type;
  final List<ProductImageModel> images;
  final List<ProductVariationModel> variations;
  final List<ProductOptionApiModel> productOptions;

  const ProductModelApi({
    required this.id,
    required this.name,
    required this.sku,
    this.viewsCount,
    required this.description,
    required this.slug,
    required this.isOutOfStock,
    required this.stockStatusLabel,
    required this.price,
    required this.formattedPrice,
    required this.final_price,
    this.imageUrl,
    this.media,
    this.type,
    required this.images,
    required this.variations,
    required this.productOptions,
    required this.tax_price,
    required this.original_price,
  });

  factory ProductModelApi.fromJson(Map<String, dynamic> json) {
    return ProductModelApi(
      id: validateString(json['id']),
      name: validateString(json['name']),
      sku: validateString(json['sku']),
      viewsCount: validateInt(json['views_count']),
      description: validateString(json['description']),
      final_price: validateString(json['final_price']),
      slug: validateString(json['slug']),
      isOutOfStock: validateBool(json['is_out_of_stock']),
      stockStatusLabel: validateString(json['stock_status_label']),
      tax_price: validateString(json['tax_price']),
      original_price: validateDouble(json['original_price']),
      price: validateDouble(json['price']),
      formattedPrice: validateString(json['formatted_price']),
      imageUrl: validateString(json['image_url']?['url']),
      media: validateString(json['media']),
      type: validateString(json['type']),
      images: validateJsonList(json['images'], ProductImageModel.fromJson),
      variations: validateJsonList(json['variations'], ProductVariationModel.fromJson),
      productOptions: validateJsonList(json['product_options'], ProductOptionApiModel.fromJson),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        sku,
        viewsCount,
        description,
        slug,
        isOutOfStock,
        stockStatusLabel,
        price,
        formattedPrice,
        imageUrl,
        images,
        variations,
        productOptions,
        final_price,
        tax_price,
        original_price,
        media,
        type,
      ];
}

class ProductImageModel extends Equatable {
  final String name;
  final String url;

  const ProductImageModel({
    required this.name,
    required this.url,
  });

  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      name: validateString(json['name']),
      url: validateString(json['url']),
    );
  }

  @override
  List<Object?> get props => [name, url];
}

class ProductVariationModel extends Equatable {
  final String id;
  final String name;
  final String? sku;
  final String variationAttributes;
  final List<ProductOptionApiModel> productOptions;

  const ProductVariationModel({
    required this.id,
    required this.name,
    this.sku,
    required this.variationAttributes,
    required this.productOptions,
  });

  factory ProductVariationModel.fromJson(Map<String, dynamic> json) {
    return ProductVariationModel(
      id: validateString(json['id']),
      name: validateString(json['name']),
      sku: validateString(json['sku']),
      variationAttributes: validateString(json['variation_attributes']),
      productOptions: validateJsonList(json['product_options'], ProductOptionApiModel.fromJson),
    );
  }

  @override
  List<Object?> get props => [id, name, sku, variationAttributes, productOptions];
}

class ProductOptionApiModel extends Equatable {
  final String id;
  final String name;
  final int order;
  final bool required;
  final String optionType;
  final List<ProductOptionValueModel> values;

  const ProductOptionApiModel({
    required this.id,
    required this.name,
    required this.order,
    required this.required,
    required this.optionType,
    required this.values,
  });

  factory ProductOptionApiModel.fromJson(Map<String, dynamic> json) {
    return ProductOptionApiModel(
      id: validateString(json['id']),
      name: validateString(json['name']),
      order: validateInt(json['order']),
      required: validateBool(json['required']),
      optionType: validateString(json['option_type']),
      values: validateJsonList(json['values'], ProductOptionValueModel.fromJson),
    );
  }

  @override
  List<Object?> get props => [id, name, order, required, optionType, values];
}

class ProductOptionValueModel extends Equatable {
  final String id;
  final String name;
  final String optionValue;
  final int order;
  final int affectType;
  final double affectPrice;
  final String title;
  final String formatPrice;

  const ProductOptionValueModel({
    required this.id,
    required this.name,
    required this.optionValue,
    required this.order,
    required this.affectType,
    required this.affectPrice,
    required this.title,
    required this.formatPrice,
  });

  factory ProductOptionValueModel.fromJson(Map<String, dynamic> json) {
    return ProductOptionValueModel(
      id: validateString(json['id']),
      name: validateString(json['name']),
      optionValue: validateString(json['option_value']),
      order: validateInt(json['order']),
      affectType: validateInt(json['affect_type']),
      affectPrice: validateDouble(json['affect_price']),
      title: validateString(json['title']),
      formatPrice: validateString(json['format_price']),
    );
  }

  @override
  List<Object?> get props => [id, name, optionValue, order, affectType, affectPrice, title, formatPrice];
}

final demoApiProducts = [
  ProductModelApi(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 10.0,
    images: [],
    variations: [],
    productOptions: [],
    sku: 'SKU1',
    viewsCount: 100,
    slug: 'product-1',
    isOutOfStock: false,
    stockStatusLabel: 'In Stock',
    formattedPrice: '\$10.00',
    final_price: '\$10.00',
    tax_price: '\$1.00',
    original_price: 10.0,
    imageUrl: 'https://coffe-driver.algoriza.com/storage/lavender-oat-cold-brew-latte-4-1067x1600-150x150.jpg',
  ),
  ProductModelApi(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 10.0,
    images: [],
    variations: [],
    productOptions: [],
    sku: 'SKU1',
    viewsCount: 100,
    slug: 'product-1',
    isOutOfStock: false,
    stockStatusLabel: 'In Stock',
    formattedPrice: '\$10.00',
    final_price: '\$10.00',
    tax_price: '\$1.00',
    original_price: 10.0,
    imageUrl: 'https://coffe-driver.algoriza.com/storage/lavender-oat-cold-brew-latte-4-1067x1600-150x150.jpg',
  ),
  ProductModelApi(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 10.0,
    images: [],
    variations: [],
    productOptions: [],
    sku: 'SKU1',
    viewsCount: 100,
    slug: 'product-1',
    isOutOfStock: false,
    stockStatusLabel: 'In Stock',
    formattedPrice: '\$10.00',
    final_price: '\$10.00',
    tax_price: '\$1.00',
    original_price: 10.0,
    imageUrl: 'https://coffe-driver.algoriza.com/storage/lavender-oat-cold-brew-latte-4-1067x1600-150x150.jpg',
  ),
  ProductModelApi(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 10.0,
    images: [],
    variations: [],
    productOptions: [],
    sku: 'SKU1',
    viewsCount: 100,
    slug: 'product-1',
    isOutOfStock: false,
    stockStatusLabel: 'In Stock',
    formattedPrice: '\$10.00',
    final_price: '\$10.00',
    tax_price: '\$1.00',
    original_price: 10.0,
    imageUrl: 'https://coffe-driver.algoriza.com/storage/lavender-oat-cold-brew-latte-4-1067x1600-150x150.jpg',
  ),
  ProductModelApi(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 10.0,
    images: [],
    variations: [],
    productOptions: [],
    sku: 'SKU1',
    viewsCount: 100,
    slug: 'product-1',
    isOutOfStock: false,
    stockStatusLabel: 'In Stock',
    formattedPrice: '\$10.00',
    final_price: '\$10.00',
    tax_price: '\$1.00',
    original_price: 10.0,
    imageUrl: 'https://coffe-driver.algoriza.com/storage/lavender-oat-cold-brew-latte-4-1067x1600-150x150.jpg',
  ),
];
