import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import '../../../../core/repos/lang_repo.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../../core/utils/data_utils.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../../products/models/product_model_api.dart';
import '../models/spinner_model_new.dart';
import '../models/spinner_reward_model.dart';

class SpinnersRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;

  SpinnersRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
  });

  Future<Either<String, List<SpinnerModel>>> getAllSpinners() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getAllSpinners(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      List<dynamic> list = dataJson['data'];
      return Right(validateJsonList(list.cast<Map<String, dynamic>>(), SpinnerModel.fromJson));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, SpinnerRewardResult>> spinTheWheel(int id) async {
    try {
      final rawData = await apiHelper.postData(
        AppConfig.spinTheWheel(id),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      SpinnerRewardResult result = SpinnerRewardResult.fromJson(dataJson);
      if (result.rewardId == null || result.rewardName == null) {
        return Left(getServerError());
      }
      return Right(result);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<ProductModelApi>>> getSpinnerFreeProducts(String page) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getSpinnerFreeProducts({'page': page}),
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

  Future<Either<String, List<ProductModelApi>>> getBuyOneGetOneFreeProducts(String page,String type) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getBuyOneGetOneFree({'page': page,'type':type}),
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
