import 'package:equatable/equatable.dart';
import 'package:test_vibe/core/utils/data_utils.dart';

class SpinnerRewardResult extends Equatable {
  final int? rewardId;
  final String? rewardName;
  final String? type;
  final String? btn_title;

  const SpinnerRewardResult({
     this.rewardId,
     this.rewardName,
      this.type,
      this.btn_title,
  });

  factory SpinnerRewardResult.fromJson(Map<String, dynamic> json) {
    return SpinnerRewardResult(
      rewardId: validateInt(json['reward_id']),
      rewardName: validateString(json['reward_name']),
      type:  validateString(json['type']),
      btn_title: validateString(json['btn_title']),
    );
  }

  Map<String, dynamic> toJson() => {
    'reward_id': rewardId,
    'reward_name': rewardName,
    'type': type,
    'btn_title': btn_title,
  };

  SpinnerRewardResult copyWith({
    int? rewardId,
    String? rewardName,
    String? type,
    String? btn_title,
  }) {
    return SpinnerRewardResult(
      rewardId: rewardId ?? this.rewardId,
      rewardName: rewardName ?? this.rewardName,
      type: type ?? this.type,
      btn_title: btn_title ?? this.btn_title,
    );
  }

  @override
  List<Object?> get props => [rewardId, rewardName,type,btn_title];
}
