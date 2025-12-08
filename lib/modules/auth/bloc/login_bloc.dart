import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import '../../../core/parameters/register_parameters.dart';
import '../repo/auth_repo.dart';
import 'login_state.dart';

class LoginBloc extends Cubit<LoginState> {
  LoginBloc({
    required this.authRepo,
    required this.langRepo,
    required this.cacheHelper,
  }) : super(const LoginState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;

  loginWithPhoneNumber({required String phone}) async {
    emit(
      state.copyWith(
        submitLoginState: state.submitLoginState.asLoading(),
      ),
    );
    final f = await authRepo.loginWithPhone(
      phone: phone,
    );
    await f.fold(
      (l) async {
        emit(
          state.copyWith(
            submitLoginState: state.submitLoginState.asLoadingFailed(l),
          ),
        );
      },
      (r) async {
        bool isNewUser = false;
        emit(
          state.copyWith(
            submitLoginState: state.submitLoginState.asLoadingSuccess(
              success: true,
              isNewUser: isNewUser,
              loginModel: r,
            ),
          ),
        );
      },
    );
  }

  verifyCode({
    required String phone,
    required String code,
  }) async {
    emit(
      state.copyWith(
        verifyCodeState: state.verifyCodeState.asLoading(),
      ),
    );
    final f = await authRepo.verifyLoginCode(
      phone: phone,
      code: code,
    );
    await f.fold(
      (l) async {
        emit(
          state.copyWith(
            verifyCodeState: state.verifyCodeState.asLoadingFailed(l),
          ),
        );
      },
      (r) async {
        emit(
          state.copyWith(
            verifyCodeState: state.verifyCodeState.asLoadingSuccess(
              success: true,
              userModel: r,
            ),
          ),
        );
      },
    );
  }

  verifyRegisterLoginCode({
    required String phone,
    required String code,
  }) async {
    emit(
      state.copyWith(
        verifyCodeState: state.verifyCodeState.asLoading(),
      ),
    );
    final f = await authRepo.verifyRegisterLoginCode(
      phone: phone,
      code: code,
    );
    await f.fold(
          (l) async {
        emit(
          state.copyWith(
            verifyCodeState: state.verifyCodeState.asLoadingFailed(l),
          ),
        );
      },
          (r) async {
        emit(
          state.copyWith(
            verifyCodeState: state.verifyCodeState.asLoadingSuccess(
              success: true,
              userModel: r,
            ),
          ),
        );
      },
    );
  }

  Future<void> loginWithGoogle() async {
    emit(
      state.copyWith(
        submitLoginState: state.submitLoginState.asLoading(),
      ),
    );
    final result = await authRepo.signInWithGoogle();
    result.fold(
      (failure) {
        debugPrint('LoginBloc.loginWithGoogle failure: ${failure.message}');
        emit(
          state.copyWith(
            submitLoginState: state.submitLoginState.asLoadingFailed(
              failure.message,
            ),
          ),
        );
      },
      (userModel) async {
        debugPrint('LoginBloc.loginWithGoogle userModel: $userModel');
        emit(
          state.copyWith(
            loginSocialState: state.loginSocialState.asLoadingSuccess(
              success: true,
              userModel: userModel,
            ),
          ),
        );
      },
    );
  }

  Future<void> loginWithApple() async {
    emit(
      state.copyWith(
        submitLoginState: state.submitLoginState.asLoading(),
      ),
    );
    final result = await authRepo.signInWithApple();
    result.fold(
      (failure) {
        debugPrint('LoginBloc.loginWithApple failure: ${failure.message}');
        emit(
          state.copyWith(
            submitLoginState: state.submitLoginState.asLoadingFailed(
              failure.message,
            ),
          ),
        );
      },
      (userModel) async {
        debugPrint('LoginBloc.loginWithApple userModel: $userModel');
        emit(
          state.copyWith(
            loginSocialState: state.loginSocialState.asLoadingSuccess(
              success: true,
              userModel: userModel,
            ),
          ),
        );
      },
    );
  }

  Future<void> confirmProfile({
    required String phone,
    required String name,
  }) async {
    emit(
      state.copyWith(
        confirmProfileState: state.confirmProfileState.asLoading(),
      ),
    );
    final f = await authRepo.updateProfile(
      phone: phone,
      name: name,
    );
    await f.fold(
      (error) async {
        emit(
          state.copyWith(
            confirmProfileState: state.confirmProfileState.asLoadingFailed(error),
          ),
        );
      },
      (r) async {
        emit(
          state.copyWith(
            confirmProfileState: state.confirmProfileState.asLoadingSuccess(
              success: true,
              userModel: r,
            ),
          ),
        );
      },
    );
  }

  Future<void> registerUser({required ProfileParameters params}) async {
    emit(
      state.copyWith(
        registerUserState: state.registerUserState.asLoading(),
      ),
    );
    final f = await authRepo.registerWithOtp(parameters: params);
    await f.fold(
      (error) async {
        emit(
          state.copyWith(
            registerUserState: state.registerUserState.asLoadingFailed(error),
          ),
        );
      },
      (r) async {
        emit(
          state.copyWith(
            registerUserState: state.registerUserState.asLoadingSuccess(
              success: true,
              globalResponseModel: r,
            ),
          ),
        );
      },
    );
  }
}
