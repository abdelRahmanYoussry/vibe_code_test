import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/utils/states/loading_state.dart';
import '../model/notification_model.dart';

class NotificationsState extends Equatable {
  final GetNotificationsState getNotificationsState;
  final MarkAsReadState markAsReadState;


  copyWith({
    GetNotificationsState? getNotificationsState,
    MarkAsReadState? markAsReadState,
  }) {
    return NotificationsState(
      getNotificationsState: getNotificationsState ?? this.getNotificationsState,
      markAsReadState: markAsReadState ?? this.markAsReadState,

    );
  }

  const NotificationsState({
    this.getNotificationsState = const GetNotificationsState(),
    this.markAsReadState = const MarkAsReadState(),


  });

  @override
  List<Object?> get props => [
    getNotificationsState,
    markAsReadState,

      ];
}

class GetNotificationsState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final Map<String, List<NotificationModel>>? notifications;

  const GetNotificationsState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.notifications,
  });

  GetNotificationsState asLoading() => const GetNotificationsState(
        loadingState: LoadingState.loading(),
      );

  GetNotificationsState asLoadingSuccess({
    bool? success,
  Map<String, List<NotificationModel>>? notifications,
  }) =>
      GetNotificationsState(success: success, notifications: notifications);

  GetNotificationsState asLoadingFailed(String error) => GetNotificationsState(
        error: error,
      );


  @override
  List<Object?> get props => [
        success,
        loadingState,
        error,
        notifications,
      ];
}

class MarkAsReadState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel ? data;
  const MarkAsReadState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.data,
  });
  MarkAsReadState asLoading() => const MarkAsReadState(
        loadingState: LoadingState.loading(),
      );
  MarkAsReadState asLoadingSuccess({
    bool? success,
    GlobalResponseModel? data,
  }) =>
      MarkAsReadState(success: success, data: data);
  MarkAsReadState asLoadingFailed(String error) => MarkAsReadState(
        error: error,
      );
  @override
  List<Object?> get props => [
        success,
        loadingState,
        error,
        data,
      ];
}


