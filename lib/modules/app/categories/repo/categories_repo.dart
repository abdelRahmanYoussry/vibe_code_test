import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/app/categories/models/category_model.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';

import '../../../../core/repos/lang_repo.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../../core/utils/data_utils.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../../products/models/product_model_api.dart';
import '../models/sub_category_model.dart';

class CategoriesRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;

  CategoriesRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
  });

  Future<Either<String, List<CategoryModel>>> getCategories(String page) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getAllCategories({'page': page}),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      List<dynamic> list = dataJson['data'];
      return Right(validateJsonList(list.cast<Map<String, dynamic>>(), CategoryModel.fromJson));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, List<ProductModelApi>>> getProductsForCategory(int categoryId, String page) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getProductsByCategory(categoryId, {'page': page}),
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

  // Future<Either<String,List<SubCategoryModel>>> getSubCategories(int categoryId,String page) async {
  //   try {
  //     final rawData = await apiHelper.getData(
  //       AppConfig.getSubCategories(categoryId: categoryId, params: {'page': page}),
  //       lang: langRepo.lang,
  //       typeJSON: true,
  //       token: authRepo.token,
  //     );
  //     if (rawData.isEmpty) {
  //       return Left(getServerError());
  //     }
  //     final dataJson = await jsonDecode(rawData);
  //     List<dynamic> list = dataJson['data'];
  //     return Right(validateJsonList(list.cast<Map<String, dynamic>>(), SubCategoryModel.fromJson));
  //   } catch (e) {
  //     return Left(e.toString());
  //   }
  // }
  Future<Either<String, List<SubCategoryModel>>> getSubCategories(int categoryId, String page) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getSubCategories(categoryId: categoryId, params: {'page': page}),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);

      // Handle both single object and list scenarios
      final data = dataJson['data'];
      List<SubCategoryModel> subCategories = [];

      if (data is List) {
        // Case 1: data is a list of subcategories
        subCategories = validateJsonList(data.cast<Map<String, dynamic>>(), SubCategoryModel.fromJson);
      } else if (data is Map<String, dynamic>) {
        // Case 2: data is a single subcategory object
        subCategories = [SubCategoryModel.fromJson(data)];
      }

      return Right(subCategories);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
