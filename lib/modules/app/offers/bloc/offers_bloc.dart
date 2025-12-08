import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';

import '../repo/offers_repo.dart';
import 'offers_state.dart';

class SpecialOffersBloc extends Cubit<SpecialOffersState> {
  SpecialOffersBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.offersRepo,
  }) : super(const SpecialOffersState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final OffersRepo offersRepo;

  Future<void> getAllSpecialOffers() async {
    emit(state.copyWith(getAllSpecialOffersState: state.getAllSpecialOffersState.asLoading()));
    final f = await offersRepo.getAllSpecialOffers();
    f.fold(
      (l) => emit(
        state.copyWith(
          getAllSpecialOffersState: state.getAllSpecialOffersState.asLoadingFailed(l),
        ),
      ),
      (r) {
        emit(
          state.copyWith(
            getAllSpecialOffersState: state.getAllSpecialOffersState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }


}
