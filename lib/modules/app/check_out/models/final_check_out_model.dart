import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class FinalCheckOutResponseModel extends Equatable {
  final bool error;
  final String message;
  final String? payment_url;
  final String? callback_url;
  final String order_id;
  final String payment_method;

  const FinalCheckOutResponseModel({
    required this.error,
    required this.order_id,
    this.payment_url,
    this.callback_url,
    required this.message,
    required this.payment_method,
  });

  FinalCheckOutResponseModel copyWith({
    bool? error,
    String? order_id,
    String? payment_url,
    String? message,
    String? payment_method,
    String? callback_url,
  }) {
    return FinalCheckOutResponseModel(
      error: error ?? this.error,
      order_id: order_id ?? this.order_id,
      payment_url: payment_url ?? this.payment_url,
      message: message ?? this.message,
      payment_method: payment_method ?? this.payment_method,
      callback_url: callback_url ?? this.callback_url,
    );
  }

  factory FinalCheckOutResponseModel.fromJson(Map<String, dynamic> json) {
    return FinalCheckOutResponseModel(
        error: validateBool(json['error']),
        order_id: validateString(json['order_id']),
        payment_url: validateString(json['payment_url']),
        message: validateString(json['message']),
        payment_method: validateString(json['payment_method']),
        callback_url: validateString(json['callback_url']),);
  }

  bool isCreditCardPayment() {
    return (payment_url?.isNotEmpty ?? false) && (callback_url?.isNotEmpty ?? false);
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'order_id': order_id,
      'payment_url': payment_url,
      'message': message,
      'payment_method': payment_method,
      'callback_url': callback_url,
    };
  }

  @override
  List<Object?> get props => [
        error,
        order_id,
        payment_url,
        message,
        payment_method,
        callback_url,
      ];
}
