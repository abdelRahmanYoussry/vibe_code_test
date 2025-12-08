import 'package:test_vibe/modules/app/splash/bloc/splash_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../auth/repo/auth_repo.dart';


class SplashBloc extends Cubit<SplashState> {
  SplashBloc({ required this.authRepo, required this.cacheHelper}) : super(const SplashState());

  final AuthRepo authRepo;
  final CacheHelper cacheHelper;

  checkUser() async {
    emit(state.asLoading());
    final checkUser = await authRepo.checkUser();
    final checkOnBoardingSkipped = await cacheHelper.has(kUserOnBoardIsSkipped);
    emit(state.asLoadingSuccess(checkUser, checkOnBoardingSkipped));
  }

}
