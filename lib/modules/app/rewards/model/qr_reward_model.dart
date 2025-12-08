import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class QrRewardResponseModel extends Equatable {
  final bool error;
  final QrRewardDataModel data;
  final String message;

  const QrRewardResponseModel({
    required this.error,
    required this.data,
    required this.message,
  });

  QrRewardResponseModel copyWith({
    bool? error,
    QrRewardDataModel? data,
    String? message,
  }) {
    return QrRewardResponseModel(
      error: error ?? this.error,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  factory QrRewardResponseModel.fromJson(Map<String, dynamic> json) {
    return QrRewardResponseModel(
      error: validateBool(json['error']),
      data: QrRewardDataModel.fromJson(json['data']),
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

class QrRewardDataModel extends Equatable {
  final String qrToken;

  const QrRewardDataModel({
    required this.qrToken,
  });

  QrRewardDataModel copyWith({
    String? qrToken,
  }) {
    return QrRewardDataModel(
      qrToken: qrToken ?? this.qrToken,
    );
  }

  factory QrRewardDataModel.fromJson(Map<String, dynamic> json) {
    return QrRewardDataModel(
      qrToken: validateString(json['qr_token']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'qr_token': qrToken,
    };
  }

  @override
  List<Object?> get props => [qrToken];
}
