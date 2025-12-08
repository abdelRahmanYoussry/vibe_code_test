import 'package:test_vibe/modules/app/products/repo/product_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/repos/lang_repo.dart';
import '../repo/points_repo.dart';
import 'points_state.dart';

class PointsBloc extends Cubit<PointsState> {
  PointsBloc({
    required this.authRepo,
    required this.cacheHelper,
    required this.langRepo,
    required this.productsRepo,
    required this.pointsRepo,
  }) : super(const PointsState());

  final AuthRepo authRepo;
  final LangRepo langRepo;
  final CacheHelper cacheHelper;
  final ProductsRepo productsRepo;
  final PointsRepo pointsRepo;

  Future<void> getHistoryPoints({bool isFiltered = false}) async {
    emit(state.copyWith(getHistoryPoints: state.getHistoryPoints.asLoading()));
    final result = await pointsRepo.getPointsHistory(isFilter: isFiltered);

    result.fold(
      (error) {
      debugPrint('Error getting points: $error');
        emit(
        state.copyWith(
          getHistoryPoints: state.getHistoryPoints.asLoadingFailed(error),
        ),
      );
      },
      (data) {
        emit(
        state.copyWith(
          getHistoryPoints: state.getHistoryPoints.asLoadingSuccess(
            success: true,
            data: data,
          ),
        ),
      );
      },
    );
  }

  Future<void> getUserPoints() async {
    emit(state.copyWith(getPointsState: state.getPointsState.asLoading()));
    final result = await pointsRepo.getPoints();

    result.fold(
      (error) {
        debugPrint('Error getting points: $error');
        emit(
          state.copyWith(
            getPointsState: state.getPointsState.asLoadingFailed(error),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            getPointsState: state.getPointsState.asLoadingSuccess(
              success: true,
              data: data,
            ),
          ),
        );
      },
    );
  }

  Future<void> transferPoints({required String phone ,required String amount }) async {
    emit(state.copyWith(transferPointsState: state.transferPointsState.asLoading()));
    final result = await pointsRepo.TransferPoints(amount: amount, phone: phone);

    result.fold(
      (error) {

        emit(
          state.copyWith(
            transferPointsState: state.transferPointsState.asLoadingFailed(error),
          ),
        );
      },
      (data) {
        emit(
          state.copyWith(
            transferPointsState: state.transferPointsState.asLoadingSuccess(
              success: true,
              data: data,
            ),
          ),
        );
      },
    );
  }

}
