import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class CouponsResponseModel extends Equatable {
  final bool error;
  final List<CouponModel> data;
  final String message;

  const CouponsResponseModel({
    required this.error,
    required this.data,
    required this.message,
  });

  CouponsResponseModel copyWith({
    bool? error,
    List<CouponModel>? data,
    String? message,
  }) {
    return CouponsResponseModel(
      error: error ?? this.error,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  factory CouponsResponseModel.fromJson(Map<String, dynamic> json) {
    return CouponsResponseModel(
      error: validateBool(json['error']),
      data: (json['data'] as List).map((e) => CouponModel.fromJson(e)).toList(),
      message: validateString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'data': data.map((e) => e.toJson()).toList(),
      'message': message,
    };
  }

  @override
  List<Object?> get props => [error, data, message];
}

class CouponModel extends Equatable {
  final int id;
  final String? title;
  final String code;
  final String startDate;
  final String? endDate;
  final String? description;
  final double value;
  final String type;
  final String typeOption;
  final CouponPivot pivot;

  const CouponModel({
    required this.id,
    this.title,
    this.description,
    required this.code,
    required this.startDate,
    this.endDate,
    required this.value,
    required this.type,
    required this.typeOption,
    required this.pivot,
  });

  CouponModel copyWith({
    int? id,
    String? title,
    String? code,
    String? startDate,
    String? endDate,
    double? value,
    String? type,
    String? typeOption,
    String? description,
    CouponPivot? pivot,
  }) {
    return CouponModel(
      id: id ?? this.id,
      title: title ?? this.title,
      code: code ?? this.code,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      value: value ?? this.value,
      type: type ?? this.type,
      typeOption: typeOption ?? this.typeOption,
      pivot: pivot ?? this.pivot,
    );
  }

  factory CouponModel.fromJson(Map<String, dynamic> json) {
    return CouponModel(
      id: json['id'],
      title: json['title'],
      code: validateString(json['code']),
      startDate: validateString(json['start_date']),
      endDate: json['end_date'],
      value: json['value'].toDouble(),
      type: validateString(json['type']),
      typeOption: validateString(json['type_option']),
      description: json['description'],
      pivot: CouponPivot.fromJson(json['pivot']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'code': code,
      'start_date': startDate,
      'end_date': endDate,
      'value': value,
      'type': type,
      'type_option': typeOption,
      'pivot': pivot.toJson(),
      'description': description,
    };
  }

  @override
  List<Object?> get props => [
    id,
    title,
    code,
    startDate,
    endDate,
    value,
    type,
    typeOption,
    pivot,
    description,
  ];
}

class CouponPivot extends Equatable {
  final int customerId;
  final int discountId;

  const CouponPivot({
    required this.customerId,
    required this.discountId,
  });

  CouponPivot copyWith({
    int? customerId,
    int? discountId,
  }) {
    return CouponPivot(
      customerId: customerId ?? this.customerId,
      discountId: discountId ?? this.discountId,
    );
  }

  factory CouponPivot.fromJson(Map<String, dynamic> json) {
    return CouponPivot(
      customerId: json['customer_id'],
      discountId: json['discount_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'customer_id': customerId,
      'discount_id': discountId,
    };
  }

  @override
  List<Object?> get props => [customerId, discountId];
}
