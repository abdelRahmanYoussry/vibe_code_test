import 'package:equatable/equatable.dart';
import 'package:test_vibe/core/utils/data_utils.dart';

class TrackOrderModel extends Equatable {
  final int id;
  final String confirmedTime;
  final bool isConfirmed;
  final bool isPreparing;
  final bool can_add_time;
  final bool isReady;
  final String statusMessage;
  final int estimatedPreparationMinutes;
  final String preparationAt;
  final String estimatedReadyTime;
  final String currentStatus;
  final List<AddedTimeModel> addedTimes;

  const TrackOrderModel({
    required this.id,
    required this.confirmedTime,
    required this.isConfirmed,
    required this.isPreparing,
    required this.isReady,
    required this.statusMessage,
    required this.estimatedPreparationMinutes,
    required this.preparationAt,
    required this.estimatedReadyTime,
    required this.currentStatus,
    required this.addedTimes,
    required this.can_add_time,
  });

  factory TrackOrderModel.fromJson(Map<String, dynamic> json) {
    return TrackOrderModel(
      id: validateInt(json['id']),
      confirmedTime: validateString(json['confirmed_time']),
      can_add_time: validateBool(json['can_add_time']) ,
      isConfirmed:validateBool(json['is_confirmed']),
      isPreparing: validateBool(json['is_preparing']),
      isReady: validateBool(json['is_ready']),
      statusMessage: validateString(json['status_message']),
      estimatedPreparationMinutes:validateInt(json['estimated_preparation_minutes']),
      preparationAt: validateString(json['preparation_at']),
      estimatedReadyTime: validateString(json['estimated_ready_time']),
      currentStatus: validateString(json['current_status']),
      addedTimes: validateJsonList(json['added_times'], AddedTimeModel.fromJson),
    );
  }

  @override
  List<Object?> get props => [
        id,
        confirmedTime,
        isConfirmed,
        isPreparing,
        isReady,
        statusMessage,
        estimatedPreparationMinutes,
        preparationAt,
        estimatedReadyTime,
        currentStatus,
        addedTimes,
        can_add_time,
      ];
}
class AddedTimeModel extends Equatable {
  final int value;
  final bool flag;

  const AddedTimeModel({
    required this.value,
    required this.flag,
  });

  factory AddedTimeModel.fromJson(Map<String, dynamic> json) {
    return AddedTimeModel(
      value: validateInt(json['value']),
      flag: validateBool(json['flag']),
    );
  }

  @override
  List<Object?> get props => [value, flag];
}
