import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../modules/app/notifications/notification_repo.dart';
import '../../di/di.dart';
import 'notifications_count_state.dart';

class NotificationsCountBloc extends Cubit<NotificationsCountState> {
  NotificationsCountBloc._(this.notificationsRepo) : super(const NotificationsCountState());
  final NotificationsRepo notificationsRepo;

  factory NotificationsCountBloc() {
    if (!di.isRegistered<NotificationsCountBloc>()) {
      di.registerSingleton<NotificationsCountBloc>(NotificationsCountBloc._(di()));
    }
    return di<NotificationsCountBloc>();
  }

  @override
  Future<void> close() {
    di.unregister<NotificationsCountBloc>();
    return super.close();
  }

  setData(int notificationsCount) {
    emit(state.copyWith(notificationsCount: notificationsCount));
  }
  getNotificationsCount() =>notificationsRepo.getNotificationsCount();

  clear() => emit(state.copyWith(notificationNull: true));
}
