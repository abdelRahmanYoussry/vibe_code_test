import 'package:equatable/equatable.dart';

class AddToCartParams extends Equatable {
  final String productId;
  final String quantity;
  final Map<String, Map<String, String>>? options;
  final String? rowId; // Add this new field
  final String? type;
  final bool? isFreeDrink;
  final String? rewardId;
final bool?isDrink;
  const AddToCartParams({
    required this.productId,
    required this.quantity,
    this.options,
    this.rowId,
    this.type,
    this.isFreeDrink,
    this.rewardId,
    this.isDrink,
  });

  @override
  List<Object?> get props => [
        productId,
        quantity,
        options,
        rowId,
        type,
        isFreeDrink,
        rewardId,
        isDrink,
      ];
}
