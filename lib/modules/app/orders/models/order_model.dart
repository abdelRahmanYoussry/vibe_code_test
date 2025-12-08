import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class OrdersResponseModel {
  final List<OrderModel> orders;
  final int activeOrdersCount;
  final int? currentPage;
  final int? lastPage;
  final int? total;
  final String? message;
  final bool? error;

  OrdersResponseModel({
    required this.orders,
    required this.activeOrdersCount,
    this.currentPage,
    this.lastPage,
    this.total,
    this.message,
    this.error,
  });

  factory OrdersResponseModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> ordersList = json['data'] ?? [];
    return OrdersResponseModel(
      orders: validateJsonList(
          ordersList.cast<Map<String, dynamic>>(), OrderModel.fromJson),
      activeOrdersCount: json['additional']?['active_orders_count'] ??
          json['active_orders_count'] ??
          0,
      currentPage: json['meta']?['current_page'],
      lastPage: json['meta']?['last_page'],
      total: json['meta']?['total'],
      message: validateString(json['message']),
      error: validateBool(json['error']),
    );
  }
}

class OrderModel extends Equatable {
  final int orderId;
  final String orderCode;
  final String status;
  final String statusValue;
  final String amount;
  final String amountValue;
  final String subTotal;
  final String subTotalValue;
  final String discountAmount;
  final String discountAmountValue;
  final String shippingAmount;
  final String shippingAmountValue;
  final String taxAmount;
  final String taxAmountValue;
  final String? couponCode;
  final String? discountDescription;
  final String? description;
  final String shippingMethod;
  final String? shippingOption;
  final bool isConfirmed;
  final String? confirmedAt;
  final bool isPreparing;
  final String? preparingAt;
  final bool isReady;
  final String? readyAt;
  final bool isFinished;
  final bool isCompleted;
  final String? completedAt;
  final String createdAt;
  final String updatedAt;
  final List<OrderProductModel> products;
  final int productsCount;

  const OrderModel({
    required this.orderId,
    required this.orderCode,
    required this.status,
    required this.statusValue,
    required this.amount,
    required this.amountValue,
    required this.subTotal,
    required this.subTotalValue,
    required this.discountAmount,
    required this.discountAmountValue,
    required this.shippingAmount,
    required this.shippingAmountValue,
    required this.taxAmount,
    required this.taxAmountValue,
    this.couponCode,
    this.discountDescription,
    this.description,
    required this.shippingMethod,
    this.shippingOption,
    required this.isConfirmed,
    this.confirmedAt,
    required this.isPreparing,
    this.preparingAt,
    required this.isReady,
    this.readyAt,
    required this.isFinished,
    required this.isCompleted,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.products,
    required this.productsCount,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: validateInt(json['order_id']),
      orderCode: validateString(json['order_code']),
      status: validateString(json['status']),
      statusValue: validateString(json['status_value']),
      amount: validateString(json['amount']),
      amountValue: validateString(json['amount_value']),
      subTotal: validateString(json['sub_total']),
      subTotalValue: validateString(json['sub_total_value']),
      discountAmount: validateString(json['discount_amount']),
      discountAmountValue: validateString(json['discount_amount_value']),
      shippingAmount: validateString(json['shipping_amount']),
      shippingAmountValue: validateString(json['shipping_amount_value']),
      taxAmount: validateString(json['tax_amount']),
      taxAmountValue: validateString(json['tax_amount_value']),
      couponCode: json['coupon_code'],
      discountDescription: json['discount_description'],
      description: json['description'],
      shippingMethod: validateString(json['shipping_method']),
      shippingOption: json['shipping_option'],
      isConfirmed: validateBool(json['is_confirmed']),
      confirmedAt: json['confirmed_at'],
      isPreparing: validateBool(json['is_preparing']),
      preparingAt: json['preparing_at'],
      isReady: validateBool(json['is_ready']),
      readyAt: json['ready_at'],
      isFinished: validateBool(json['is_finished']),
      isCompleted: validateBool(json['is_completed']),
      completedAt: json['completed_at'],
      createdAt: validateString(json['created_at']),
      updatedAt: validateString(json['updated_at']),
      products: validateJsonList(
          (json['products'] ?? []).cast<Map<String, dynamic>>(),
          OrderProductModel.fromJson),
      productsCount: validateInt(json['products_count']),
    );
  }

