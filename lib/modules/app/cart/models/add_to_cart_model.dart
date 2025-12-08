import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class AddToCartResponseModel extends Equatable {
  final bool error;
  final AddToCartDataModel ?  data;
  final String message;

  const AddToCartResponseModel({
    required this.error,
     this.data,
    required this.message,
  });

  AddToCartResponseModel copyWith({
    bool? error,
    AddToCartDataModel? data,
    String? message,
  }) {
    return AddToCartResponseModel(
      error: error ?? this.error,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  factory AddToCartResponseModel.fromJson(Map<String, dynamic> json) {
    return AddToCartResponseModel(
      error: validateBool(json['error']),
      data: json['data'] !=null? AddToCartDataModel.fromJson(json['data']):null,
      message: validateString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'data': data?.toJson(),
      'message': message,
    };
  }

  @override
  List<Object?> get props => [error, data, message];
}

class AddToCartDataModel extends Equatable {
  final int count;
  final String totalPrice;
  final String subTotalPrice;
  final String? discount;
  final String taxes;
  final String? optionPrice;
  final Map<String, CartItemModel> content;
  final dynamic cartContent;
  final bool status;

  const AddToCartDataModel({
    required this.count,
    required this.totalPrice,
    required this.content,
    required this.subTotalPrice,
    this.discount,
    required this.taxes,
    this.cartContent,
    required this.status,
    this.optionPrice,
  });

  AddToCartDataModel copyWith({
    int? count,
    String? totalPrice,
    Map<String, CartItemModel>? content,
    dynamic cartContent,
    bool? status,
    String? subTotalPrice,
    String? discount,
    String? taxes,
    String? optionPrice,
  }) {
    return AddToCartDataModel(
      count: count ?? this.count,
      totalPrice: totalPrice ?? this.totalPrice,
      content: content ?? this.content,
      cartContent: cartContent ?? this.cartContent,
      status: status ?? this.status,
      subTotalPrice: subTotalPrice ?? this.subTotalPrice,
      discount: discount ?? this.discount,
      taxes: taxes ?? this.taxes,
      optionPrice: optionPrice ?? this.optionPrice,
    );
  }

  factory AddToCartDataModel.fromJson(Map<String, dynamic> json) {
    Map<String, CartItemModel> contentMap = {};
    if (json['content'] != null) {
      if (json['content'] is Map) {
        json['content'].forEach((key, value) {
          contentMap[key] = CartItemModel.fromJson(value);
        });
      }
    }

    return AddToCartDataModel(
      count: json['count'] ?? 0,
      totalPrice: validateString(json['total_price']),
      content: contentMap,
      cartContent: json['cart_content'],
      status: validateBool(json['status']),
      subTotalPrice: validateString(json['sub_total']),
      discount: validateString(json['discount']),
      taxes: validateString(json['taxes']),
      optionPrice: validateString(json['option_price']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> contentMap = {};
    content.forEach((key, value) {
      contentMap[key] = value.toJson();
    });

    return {
      'count': count,
      'total_price': totalPrice,
      'content': contentMap,
      'cart_content': cartContent,
      'status': status,
      'sub_total': subTotalPrice,
      'discount': discount,
      'taxes': taxes,
      'option_price': optionPrice,
    };
  }

  @override
  List<Object?> get props => [
        count,
        totalPrice,
        content,
        cartContent,
        status,
        subTotalPrice,
        discount,
        taxes,
        optionPrice,
      ];
}

class CartItemModel extends Equatable {
  final String rowId;
  final int id;
  final String name;
  final int qty;
  final double price;
  final CartItemOptionsModel options;
  final String tax;
  final String subtotal;
  final String updatedAt;

  const CartItemModel({
    required this.rowId,
    required this.id,
    required this.name,
    required this.qty,
    required this.price,
    required this.options,
    required this.tax,
    required this.subtotal,
    required this.updatedAt,
  });

  CartItemModel copyWith({
    String? rowId,
    int? id,
    String? name,
    int? qty,
    double? price,
    CartItemOptionsModel? options,
    String? tax,
    String? subtotal,
    String? updatedAt,
  }) {
    return CartItemModel(
      rowId: rowId ?? this.rowId,
      id: id ?? this.id,
      name: name ?? this.name,
      qty: qty ?? this.qty,
      price: price ?? this.price,
      options: options ?? this.options,
      tax: tax ?? this.tax,
      subtotal: subtotal ?? this.subtotal,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      rowId: validateString(json['rowId']),
      id: json['id'],
      name: validateString(json['name']),
      qty: json['qty'],
      price: (json['price'] ?? 0).toDouble(),
      options: CartItemOptionsModel.fromJson(json['options'] ?? {}),
      tax: validateString(json['tax']),
      subtotal: validateString(json['subtotal']),
      updatedAt: validateString(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rowId': rowId,
      'id': id,
      'name': name,
      'qty': qty,
      'price': price,
      'options': options.toJson(),
      'tax': tax,
      'subtotal': subtotal,
      'updated_at': updatedAt,
    };
  }

  @override
  List<Object?> get props => [
        rowId,
        id,
        name,
        qty,
        price,
        options,
        tax,
        subtotal,
        updatedAt,
      ];
}

class CartItemOptionsModel extends Equatable {
  final String? image;
  final String? type;
  final String? free_drink_title;
  final bool ? ifFreeDrink;
  final bool ? isFree;
  final String? offer_description;
  final String attributes;
  final double taxRate;
  final dynamic taxClasses;
  final dynamic options;
  final List<dynamic> extras;
  final Map<String, String>? optionInfo;
  final String sku;
  final int weight;
  final int productPoints;

  const CartItemOptionsModel({
    this.image,
    this.type,
    this.ifFreeDrink,
    this.offer_description,
    this.free_drink_title,
    this.isFree,
    required this.attributes,
    required this.taxRate,
    required this.taxClasses,
    required this.options,
    required this.extras,
    required this.sku,
    required this.weight,
    required this.productPoints,
    this.optionInfo,
  });

  CartItemOptionsModel copyWith({
    String? image,
    String? type,
    bool? ifFreeDrink,
    bool? isFree,
    String? free_drink_title,
    String? offer_description,
    String? attributes,
    double? taxRate,
    Map<String, dynamic>? taxClasses,
    Map<String, dynamic>? options,
    List<dynamic>? extras,
    String? sku,
    int? weight,
    int? productPoints,
    Map<String, String>? optionInfo,
  }) {
    return CartItemOptionsModel(
      image: image ?? this.image,
      attributes: attributes ?? this.attributes,
      ifFreeDrink: ifFreeDrink ?? this.ifFreeDrink,
      taxRate: taxRate ?? this.taxRate,
      offer_description: offer_description ?? this.offer_description,
      free_drink_title: free_drink_title ?? this.free_drink_title,
      type: type ?? this.type,
      isFree: isFree ?? this.isFree,
      taxClasses: taxClasses ?? this.taxClasses,
      options: options ?? this.options,
      extras: extras ?? this.extras,
      sku: sku ?? this.sku,
      weight: weight ?? this.weight,
      productPoints: productPoints ?? this.productPoints,
      optionInfo: optionInfo ?? this.optionInfo,
    );
  }

  factory CartItemOptionsModel.fromJson(Map<String, dynamic> json) {
    Map<String, String>? optionInfoMap;

    if (json['options'] != null && json['options'] is Map && json['options']['optionInfo'] != null) {
      optionInfoMap = Map<String, String>.from(
          (json['options']['optionInfo'] as Map).map((key, value) => MapEntry(key.toString(), value.toString())),);
    }
    return CartItemOptionsModel(
      image: json['image'] != null ? validateString(json['image']) : null,
      type: json['type'] != null ? validateString(json['type']) : null,
      ifFreeDrink: json['is_free_drink'] != null ? validateBool(json['is_free_drink']) : null,
      isFree: json['is_free'] != null ? validateBool(json['is_free']) : null,
      offer_description: json['offer_description'] != null ? validateString(json['offer_description']) : null,
      free_drink_title: json['free_drink_title'] != null ? validateString(json['free_drink_title']) : null,
      attributes: validateString(json['attributes']),
      taxRate: (json['taxRate'] ?? 0).toDouble(),
      taxClasses: json['taxClasses'] ?? {},
      options: json['options'] != null && json['options'] is Map ? json['options']['optionCartValue'] ?? {} : {},
      extras: json['extras'] ?? [],
      optionInfo: optionInfoMap,
      sku: validateString(json['sku']),
      weight: json['weight'] ?? 0,
      productPoints: json['product_points'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'image': image,
      'attributes': attributes,
      'taxRate': taxRate,
      'taxClasses': taxClasses,
      'options': {
        'optionCartValue': options,
        'optionInfo': optionInfo,
      },
      'extras': extras,
      'sku': sku,
      'weight': weight,
      'product_points': productPoints,
    };
  }

  @override
  List<Object?> get props => [
        image,
        attributes,
        taxRate,
        taxClasses,
        optionInfo,
        options,
        // options,
        extras,
        sku,
        weight,
        productPoints,
      ];
}

final demoCartItemOptions = <CartItemOptionsModel>[
  CartItemOptionsModel(
    image: 'https://example.com/burger.jpg',
    attributes: 'Size: Large, Spice: Medium',
    taxRate: 5.0,
    taxClasses: {'food': 'standard'},
    options: {'bun': 'sesame', 'cheese': 'cheddar'},
    extras: ['extra cheese', 'extra sauce'],
    sku: 'BRG-001',
    weight: 250,
    productPoints: 15,
  ),
  CartItemOptionsModel(
    image: 'https://example.com/fries.jpg',
    attributes: 'Size: Medium',
    taxRate: 5.0,
    taxClasses: {'food': 'standard'},
    options: {'salt': 'yes', 'seasoning': 'cajun'},
    extras: ['ketchup'],
    sku: 'FRS-002',
    weight: 150,
    productPoints: 10,
  ),
];

// Demo data for CartItemModel
final demoApiCartItems = <CartItemModel>[
  CartItemModel(
    rowId: 'xyz123',
    id: 101,
    name: 'Coffee Whopper',
    qty: 2,
    price: 9.99,
    options: demoCartItemOptions[0],
    tax: '1.0',
    subtotal: '19.98',
    updatedAt: '2023-08-15T14:30:00Z',
  ),
  CartItemModel(
    rowId: 'abc456',
    id: 102,
    name: 'Machito Coffe',
    qty: 1,
    price: 4.99,
    options: demoCartItemOptions[1],
    tax: '0.5',
    subtotal: '4.99',
    updatedAt: '2023-08-15T14:35:00Z',
  ),
];
