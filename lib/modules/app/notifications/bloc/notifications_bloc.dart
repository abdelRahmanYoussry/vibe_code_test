import 'package:test_vibe/core/utils/notification_count/notifications_count_bloc.dart';
import 'package:test_vibe/modules/app/notifications/notification_repo.dart';
import 'package:test_vibe/modules/app/products/repo/product_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Cubit<NotificationsState> {
  NotificationsBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.productsRepo,
    required this.notificationsRepo,
  }) : super(const NotificationsState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final ProductsRepo productsRepo;
  final NotificationsRepo notificationsRepo;

  Future<void> getNotifications() async {
    emit(state.copyWith(getNotificationsState: state.getNotificationsState.asLoading()));
    final result = await notificationsRepo.getNotifications();

    result.fold(
      (error) {
      debugPrint('Error getting notifications: $error');
        emit(
        state.copyWith(
          getNotificationsState: state.getNotificationsState.asLoadingFailed(error),
        ),
      );
      },
      (data) {
        emit(
        state.copyWith(
          getNotificationsState: state.getNotificationsState.asLoadingSuccess(
            success: true,
            notifications: data.notifications,
          ),
        ),
      );
      },
    );
  }

  Future<void> markNotificationAsRead({required String notificationId}) async {
    emit(state.copyWith(markAsReadState: state.markAsReadState.asLoading()));
    final result = await notificationsRepo.markNotificationAsRead(notificationId: notificationId);
    result.fold(
      (error) {
        debugPrint('Error marking notification as read: $error');
        emit(
          state.copyWith(
            markAsReadState: state.markAsReadState.asLoadingFailed(error),
          ),
        );
      },
      (data) async {
        emit(
          state.copyWith(
            markAsReadState: state.markAsReadState.asLoadingSuccess(success: true),
          ),
        );
      await  NotificationsCountBloc().getNotificationsCount();
      },
    );
  }

}
