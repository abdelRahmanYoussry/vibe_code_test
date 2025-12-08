import 'package:equatable/equatable.dart';
import 'order_detail_model.dart';

/// Parameters for updating an order
class UpdateOrderParams extends Equatable {
  final String? description;
  final OrderAddressModel? address;
  final List<UpdateOrderProductParams> products;
  final String? paymentMethod;

  const UpdateOrderParams({
    this.description,
    this.address,
    required this.products,
    this.paymentMethod,
  });

  Map<String, dynamic> toJson() {
    return {
      if (description != null) 'description': description,
      if (address != null) 'address': address!.toJson(),
      'products': products.map((p) => p.toJson()).toList(),
      if (paymentMethod != null) 'payment_method': paymentMethod,
    };
  }

  @override
  List<Object?> get props => [description, address, products, paymentMethod];
}

/// Product parameters for updating order
class UpdateOrderProductParams extends Equatable {
  final int id;
  final int qty;

  const UpdateOrderProductParams({
    required this.id,
    required this.qty,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'qty': qty,
    };
  }

  @override
  List<Object?> get props => [id, qty];
}