  @override
  List<Object?> get props => [
        orderId,
        orderCode,
        status,
        statusValue,
        amount,
        amountValue,
        subTotal,
        subTotalValue,
        discountAmount,
        discountAmountValue,
        shippingAmount,
        shippingAmountValue,
        taxAmount,
        taxAmountValue,
        couponCode,
        discountDescription,
        description,
        shippingMethod,
        shippingOption,
        isConfirmed,
        confirmedAt,
        isPreparing,
        preparingAt,
        isReady,
        readyAt,
        isFinished,
        isCompleted,
        completedAt,
        createdAt,
        updatedAt,
        products,
        productsCount
      ];
}

class OrderProductModel extends Equatable {
  final int id;
  final String name;
  final String status;
  final String sku;
  final String description;
  final String slug;
  final double price;
  final String formattedPrice;
  final String finalPrice;
  final double originalPrice;
  final String taxPrice;
  final double totalTaxesPercentage;
  final ImageUrl? imageUrl;
  final List<ImageUrl> images;
  final Store? store;
  final String orderDate;
  final bool isOffer;
  final double offerQuantity;
  final String offerPrice;
  final String offerDescription;
  final int qty;

  const OrderProductModel({
    required this.id,
    required this.name,
    required this.status,
    required this.sku,
    required this.description,
    required this.slug,
    required this.price,
    required this.formattedPrice,
    required this.finalPrice,
    required this.originalPrice,
    required this.taxPrice,
    required this.totalTaxesPercentage,
    this.imageUrl,
    required this.images,
    this.store,
    required this.orderDate,
    required this.isOffer,
    required this.offerQuantity,
    required this.offerPrice,
    required this.offerDescription,
    required this.qty,
  });
  bool get isFreeOffer => isOffer;
  factory OrderProductModel.fromJson(Map<String, dynamic> json) {
    return OrderProductModel(
      id: validateInt(json['id']),
      name: validateString(json['name']),
      status: validateString(json['status']),
      sku: validateString(json['sku']),
      description: validateString(json['description']),
      slug: validateString(json['slug']),
      price: validateDouble(json['price'].toString()),
      formattedPrice: validateString(json['formatted_price']),
      finalPrice: validateString(json['final_price']),
      originalPrice: validateDouble(json['original_price'].toString()),
      taxPrice: validateString(json['tax_price']),
      totalTaxesPercentage:
          validateDouble(json['total_taxes_percentage'].toString()),
      imageUrl: json['image_url'] != null
          ? ImageUrl.fromJson(json['image_url'])
          : null,
      images: validateJsonList(
          (json['images'] ?? []).cast<Map<String, dynamic>>(),
          ImageUrl.fromJson),
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
      orderDate: validateString(json['order_date']),
      isOffer: validateBool(json['is_offer']),
      offerQuantity: validateDouble(json['offer_quantity'].toString()),
      offerPrice: validateString(json['offer_price']),
      offerDescription: validateString(json['offer_description']),
      qty: validateInt(json['qty']),
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        status,
        sku,
        description,
        slug,
        price,
        formattedPrice,
        finalPrice,
        originalPrice,
        taxPrice,
        totalTaxesPercentage,
        imageUrl,
        images,
        store,
        orderDate,
        isOffer,
        offerQuantity,
        offerPrice,
        offerDescription,
        qty,
      ];
}

class ImageUrl extends Equatable {
  final String name;
  final String url;

  const ImageUrl({
    required this.name,
    required this.url,
  });

  factory ImageUrl.fromJson(Map<String, dynamic> json) {
    return ImageUrl(
      name: validateString(json['name']),
      url: validateString(json['url']),
    );
  }

  @override
  List<Object?> get props => [name, url];
}

class Store extends Equatable {
  final String? id;
  final String? name;

  const Store({
    this.id,
    this.name,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id']?.toString(),
      name: json['name'],
    );
  }

  @override
  List<Object?> get props => [id, name];
}
