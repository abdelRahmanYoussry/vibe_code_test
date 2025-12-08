import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:test_vibe/core/utils/order_count/order_count_bloc.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/app/orders/models/order_model.dart';
import 'package:test_vibe/modules/app/orders/models/order_detail_model.dart';
import 'package:test_vibe/modules/app/orders/models/update_order_params.dart';
import 'package:test_vibe/modules/app/orders/models/cancel_order_params.dart';
import 'package:test_vibe/modules/app/orders/update_cart_params.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import 'package:flutter/cupertino.dart';

import '../../../../core/repos/lang_repo.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../../core/utils/data_utils.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../models/track_order_model.dart';

class OrdersRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;

  OrdersRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
  });

  Future<Either<String, OrdersResponseModel>> getOrders(
      String page, String type) async {
    try {
      if (!validString(authRepo.token)) {
        await authRepo.checkUser();
      }
      final rawData = await apiHelper.getData(
        AppConfig.getOrders({'page': page, 'type': type}),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      OrdersResponseModel responseModel =
          OrdersResponseModel.fromJson(dataJson);
      final ordersCount = responseModel.activeOrdersCount;
      OrderCountBloc().setData(ordersCount);
      return Right(responseModel);
    } catch (e) {
      debugPrint('Error in getOrders: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, TrackOrderModel>> getTrackOrder() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.trackOrder(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      if (dataJson['error'] == true) {
        return Left(dataJson['message'] ?? getServerError());
      }
      return Right(TrackOrderModel.fromJson(dataJson['data']));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, GlobalResponseModel>> addMinutesToOrder(
      int minutes) async {
    try {
      final rawData = await apiHelper.postData(
        AppConfig.addMinutesToOrder(),
        data: {'added_minutes': minutes},
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      if (dataJson['error'] == true) {
        return Left(dataJson['message'] ?? getServerError());
      }
      GlobalResponseModel responseModel =
          GlobalResponseModel.fromJson(dataJson);
      if (responseModel.showError() != null) {
        return Left(responseModel.showError());
      }
      return Right(responseModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, GlobalResponseModel>> deleteOrder(int orderId) async {
    try {
      final rawData = await apiHelper.deleteData(
        AppConfig.deleteOrder(orderId),
        data: {},
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      if (dataJson['error'] == true) {
        return Left(dataJson['message'] ?? getServerError());
      }
      GlobalResponseModel responseModel =
          GlobalResponseModel.fromJson(dataJson);
      if (responseModel.showError() != null) {
        return Left(responseModel.showError()!);
      }
      return Right(responseModel);
    } catch (e) {
      debugPrint('Error in cancelOrder: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, GlobalResponseModel>> updateOrder(
      UpdateCartParams params) async {
    try {
      final Map<String, dynamic> requestData = {
        "id": params.orderId,
        "qty": params.quantity,
        "options": params.options,
        if (params.type != null) "type": params.type,
        if (params.isFreeDrink != null) "is_free_drink": params.isFreeDrink,
        if (params.rewardId != null) "reward_id": params.rewardId,
        if (params.isDrink != null) "is_drink": params.isDrink,
      };
      final rawData = await apiHelper.putData(
        AppConfig.updateOrder(params.orderId),
        data: requestData,
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      if (dataJson['error'] == true) {
        return Left(dataJson['message'] ?? getServerError());
      }
      GlobalResponseModel responseModel =
          GlobalResponseModel.fromJson(dataJson);
      if (responseModel.showError() != null) {
        return Left(responseModel.showError()!);
      }
      return Right(responseModel);
    } catch (e) {
      debugPrint('Error in updateOrder: $e');
      return Left(e.toString());
    }
  }

  /// Get order details by order ID
  Future<Either<String, OrderDetailResponseModel>> getOrderDetails(
      int orderId) async {
    try {
      if (!validString(authRepo.token)) {
        await authRepo.checkUser();
      }
      final rawData = await apiHelper.getData(
        AppConfig.getOrderDetails(orderId),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
        addAcceptJsonHeader: true,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      if (dataJson['error'] == true) {
        return Left(dataJson['message'] ?? getServerError());
      }
      OrderDetailResponseModel responseModel =
          OrderDetailResponseModel.fromJson(dataJson);
      return Right(responseModel);
    } catch (e) {
      debugPrint('Error in getOrderDetails: $e');
      return Left(e.toString());
    }
  }

  /// Update order with new API structure
  Future<Either<String, OrderDetailResponseModel>> updateOrderDetails(
      int orderId, UpdateOrderParams params) async {
    try {
      if (!validString(authRepo.token)) {
        await authRepo.checkUser();
      }
      final rawData = await apiHelper.putData(
        AppConfig.updateOrder(orderId),
        data: params.toJson(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      if (dataJson['error'] == true) {
        return Left(dataJson['message'] ?? getServerError());
      }
      OrderDetailResponseModel responseModel =
          OrderDetailResponseModel.fromJson(dataJson);
      return Right(responseModel);
    } catch (e) {
      debugPrint('Error in updateOrderDetails: $e');
      return Left(e.toString());
    }
  }

  /// Cancel an order
  Future<Either<String, GlobalResponseModel>> cancelOrder(
      int orderId, CancelOrderParams params) async {
    try {
      if (!validString(authRepo.token)) {
        await authRepo.checkUser();
      }
      final rawData = await apiHelper.postData(
        AppConfig.cancelOrder(orderId),
        data: params.toJson(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      if (dataJson['error'] == true) {
        return Left(dataJson['message'] ?? getServerError());
      }
      GlobalResponseModel responseModel =
          GlobalResponseModel.fromJson(dataJson);
      if (responseModel.showError() != null) {
        return Left(responseModel.showError()!);
      }
      return Right(responseModel);
    } catch (e) {
      debugPrint('Error in cancelOrder: $e');
      return Left(e.toString());
    }
  }

  /// Delete a product from an order
  Future<Either<String, OrderDetailResponseModel>> deleteOrderProduct(
      int orderId, int productId) async {
    try {
      if (!validString(authRepo.token)) {
        await authRepo.checkUser();
      }
      final rawData = await apiHelper.deleteData(
        AppConfig.deleteOrderProduct(orderId, productId),
        data: {},
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      if (dataJson['error'] == true) {
        return Left(dataJson['message'] ?? getServerError());
      }
      OrderDetailResponseModel responseModel =
          OrderDetailResponseModel.fromJson(dataJson);
      return Right(responseModel);
    } catch (e) {
      debugPrint('Error in deleteOrderProduct: $e');
      return Left(e.toString());
    }
  }
}
