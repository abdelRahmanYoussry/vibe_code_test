
import 'package:test_vibe/modules/app/home/widgets/home_appbar/widgets/my_location_widget/repo/branches_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../../../core/cache/cache_helper.dart';
import '../../../../../../../../core/repos/lang_repo.dart';

import 'branches_state.dart';

class BranchesBloc extends Cubit<BranchesState> {
  BranchesBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.branchesRepo,
  }) : super(const BranchesState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final BranchesRepo branchesRepo;

  int branchPageNumber = 1;
  bool branchIsLastPage = false;

  Future<void> getBranches() async {
    branchPageNumber = 1;
    emit(state.copyWith(allBranchesDataState: state.allBranchesDataState.asLoading()));
    final f = await branchesRepo.getBranches(branchPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          allBranchesDataState: state.allBranchesDataState.asLoadingFailed(l),
        ),
      ),
      (r) {
        branchPageNumber = 2;
        if (r.length != 10) {
          branchIsLastPage = true;
        } else {
          branchIsLastPage = false;
        }
        emit(
          state.copyWith(
            allBranchesDataState: state.allBranchesDataState.asLoadingSuccess(data: r, success: true),
          ),
        );
      },
    );
  }

  Future<void> getMoreBranches() async {
    if (state.allBranchesDataState.loadingState.loading ||
        state.allBranchesDataState.loadingState.reloading ||
        branchIsLastPage) {
      return;
    }
    emit(state.copyWith(allBranchesDataState: state.allBranchesDataState.asReloading()));
    final f = await branchesRepo.getBranches(branchPageNumber.toString());
    f.fold(
      (l) => emit(
        state.copyWith(
          allBranchesDataState: state.allBranchesDataState.asReloadingFailed(l),
        ),
      ),
      (r) {
        branchPageNumber += 1;
        if (r.length != 10) {
          branchIsLastPage = true;
        } else {
          branchIsLastPage = false;
        }
        emit(
          state.copyWith(
            allBranchesDataState: state.allBranchesDataState.asLoadingMoreSuccess(r),
          ),
        );
      },
    );
  }

  Future<void> assignBranchToUser({
    required int branchId,
  }) async {
    emit(state.copyWith(assignBranchToUserState: state.assignBranchToUserState.asLoading()));
    final f = await branchesRepo.assignBranchToUser(branchId: branchId);
    f.fold(
      (l) => emit(
        state.copyWith(
          assignBranchToUserState: state.assignBranchToUserState.asLoadingFailed(l),
        ),
      ),
      (r) async {
        // cacheHelper.setSelectedBranch(r);
        emit(
          state.copyWith(
            assignBranchToUserState: state.assignBranchToUserState.asLoadingSuccess(
              assignBranchModel: r,
              success: true,
            ),
          ),
        );
       await authRepo.getProfile(getNewData: true);
      },
    );
  }
}
