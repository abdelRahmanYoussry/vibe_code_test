import 'dart:developer';


import 'package:dartz/dartz.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../../../core/cache/cache_helper.dart';
import '../../../../../../core/repos/lang_repo.dart';
import '../../../../../../core/theme/constants/app_strings.dart';
import 'home_app_bar_state.dart';

class HomeAppBarBloc extends Cubit<HomeAppBarState> {
  HomeAppBarBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
  }) : super(const HomeAppBarState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;

  Future<Either<String, bool>> checkNotificationPermission() async {
    try {
      PermissionStatus status = await Permission.notification.status;
      if(status.isGranted) {
        emit(state.copyWith(checkNotificationPermissionState: CheckNotificationPermissionState(isGranted: true)));
      }
      if (status.isDenied || status.isRestricted) {
        emit(state.copyWith(checkNotificationPermissionState:  CheckNotificationPermissionState(
          isGranted: false,
          error: getNotificationPermissionError(),
        ),),);
      }

      bool isGranted = status.isGranted;
      debugPrint('Notification permission status: $isGranted');
      emit(state.copyWith(checkNotificationPermissionState: CheckNotificationPermissionState(isGranted: isGranted)));
      return Right(isGranted);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      emit(state.copyWith(checkNotificationPermissionState:  CheckNotificationPermissionState(
        isGranted: false,
        error: getNotificationPermissionError(),
      ),),);
      return Left(getNotificationPermissionError());
    }
  }
}
