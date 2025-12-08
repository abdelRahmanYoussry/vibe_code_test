import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/models/user_model.dart';
import '../../../../core/utils/states/loading_state.dart';

class LoginState extends Equatable {
  final SubmitLoginState submitLoginState;
  final ChangeLangState changeLangState;
  final VerifyCodeState verifyCodeState;
  final LoginSocialState loginSocialState;
  final ConfirmProfileState confirmProfileState;
  final RegisterUserState registerUserState;

  copyWith({
    SubmitLoginState? submitLoginState,
    ChangeLangState? changeLangState,
    VerifyCodeState? verifyCodeState,
    LoginSocialState? loginSocialState,
    ConfirmProfileState? confirmProfileState,
    RegisterUserState? registerUserState,
  }) {
    return LoginState(
      submitLoginState: submitLoginState ?? this.submitLoginState,
      changeLangState: changeLangState ?? this.changeLangState,
      verifyCodeState: verifyCodeState ?? this.verifyCodeState,
      loginSocialState: loginSocialState ?? this.loginSocialState,
      confirmProfileState: confirmProfileState ?? this.confirmProfileState,
      registerUserState: registerUserState ?? this.registerUserState,
    );
  }

  const LoginState({
    this.submitLoginState = const SubmitLoginState(),
    this.changeLangState = const ChangeLangState(),
    this.verifyCodeState = const VerifyCodeState(),
    this.loginSocialState = const LoginSocialState(),
    this.confirmProfileState = const ConfirmProfileState(),
    this.registerUserState = const RegisterUserState(),
  });

  @override
  List<Object?> get props => [
        submitLoginState,
        changeLangState,
        verifyCodeState,
        loginSocialState,
        confirmProfileState,
        registerUserState,
      ];
}

class SubmitLoginState extends Equatable {
  final bool? success;
  final bool? isNewUser;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? loginModel;

  const SubmitLoginState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.loginModel,
    this.isNewUser,
  });

  SubmitLoginState asLoading() => const SubmitLoginState(
        loadingState: LoadingState.loading(),
      );

  SubmitLoginState asLoadingSuccess({
    bool? success,
    bool? isNewUser,
    GlobalResponseModel? loginModel,
  }) =>
      SubmitLoginState(success: success, isNewUser: isNewUser, loginModel: loginModel);

  SubmitLoginState asLoadingFailed(String error) => SubmitLoginState(
        error: error,
      );

  @override
  List<Object?> get props => [
        success,
        loadingState,
        error,
        isNewUser,
      ];
}

class ChangeLangState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final String? lang;

  const ChangeLangState({this.success, this.loadingState = const LoadingState(), this.error, this.lang});

  ChangeLangState asLoading() => const ChangeLangState(
        loadingState: LoadingState.loading(),
      );

  ChangeLangState asLoadingSuccess({bool? success, String? lang}) => ChangeLangState(success: success, lang: lang);

  ChangeLangState asLoadingFailed(String error) => ChangeLangState(
        error: error,
      );

  @override
  List<Object?> get props => [success, loadingState, error, lang];
}

class VerifyCodeState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final UserModel? userModel;

  const VerifyCodeState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.userModel,
  });

  VerifyCodeState asLoading() => const VerifyCodeState(
        loadingState: LoadingState.loading(),
      );

  VerifyCodeState asLoadingSuccess({bool? success, UserModel? userModel}) =>
      VerifyCodeState(success: success, userModel: userModel);

  VerifyCodeState asLoadingFailed(String error) => VerifyCodeState(
        error: error,
      );

  @override
  List<Object?> get props => [success, loadingState, error, userModel];
}

final class LoginSocialState extends Equatable {
  final UserModel? userModel;
  final bool? success;

  const LoginSocialState({
    this.userModel,
    this.success,
  });

  LoginSocialState asLoadingSuccess({
    bool? success,
    UserModel? userModel,
  }) =>
      LoginSocialState(
        success: success,
        userModel: userModel,
      );

  @override
  List<Object?> get props => [userModel, success];
}

class ConfirmProfileState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final UserModel? userModel;

  const ConfirmProfileState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.userModel,
  });

  ConfirmProfileState asLoading() => const ConfirmProfileState(
        loadingState: LoadingState.loading(),
      );

  ConfirmProfileState asLoadingSuccess({bool? success, UserModel? userModel}) =>
      ConfirmProfileState(success: success, userModel: userModel);

  ConfirmProfileState asLoadingFailed(String error) => ConfirmProfileState(
        error: error,
      );

  @override
  List<Object?> get props => [success, loadingState, error, userModel];
}

class RegisterUserState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? globalResponseModel;

  const RegisterUserState({
    this.success,
    this.loadingState = const LoadingState(),
    this.error,
    this.globalResponseModel,
  });

  RegisterUserState asLoading() => const RegisterUserState(
        loadingState: LoadingState.loading(),
      );

  RegisterUserState asLoadingSuccess({bool? success, GlobalResponseModel? globalResponseModel}) =>
      RegisterUserState(success: success, globalResponseModel: globalResponseModel);

  RegisterUserState asLoadingFailed(String error) => RegisterUserState(
        error: error,
      );

  @override
  List<Object?> get props => [success, loadingState, error, globalResponseModel];
}
