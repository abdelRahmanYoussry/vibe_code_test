import 'package:test_vibe/core/models/price_model.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/modules/app/products/models/product_model.dart';
import 'package:equatable/equatable.dart';

class CartItemModel extends Equatable {
  final String id;
  final ProductModel? product;
  final List<ProductCustomizationModel> selectedCustomizations;
  final int quantity;
  final PriceModel? price;

  const CartItemModel({
    required this.id,
    required this.product,
    required this.selectedCustomizations,
    required this.quantity,
    required this.price,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) => CartItemModel(
        id: validateString(json['id']),
        product: validateJson(json['product'], ProductModel.fromJson),
        selectedCustomizations: validateJsonList(json['selectedCustomizations'], ProductCustomizationModel.fromJson),
        quantity: validateInt(json['quantity']),
        price: validateJson(json['price'], PriceModel.fromJson),
      );

  @override
  List<Object?> get props => [
        id,
        product,
        selectedCustomizations,
        quantity,
        price,
      ];
}

// final demoCartItems = <CartItemModel>[
//   CartItemModel(
//     id: '1',
//     product: demoProducts[0],
//     selectedCustomizations: [
//       demoProducts[0].customizations[0].copyWith(options: [demoProducts[0].customizations[0].options[1]]),
//       demoProducts[0].customizations[1].copyWith(options: [demoProducts[0].customizations[1].options[0]]),
//     ],
//     quantity: 1,
//     price: demoProducts[0].price,
//   ),
//   CartItemModel(
//     id: '2',
//     product: demoProducts[1],
//     selectedCustomizations: [
//       demoProducts[1].customizations[0].copyWith(options: [demoProducts[1].customizations[0].options[1]]),
//       demoProducts[1].customizations[1].copyWith(options: [demoProducts[1].customizations[1].options[0]]),
//     ],
//     quantity: 1,
//     price: demoProducts[0].price,
//   ),
// ];
