import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import '../../../../core/repos/lang_repo.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../../core/utils/data_utils.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../../products/models/product_model_api.dart';
import '../model/qr_reward_model.dart';
import '../model/rewards_model.dart';

class RewardsRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;

  RewardsRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
  });

  Future<Either<String, RewardsResponseModel>> getRewardsProgress() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getRewardsProgress(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);

      RewardsResponseModel rewardsResponseModel = RewardsResponseModel.fromJson(dataJson);
      if (rewardsResponseModel.error == true) {
        return Left(rewardsResponseModel.message);
      }
      return Right(rewardsResponseModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, QrRewardResponseModel>> getQrRewards() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getQrCodeRewards(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);

      QrRewardResponseModel qrRewardResponseModel = QrRewardResponseModel.fromJson(dataJson);
      if (qrRewardResponseModel.error == true) {
        return Left(qrRewardResponseModel.message);
      }
      return Right(qrRewardResponseModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<ProductModelApi>>> getRewardsProducts(String page) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getRewardFreeProducts({'page': page}),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      List<dynamic> list = dataJson['data'];
      return Right(validateJsonList(list.cast<Map<String, dynamic>>(), ProductModelApi.fromJson));
    } catch (e) {
      return Left(e.toString());
    }
  }
}
