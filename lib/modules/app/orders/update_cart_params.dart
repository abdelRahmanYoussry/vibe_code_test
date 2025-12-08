import 'package:equatable/equatable.dart';

class UpdateCartParams extends Equatable {
  final int orderId;
  final String quantity;
  final Map<String, Map<String, String>>? options;
  final String? rowId; // Add this new field
  final String? type;
  final bool? isFreeDrink;
  final String? rewardId;
final bool?isDrink;
  const UpdateCartParams({
    required this.orderId,
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
        orderId,
        quantity,
        options,
        rowId,
        type,
        isFreeDrink,
        rewardId,
        isDrink,
      ];
}
