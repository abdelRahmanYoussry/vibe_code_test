import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:test_vibe/core/utils/cart_count/cart_count_bloc.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/app/products/repo/product_repo.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import '../../../../core/repos/lang_repo.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../../core/utils/data_utils.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../models/coupons_model.dart';
import '../models/final_check_out_model.dart';
import '../models/order_payment_status_modle.dart';

class CheckOutRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;
  final ProductsRepo productsRepo;

  CheckOutRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
    required this.productsRepo,
  });

  Future<Either<String, List<CouponModel>>> getCoupons() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getCoupons(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      List<dynamic> list = dataJson['data'];
      return Right(validateJsonList(list.cast<Map<String, dynamic>>(), CouponModel.fromJson));
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, GlobalResponseModel>> validateCoupon({required String coupon}) async {
    try {
      final rawData = await apiHelper.postData(
        AppConfig.validateCoupon(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
        data: {
          'code': coupon,
        },
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

  Future<Either<String, FinalCheckOutResponseModel>> checkOutOrder({required String payType}) async {
    try {
      final rawData = await apiHelper.postData(
        AppConfig.checkOrder(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
        data: {
          'type': payType,
        },
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      FinalCheckOutResponseModel finalCheckOutResponseModel = FinalCheckOutResponseModel.fromJson(dataJson);
      if(finalCheckOutResponseModel.error == true){
        return Left(finalCheckOutResponseModel.message);
      }
      // GlobalResponseModel globalResponseModel = GlobalResponseModel.fromJson(dataJson);
      // if (validString(globalResponseModel.showError())|| dataJson['order_id'] == null) {
      //   return Left(globalResponseModel.message ?? "Something went wrong");
      // }

    await  CartCountBloc().getCartCount();
      return Right(finalCheckOutResponseModel);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, OrderPaymentStatusModel>> checkOrderStatus({required String OrderId}) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.checkOrderStatus(OrderId),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
        addAcceptJsonHeader: true,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      OrderPaymentStatusModel orderPaymentStatusModel = OrderPaymentStatusModel.fromJson(dataJson);
      if(orderPaymentStatusModel.error == true){
        return Left(orderPaymentStatusModel.message);
      }
      return Right(orderPaymentStatusModel);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
