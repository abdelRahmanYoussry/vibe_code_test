import 'package:equatable/equatable.dart';
import 'package:test_vibe/core/utils/data_utils.dart';

// Main response wrapper
class SpinnerResponseModel extends Equatable {
  final bool error;
  final List<SpinnerModel> data;
  final String message;

  const SpinnerResponseModel({
    required this.error,
    required this.data,
    required this.message,
  });

  factory SpinnerResponseModel.fromJson(Map<String, dynamic> json) => SpinnerResponseModel(
    error: validateBool(json['error']),
    data: validateJsonList(json['data'], SpinnerModel.fromJson),
    message: validateString(json['message']),
  );

  @override
  List<Object?> get props => [error, data, message];
}

// Individual spinner model
class SpinnerModel extends Equatable {
  final int id;
  final String? title;
  final String? description;
  final String startAt;
  final String endAt;
  final String remaining;
  final bool is_visible;
  final List<SpinnerRewardModel> rewards;

  // Derived properties to maintain compatibility with existing code
  bool get available => is_visible;
  String get label => "Spinner";
  String get desc => description ?? "";
  List<SpinnerItemModel> get items => rewards.map((reward) =>
      SpinnerItemModel(
        id: reward.id,
        text: reward.name,
        percent: reward.displayPercentage,
      ),
  ).toList();

  // Duration string for display
  String get duration => remaining;

  const SpinnerModel({
    required this.id,
    this.title,
    this.description,
    required this.startAt,
    required this.endAt,
    required this.remaining,
    required this.rewards,
    required this.is_visible,
  });

  factory SpinnerModel.fromJson(Map<String, dynamic> json) => SpinnerModel(
    id: validateInt(json['id']),
    title: json['title'],
    description: json['description'],
    startAt: validateString(json['start_at']),
    endAt: validateString(json['end_at']),
    remaining: validateString(json['remaining']),
    rewards: validateJsonList(json['rewards'], SpinnerRewardModel.fromJson),
    is_visible: validateBool(json['is_visible']),
  );

  @override
  List<Object?> get props => [id, title, description, startAt, endAt, remaining, rewards, is_visible];
}

// Spinner reward model
class SpinnerRewardModel extends Equatable {
  final int id;
  final String name;
  final int displayPercentage;
  final SpinnerPivotModel pivot;

  const SpinnerRewardModel({
    required this.id,
    required this.name,
    required this.displayPercentage,
    required this.pivot,
  });

  factory SpinnerRewardModel.fromJson(Map<String, dynamic> json) => SpinnerRewardModel(
    id: validateInt(json['id']),
    name: validateString(json['name']),
    displayPercentage: validateInt(json['display_percentage']),
    pivot: SpinnerPivotModel.fromJson(json['pivot']),
  );

  @override
  List<Object?> get props => [id, name, displayPercentage, pivot];
}

// Pivot relationship model
class SpinnerPivotModel extends Equatable {
  final int wheelSpinnerId;
  final int rewardId;

  const SpinnerPivotModel({
    required this.wheelSpinnerId,
    required this.rewardId,
  });

  factory SpinnerPivotModel.fromJson(Map<String, dynamic> json) => SpinnerPivotModel(
    wheelSpinnerId: validateInt(json['wheel_spinner_id']),
    rewardId: validateInt(json['reward_id']),
  );

  @override
  List<Object?> get props => [wheelSpinnerId, rewardId];
}

// Item model for spinner display (maintains compatibility with existing code)
class SpinnerItemModel extends Equatable {
  final int id;
  final String text;
  final int percent;

  const SpinnerItemModel({
    required this.id,
    required this.text,
    required this.percent,
  });

  @override
  List<Object?> get props => [id, text, percent];
}
