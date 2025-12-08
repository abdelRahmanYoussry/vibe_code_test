import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class OrderPaymentStatusModel extends Equatable {
  final bool error;
  final String message;
  final OrderPaymentData? data;

  const OrderPaymentStatusModel({
    required this.error,
    required this.message,
     this.data,
  });

  factory OrderPaymentStatusModel.fromJson(Map<String, dynamic> json) {
    return OrderPaymentStatusModel(
      error: validateBool(json['error']),
      message: validateString(json['message']),
      data: json['data'] != null ? OrderPaymentData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'message': message,
      'data': data?.toJson(),
    };
  }

  @override
  List<Object?> get props => [error, message, data];
}

class OrderPaymentData extends Equatable {
  final bool success;
  final String message;
  final String orderId;

  const OrderPaymentData({
    required this.success,
    required this.message,
    required this.orderId,
  });

  factory OrderPaymentData.fromJson(Map<String, dynamic> json) {
    return OrderPaymentData(
      success: validateBool(json['success']),
      message: validateString(json['message']),
      orderId: validateString(json['order_id']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'order_id': orderId,
    };
  }

  @override
  List<Object?> get props => [success, message, orderId];
}
