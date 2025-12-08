// dart
import 'package:equatable/equatable.dart';
import 'package:test_vibe/core/utils/data_utils.dart';

class PointsWalletResponseModel extends Equatable {
  final bool error;
  final PointsWalletData data;
  final String message;

  const PointsWalletResponseModel({
    required this.error,
    required this.data,
    required this.message,
  });

  PointsWalletResponseModel copyWith({
    bool? error,
    PointsWalletData? data,
    String? message,
  }) {
    return PointsWalletResponseModel(
      error: error ?? this.error,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  factory PointsWalletResponseModel.fromJson(Map<String, dynamic> json) {
    final dataJson = (json['data'] as Map<String, dynamic>?) ?? const {};
    return PointsWalletResponseModel(
      error: validateBool(json['error']),
      data: PointsWalletData.fromJson(dataJson),
      message: validateString(json['message']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'error': error,
      'data': data.toJson(),
      'message': message,
    };
  }

  @override
  List<Object?> get props => [error, data, message];
}


class PointsWalletData extends Equatable {
  final String points;
  final String walletBalance;

  const PointsWalletData({
    required this.points,
    required this.walletBalance,
  });


  factory PointsWalletData.fromJson(Map<String, dynamic> json) {
    final p = json['points'];
    final w = json['wallet_balance'];
    return PointsWalletData(
      points: validateString(p),
      walletBalance: validateString(w),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'points': points,
      'wallet_balance': walletBalance,
    };
  }

  @override
  List<Object?> get props => [points, walletBalance];
}
