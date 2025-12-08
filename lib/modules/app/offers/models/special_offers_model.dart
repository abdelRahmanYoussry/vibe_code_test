import 'package:equatable/equatable.dart';
import 'package:test_vibe/core/utils/data_utils.dart';

import '../../../../core/assets/gen/assets.gen.dart';

// Main response wrapper
class SpecialOffersResponseModel extends Equatable {
  final bool error;
  final SpecialOffersDataModel data;
  final String? message;

  const SpecialOffersResponseModel({
    required this.error,
    required this.data,
    this.message,
  });

  factory SpecialOffersResponseModel.fromJson(Map<String, dynamic> json) => SpecialOffersResponseModel(
    error: validateBool(json['error']),
    data: SpecialOffersDataModel.fromJson(json['data']),
    message: json['message'],
  );

  @override
  List<Object?> get props => [error, data, message];
}

// Data container model
class SpecialOffersDataModel extends Equatable {
  final List<FlashSaleModel> flashSales;

  const SpecialOffersDataModel({
    required this.flashSales,
  });

  factory SpecialOffersDataModel.fromJson(Map<String, dynamic> json) => SpecialOffersDataModel(
    flashSales: validateJsonList(json['flash_sales'], FlashSaleModel.fromJson),
  );

  @override
  List<Object?> get props => [flashSales];
}

// Flash sale model
class FlashSaleModel extends Equatable {
  final int id;
  final String title;
  final String endDate;
  final String image;
  final List<FlashSaleProductModel> products;

  const FlashSaleModel({
    required this.id,
    required this.title,
    required this.endDate,
    required this.products,
    required this.image,
  });

  factory FlashSaleModel.fromJson(Map<String, dynamic> json) => FlashSaleModel(
    id: validateInt(json['id']),
    image: json['image'] ==null? Assets.demo.specialOffers1.path:validateString(json['image']),
    title: validateString(json['title']),
    endDate: validateString(json['end_date']),
    products: validateJsonList(json['products'], FlashSaleProductModel.fromJson),
  );

  @override
  List<Object?> get props => [id, title, endDate, products];
}

// Flash sale product model
class FlashSaleProductModel extends Equatable {
  final int id;
  final String name;
  final String? image;
  final double discountPercent;
  final double quantity;
  final double original_price_for_quantity;
  final double flash_sale_price_for_quantity;


  const FlashSaleProductModel({
    required this.id,
    required this.name,
    this.image,
    required this.discountPercent,
    required this.quantity,
    required this.original_price_for_quantity,
    required this.flash_sale_price_for_quantity,
  });

  factory FlashSaleProductModel.fromJson(Map<String, dynamic> json) => FlashSaleProductModel(
    id: validateInt(json['id']),
    name: validateString(json['name']),
    image: json['image'],
    discountPercent: validateDouble(json['discount_percent']),
    quantity: validateDouble(json['quantity']),
    original_price_for_quantity: validateDouble(json['original_price_for_quantity']),
    flash_sale_price_for_quantity: validateDouble(json['flash_sale_price_for_quantity']),
  );

  @override
  List<Object?> get props => [id, name, image, discountPercent];
}
