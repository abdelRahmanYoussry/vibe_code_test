import 'dart:convert';
import 'dart:developer';
import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';
import '../../../../core/repos/lang_repo.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../../core/utils/remote/api_app_config.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../models/point_model_new.dart';
import '../models/wallet_balance_model.dart';

class PointsRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;

  PointsRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
  });

  Future<Either<String, PointsResponse>> getPointsHistory({bool isFilter = false}) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getPointsHistory(),
        lang: langRepo.lang,
        typeJSON: false,
        token: authRepo.token,
        addAcceptJsonHeader: true,
      );

      if (rawData.isEmpty) {
        return Left(getServerError());
      }

      final dataJson = await jsonDecode(rawData);
      PointsResponse pointsResponse = PointsResponse.fromJson(dataJson);
      if (isFilter) {
        pointsResponse = _filterTransferInData(pointsResponse);
      }
      pointsResponse.history.forEach((key, value) {
         debugPrint('key: $key, value: $value');
      },);
      return Right(pointsResponse);
    } catch (e) {
      debugPrint('Error in PointsRepo.getPointsHistory: $e');
      return Left(e.toString());
    }
  }

  PointsResponse _filterTransferInData(PointsResponse originalResponse) {
    Map<String, List<LoyaltyPointEntry>> filteredHistory = {};

    // Filter history by transfer_in action
    if (originalResponse.history.isNotEmpty) {
      originalResponse.history.forEach((key, value) {
        List<LoyaltyPointEntry> filteredList = value.where((item) {
          return item.action == 'transfer_in';
        }).toList();

        if (filteredList.isNotEmpty) {
          filteredHistory[key] = filteredList;
        }
      });
    }

    // Return new PointsResponse with filtered data directly
    return PointsResponse(
      error: originalResponse.error,
      totalPoints: originalResponse.totalPoints,
      conversionText: originalResponse.conversionText,
      history: filteredHistory,
      message: originalResponse.message,
    );
  }

  Future<Either<String, PointsWalletData>> getPoints() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getPoints(),
        lang: langRepo.lang,
        typeJSON: false,
        token: authRepo.token,
        addAcceptJsonHeader: true,
      );

      if (rawData.isEmpty) {
        return Left(getServerError());
      }

      final dataJson = await jsonDecode(rawData);
      PointsWalletResponseModel pointsWalletResponse = PointsWalletResponseModel.fromJson(dataJson);
      if (pointsWalletResponse.error) {
        return Left(pointsWalletResponse.message);
      }
      return Right(pointsWalletResponse.data);
    } catch (e) {
      debugPrint('Error in PointsRepo.getPoints: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, GlobalResponseModel>> TransferPoints({required String amount, required String phone}) async {
    try {
      final rawData = await apiHelper.postData(
        AppConfig.transferPoints(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
        data: {
          "points_to_transfer": amount,
          "phone": phone,
        },
      );

      if (rawData.isEmpty) {
        return Left(getServerError());
      }

      final dataJson = await jsonDecode(rawData);
      if (dataJson == null) {
        return Left(getServerError());
      }

      GlobalResponseModel pointsWalletResponse = GlobalResponseModel.fromJson(dataJson);
      final errorMessage = pointsWalletResponse.showError();
      if (errorMessage != null && errorMessage.isNotEmpty ||
          pointsWalletResponse.error == true ||
          (pointsWalletResponse.message?.contains('Insufficient points') ?? false)) {
        return Left(errorMessage ?? pointsWalletResponse.message);
      }
      return Right(pointsWalletResponse);
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      return Left(getServerError());
    }
  }
}
