import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:test_vibe/core/utils/cart_count/cart_count_bloc.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/app/cart/add_to_cart_params.dart';
import 'package:test_vibe/modules/app/cart/models/add_to_cart_model.dart';
import 'package:test_vibe/modules/app/products/repo/product_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/repos/lang_repo.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../../core/utils/remote/api_helper.dart';

class AddToCartRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;
  final ProductsRepo productsRepo;

  AddToCartRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
    required this.productsRepo,
  });

  Future<Either<String, AddToCartResponseModel>> addToCart(AddToCartParams params) async {
    try {
      final Map<String, dynamic> requestData = {
        "id": params.productId,
        "qty": params.quantity,
        "options": params.options,
        if (params.type != null) "type": params.type,
        if (params.isFreeDrink != null) "is_free_drink": params.isFreeDrink,
        if(params.rewardId != null) "reward_id": params.rewardId,
        if(params.isDrink != null) "is_drink": params.isDrink,
      };
      final rawData = await apiHelper.postData(
        AppConfig.addToCart(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
        data: requestData,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      AddToCartResponseModel addToCartResponseModel = AddToCartResponseModel.fromJson(dataJson);
      if (addToCartResponseModel.error == true) {
        return Left(addToCartResponseModel.message);
      }
      final list = addToCartResponseModel.data?.content;
      CartCountBloc().setData(list?.length??0);
      return Right(addToCartResponseModel);
    } catch (e) {
      debugPrint("Error in AddToCartRepo: ${e.toString()}");
      return Left(e.toString());
    }
  }

  Future<Either<String, AddToCartResponseModel>> getCart() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getCart(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      // if (rawData.isEmpty) {
      //   return Left(getServerError());
      // }
      final dataJson = await jsonDecode(rawData);
      AddToCartResponseModel addToCartResponseModel = AddToCartResponseModel.fromJson(dataJson);
      if (addToCartResponseModel.error == true) {
        return Left(addToCartResponseModel.message);
      }
      final list = addToCartResponseModel.data?.content;
      CartCountBloc().setData(list?.length??0);
      return Right(addToCartResponseModel);
    } catch (e) {
      debugPrint("Error in AddToCartRepo: ${e.toString()}");
      return Left(e.toString());
    }
  }

  Future<Either<String, AddToCartResponseModel>> updateCart(AddToCartParams params) async {
    try {
      final Map<String, dynamic> requestData = {
        "items": {
          params.rowId!: {
            "rowId": params.rowId,
            "values": {
              "qty": int.parse(validateString(params.quantity, "1")),
            },
          },
        },
      };
      final rawData = await apiHelper.postData(
        AppConfig.updateCartItem(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
        data: requestData,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      AddToCartResponseModel addToCartResponseModel = AddToCartResponseModel.fromJson(dataJson);
      if (addToCartResponseModel.error == true) {
        return Left(addToCartResponseModel.message);
      }
      return Right(addToCartResponseModel);
    } catch (e) {
      debugPrint("Error in AddToCartRepo: ${e.toString()}");
      return Left(e.toString());
    }
  }

  Future<Either<String, GlobalResponseModel>> deleteCartItem(String id) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.removeFromCart(id),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(dataJson);
      if (globalResponseModel.error == true) {
        return Left(globalResponseModel.showError());
      }
      return Right(globalResponseModel);
    } catch (e) {
      debugPrint("Error in AddToCartRepo: ${e.toString()}");
      return Left(e.toString());
    }
  }
}
