import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_vibe/core/repos/lang_repo.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../auth/repo/auth_repo.dart';
import 'settings_state.dart';

class SettingsBloc extends Cubit<SettingsState> {
  SettingsBloc({
    required this.langRepo,
    required this.cacheHelper,
    required this.authRepo,
  }) : super(const SettingsState());

  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final AuthRepo authRepo;

  Future<void> changeLang(String lang, BuildContext context) async {
    emit(
      state.copyWith(
        changeLangState: state.changeLangState.asLoading(),
      ),
    );

    final result = await langRepo.setLang(lang, context);

    result.fold(
      (error) {
        emit(
          state.copyWith(
            changeLangState: state.changeLangState.asLoadingFailed(error),
          ),
        );
      },
      (_) async {
        debugPrint('22222222222222222');
        debugPrint(lang);
        emit(
          state.copyWith(
            changeLangState: state.changeLangState.asLoadingSuccess(
              success: true,
              lang: lang,
            ),
          ),
        );
        await getLang();
      },
    );
  }

  Future<void> getLang() async {
    emit(
      state.copyWith(
        getLangState: state.getLangState.asLoading(),
      ),
    );

    final result = await langRepo.getLang();

    result.fold(
      (error) {
        emit(
          state.copyWith(
            getLangState: state.getLangState.asLoadingFailed(error),
          ),
        );
      },
      (lang) {
        debugPrint(lang);
        emit(
          state.copyWith(
            getLangState: state.getLangState.asLoadingSuccess(
              success: true,
              lang: lang,
            ),
          ),
        );
      },
    );
  }

  Future<void> deleteAccount() async {
    emit(
      state.copyWith(
        deleteAccountState: state.deleteAccountState.asLoading(),
      ),
    );

    final result = await authRepo.deleteAccount();

    result.fold(
      (error) {
        emit(
          state.copyWith(
            deleteAccountState: state.deleteAccountState.asLoadingFailed(error),
          ),
        );
      },
      (model) {
        emit(
          state.copyWith(
            deleteAccountState: state.deleteAccountState.asLoadingSuccess(
              success: true,
              model: model,
            ),
          ),
        );
      },
    );
  }

// static SettingsBloc of(BuildContext context) => BlocProvider.of<SettingsBloc>(context);
}
