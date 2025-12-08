import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:equatable/equatable.dart';

class RewardsResponseModel extends Equatable {
  final bool error;
  final RewardsDataModel data;
  final String message;

  const RewardsResponseModel({
    required this.error,
    required this.data,
    required this.message,
  });

  RewardsResponseModel copyWith({
    bool? error,
    RewardsDataModel? data,
    String? message,
  }) {
    return RewardsResponseModel(
      error: error ?? this.error,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  factory RewardsResponseModel.fromJson(Map<String, dynamic> json) {
    return RewardsResponseModel(
      error: validateBool(json['error']),
      data: RewardsDataModel.fromJson(json['data']),
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

class RewardsDataModel extends Equatable {
  final int buyQty;
  final int freeQty;
  final RewardsProgressModel? progress;
  final String? progress_message;

  const RewardsDataModel({
    required this.buyQty,
    required this.freeQty,
    required this.progress,
    this.progress_message,
  });

  RewardsDataModel copyWith({
    int? buyQty,
    int? freeQty,
    RewardsProgressModel? progress,
    String? progress_message,
  }) {
    return RewardsDataModel(
      buyQty: buyQty ?? this.buyQty,
      freeQty: freeQty ?? this.freeQty,
      progress: progress ?? this.progress,
      progress_message: progress_message ?? this.progress_message,
    );
  }

  factory RewardsDataModel.fromJson(Map<String, dynamic> json) {
    return RewardsDataModel(
      buyQty: json['buy_qty'],
      freeQty: json['free_qty'],
      progress_message: json['progress_message'],
      progress: json['progress'] == null ? null : RewardsProgressModel.fromJson(json['progress']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'buy_qty': buyQty,
      'free_qty': freeQty,
      'progress': progress?.toJson(),
      'progress_message': progress_message,
    };
  }

  @override
  List<Object?> get props => [buyQty, freeQty, progress, progress_message];
}

class RewardsProgressModel extends Equatable {
  final int progressCount;
  final int currentProgress;
  final int remaining;
  final int completedCycles;
  final int freeEarned;
  final int freeRedeemed;
  final int freePending;

  const RewardsProgressModel({
    required this.progressCount,
    required this.currentProgress,
    required this.remaining,
    required this.completedCycles,
    required this.freeEarned,
    required this.freeRedeemed,
    required this.freePending,
  });

  RewardsProgressModel copyWith({
    int? progressCount,
    int? currentProgress,
    int? remaining,
    int? completedCycles,
    int? freeEarned,
    int? freeRedeemed,
    int? freePending,
  }) {
    return RewardsProgressModel(
      progressCount: progressCount ?? this.progressCount,
      currentProgress: currentProgress ?? this.currentProgress,
      remaining: remaining ?? this.remaining,
      completedCycles: completedCycles ?? this.completedCycles,
      freeEarned: freeEarned ?? this.freeEarned,
      freeRedeemed: freeRedeemed ?? this.freeRedeemed,
      freePending: freePending ?? this.freePending,
    );
  }

  factory RewardsProgressModel.fromJson(Map<String, dynamic> json) {
    return RewardsProgressModel(
      progressCount: validateInt(json['progress_count']),
      currentProgress: validateInt(json['current_progress']),
      remaining: validateInt(json['remaining']),
      completedCycles: validateInt(json['completed_cycles']),
      freeEarned: validateInt(json['free_earned']),
      freeRedeemed: validateInt(json['free_redeemed']),
      freePending: validateInt(json['free_pending']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'progress_count': progressCount,
      'current_progress': currentProgress,
      'remaining': remaining,
      'completed_cycles': completedCycles,
      'free_earned': freeEarned,
      'free_redeemed': freeRedeemed,
      'free_pending': freePending,
    };
  }

  @override
  List<Object?> get props => [
        progressCount,
        currentProgress,
        remaining,
        completedCycles,
        freeEarned,
        freeRedeemed,
        freePending,
      ];
}
