import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

/// Response model for Get Order Details endpoint
class OrderDetailResponseModel extends Equatable {
  final bool error;
  final OrderDetailModel? data;
  final String message;

  const OrderDetailResponseModel({
    required this.error,
    this.data,
    required this.message,
  });

  factory OrderDetailResponseModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailResponseModel(
      error: validateBool(json['error']),
      data:
          json['data'] != null ? OrderDetailModel.fromJson(json['data']) : null,
      message: validateString(json['message']),
    );
  }

  @override
  List<Object?> get props => [error, data, message];
}

/// Order detail model matching API response structure
class OrderDetailModel extends Equatable {
  final int id;
  final String code;
  final String status;
  final String amount;
  final String subTotal;
  final String taxAmount;
  final String discountAmount;
  final String shippingAmount;
  final String? description;
  final String createdAt;
  final OrderAddressModel? address;
  final List<OrderDetailProductModel> products;
  final OrderPaymentModel? payment;
  final List<Map<String, dynamic>>?
      rawOrderDetails; // Store raw order_details for conversion

  const OrderDetailModel({
    required this.id,
    required this.code,
    required this.status,
    required this.amount,
    required this.subTotal,
    required this.taxAmount,
    required this.discountAmount,
    required this.shippingAmount,
    this.description,
    required this.createdAt,
    this.address,
    required this.products,
    this.payment,
    this.rawOrderDetails,
  });

  factory OrderDetailModel.fromJson(Map<String, dynamic> json) {
    // Handle both 'products' and 'order_details' arrays
    List<Map<String, dynamic>> productsList = [];
    List<Map<String, dynamic>>? rawOrderDetailsList;

    if (json['order_details'] != null && json['order_details'] is List) {
      // Store raw order_details for later conversion to OrderProductModel
      rawOrderDetailsList = (json['order_details'] as List)
          .whereType<Map<String, dynamic>>()
          .toList();

      // Convert order_details to products format for OrderDetailProductModel
      productsList = rawOrderDetailsList
          .map((item) {
            return {
              'id': item['product_id'] ?? item['id'],
              'product_name': item['product_name'] ?? item['product']?['name'],
              'qty': item['qty'],
              'price': item['price'],
              'total': (item['qty'] as int? ?? 0) *
                  (double.tryParse(item['price']
                              ?.toString()
                              .replaceAll(RegExp(r'[^\d.]'), '') ??
                          '0') ??
                      0.0),
            };
          })
          .where((item) => item.isNotEmpty)
          .toList();
    } else if (json['products'] != null) {
      productsList = (json['products'] as List).cast<Map<String, dynamic>>();
    }

    return OrderDetailModel(
      id: validateInt(json['id']),
      code: validateString(json['code']),
      status: validateString(json['status']),
      amount: validateString(json['amount']),
      subTotal: validateString(json['sub_total']),
      taxAmount: validateString(json['tax_amount']),
      discountAmount: validateString(json['discount_amount']),
      shippingAmount: validateString(json['shipping_amount']),
      description: json['description'],
      createdAt: validateString(json['created_at']),
      address: json['address'] != null || json['order_address'] != null
          ? OrderAddressModel.fromJson(
              json['address'] ?? json['order_address'] ?? {})
          : null,
      products: validateJsonList(
        productsList,
        OrderDetailProductModel.fromJson,
      ),
      payment: json['payment'] != null
          ? OrderPaymentModel.fromJson(json['payment'])
          : null,
      rawOrderDetails: rawOrderDetailsList,
    );
  }

  @override
  List<Object?> get props => [
        id,
        code,
        status,
        amount,
        subTotal,
        taxAmount,
        discountAmount,
        shippingAmount,
        description,
        createdAt,
        address,
        products,
        payment,
        rawOrderDetails,
      ];
}

/// Address model for order
class OrderAddressModel extends Equatable {
  final String name;
  final String phone;
  final String address;
  final String? city;
  final String? email;
  final String? country;
  final String? state;
  final String? zipCode;

  const OrderAddressModel({
    required this.name,
    required this.phone,
    required this.address,
    this.city,
    this.email,
    this.country,
    this.state,
    this.zipCode,
  });

  factory OrderAddressModel.fromJson(Map<String, dynamic> json) {
    return OrderAddressModel(
      name: validateString(json['name']),
      phone: validateString(json['phone']),
      address: validateString(json['address']),
      city: json['city'],
      email: json['email'],
      country: json['country'],
      state: json['state'],
      zipCode: json['zip_code'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'address': address,
      if (city != null) 'city': city,
      if (email != null) 'email': email,
      if (country != null) 'country': country,
      if (state != null) 'state': state,
      if (zipCode != null) 'zip_code': zipCode,
    };
  }

  @override
  List<Object?> get props =>
      [name, phone, address, city, email, country, state, zipCode];
}

/// Product model for order detail (simplified structure from API)
class OrderDetailProductModel extends Equatable {
  final int id;
  final String productName;
  final int qty;
  final String price;
  final String? total;

  const OrderDetailProductModel({
    required this.id,
    required this.productName,
    required this.qty,
    required this.price,
    this.total,
  });

  factory OrderDetailProductModel.fromJson(Map<String, dynamic> json) {
    return OrderDetailProductModel(
      id: validateInt(json['id'] ?? json['product_id']),
      productName: validateString(
          json['product_name'] ?? json['product']?['name'] ?? ''),
      qty: validateInt(json['qty']),
      price: validateString(json['price']),
      total: json['total']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'qty': qty,
    };
  }

  @override
  List<Object?> get props => [id, productName, qty, price, total];
}

/// Payment model for order
class OrderPaymentModel extends Equatable {
  final String status;
  final String method;

  const OrderPaymentModel({
    required this.status,
    required this.method,
  });

  factory OrderPaymentModel.fromJson(Map<String, dynamic> json) {
    // Handle nested status and payment_channel structure
    final statusValue = json['status'] is Map<String, dynamic>
        ? (json['status'] as Map<String, dynamic>)['value']
        : json['status'];
    final methodValue = json['payment_channel'] is Map<String, dynamic>
        ? (json['payment_channel'] as Map<String, dynamic>)['value']
        : json['method'];

    return OrderPaymentModel(
      status: validateString(statusValue?.toString() ?? 'pending'),
      method: validateString(methodValue?.toString() ?? 'cash'),
    );
  }

  @override
  List<Object?> get props => [status, method];
}
