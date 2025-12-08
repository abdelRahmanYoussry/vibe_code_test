import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import '../../../../core/repos/lang_repo.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../../../core/theme/constants/app_strings.dart';
import '../../../core/utils/data_utils.dart';
import '../../../core/utils/notification_count/notifications_count_bloc.dart';
import '../../../core/utils/remote/api_app_config.dart';
import 'model/notification_response_model.dart';

class NotificationsRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;

  NotificationsRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
  });

  Future<Either<String, NotificationResponseModel>> getNotifications() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getNotifications(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );

      if (rawData.isEmpty) {
        return Left(getServerError());
      }

      final dataJson = await jsonDecode(rawData);
      NotificationResponseModel notificationResponseModel = NotificationResponseModel.fromJson(dataJson);
      return Right(notificationResponseModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, int>> getNotificationsCount() async {
    if (authRepo.user == null) {
      return left('');
    }
    final rawData = await apiHelper.getData(
      AppConfig.getNotifications(),
      token: authRepo.user!.token,
      lang: langRepo.lang,
      typeJSON: true,
    );
    if (rawData.isEmpty) {
      return Left(getServerError());
    }
    final dataJson = await jsonDecode(rawData);
    final int count = int.tryParse(validateString(dataJson['data']?['unread_count'])) ?? 0;

    await NotificationsCountBloc().setData(count);
    return Right(count);
  }

  Future<Either<String, bool>> markNotificationAsRead({required String notificationId}) async {
    final rawData = await apiHelper.postData(
      AppConfig.markAllAsRead(),
      token: authRepo.token,
      lang: langRepo.lang,
      data: {"id": notificationId},
    );
    if (rawData.isEmpty) {
      return Left(getServerError());
    }
    return Right(true);
  }

}
