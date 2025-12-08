import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';

import '../../../../core/repos/lang_repo.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../../core/utils/data_utils.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../../search/model/search_recent_model.dart';
import '../models/product_model_api.dart';

class ProductsRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;

  ProductsRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
  });

  Future<Either<String, List<ProductModelApi>>> getTopRequestedProducts(String page) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getTopRequestedProducts({'page': page, 'sort_by': 'most_viewed'}),
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

  Future<Either<String, List<ProductModelApi>>> getNewlyReleasedProducts(String page) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getNewlyReleasedProducts({'page': page, 'sort_by': 'newly_released'}),
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

  Future<Either<String, List<ProductModelApi>>> getSignaturesProducts(String page) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getSignatureProducts({'page': page, 'is_signature': '1'}),
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

  Future<Either<String, List<ProductModelApi>>> getSearchProductsResult(String keyWords) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.searchProducts(keyWords),
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

  Future<Either<String, SearchRecentModel>> getSearchRecentView() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getSearchRecentView(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      return Right(SearchRecentModel.fromJson(dataJson));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, GlobalResponseModel>> deleteRecentView({required int productId}) async {
    try {
      final rawData = await apiHelper.postData(
        AppConfig.deleteSearchRecentView(productId),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(dataJson);
      if (validString(globalResponseModel.showError())) {
        return Left(globalResponseModel.showError());
      }
      return Right(globalResponseModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, GlobalResponseModel>> addCommentToProduct({
    required int productId,
    required String Comment,
  }) async {
    try {
      final rawData = await apiHelper.postData(
        AppConfig.addCommentToProduct(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
        data: {'product_id': productId, 'comment': Comment},
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(dataJson);
      if (validString(globalResponseModel.showError())) {
        return Left(globalResponseModel.showError());
      }
      return Right(globalResponseModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductModelApi>> getProductDetails(int productId) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getProductDetails(productId),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      ProductModelApi productModelApi = ProductModelApi.fromJson(dataJson['data']);
      return Right(productModelApi);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
