import 'package:equatable/equatable.dart';

import '../../../../../../core/utils/states/loading_state.dart';

class HomeAppBarState extends Equatable {
  final CheckNotificationPermissionState checkNotificationPermissionState;


  copyWith({
    CheckNotificationPermissionState? checkNotificationPermissionState,
  }) {
    return HomeAppBarState(
      checkNotificationPermissionState: checkNotificationPermissionState ?? this.checkNotificationPermissionState,

    );
  }

  const HomeAppBarState({
    this.checkNotificationPermissionState = const CheckNotificationPermissionState(),

  });

  @override
  List<Object?> get props => [
    checkNotificationPermissionState,
      ];

}

class CheckNotificationPermissionState extends Equatable {
  final bool isGranted;
  final String? error;
  final LoadingState loadingState;
  const CheckNotificationPermissionState({
    this.isGranted = false,
    this.error,
    this.loadingState = const LoadingState(),
  });

  CheckNotificationPermissionState asLoading() => const CheckNotificationPermissionState(
    loadingState: LoadingState.loading(),
  );

  CheckNotificationPermissionState asLoadingSuccess({required bool granted}) =>
      CheckNotificationPermissionState(isGranted: granted);

  CheckNotificationPermissionState asLoadingFailed(String error) => CheckNotificationPermissionState(
    error: error,
  );

  @override
  List<Object?> get props => [
        isGranted,
        error,
      ];
}
