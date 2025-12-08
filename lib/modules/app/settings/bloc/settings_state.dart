import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/states/loading_state.dart';

class SettingsState extends Equatable {
  final ChangeLangState changeLangState;
  final GetLangState getLangState;
  final DeleteAccountState deleteAccountState;

  copyWith({
    ChangeLangState? changeLangState,
    GetLangState? getLangState,
    DeleteAccountState? deleteAccountState,
  }) {
    return SettingsState(
      changeLangState: changeLangState ?? this.changeLangState,
      getLangState: getLangState ?? this.getLangState,
      deleteAccountState: deleteAccountState ?? this.deleteAccountState,
    );
  }

  const SettingsState({
    this.changeLangState = const ChangeLangState(),
    this.getLangState = const GetLangState(),
    this.deleteAccountState = const DeleteAccountState(),
  });

  @override
  List<Object?> get props => [
        changeLangState,
        getLangState,
        deleteAccountState,
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

class GetLangState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final String? lang;

  const GetLangState({this.success, this.loadingState = const LoadingState(), this.error, this.lang});

  GetLangState asLoading() => const GetLangState(
        loadingState: LoadingState.loading(),
      );

  GetLangState asLoadingSuccess({bool? success, String? lang}) => GetLangState(success: success, lang: lang);

  GetLangState asLoadingFailed(String error) => GetLangState(
        error: error,
      );

  @override
  List<Object?> get props => [success, loadingState, error, lang];
}

class DeleteAccountState extends Equatable {
  final bool? success;
  final LoadingState loadingState;
  final String? error;
  final GlobalResponseModel? model;

  const DeleteAccountState({this.success, this.loadingState = const LoadingState(), this.error, this.model});

  DeleteAccountState asLoading() => const DeleteAccountState(
        loadingState: LoadingState.loading(),
      );

  DeleteAccountState asLoadingSuccess({bool? success, GlobalResponseModel? model}) =>
      DeleteAccountState(success: success, model: model);

  DeleteAccountState asLoadingFailed(String error) => DeleteAccountState(
        error: error,
      );

  @override
  List<Object?> get props => [
        success,
        loadingState,
        error,
        model,
      ];
}
