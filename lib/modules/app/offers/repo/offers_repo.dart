import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';
import '../../../../core/repos/lang_repo.dart';
import '../../../../core/theme/constants/app_strings.dart';
import '../../../../core/utils/data_utils.dart';
import '../../../../core/utils/remote/api_helper.dart';
import '../models/special_offers_model.dart';



class OffersRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;

  OffersRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
  });

  Future<Either<String, List<FlashSaleModel>>> getAllSpecialOffers() async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getAllSpecialOffers(),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      List<dynamic> list = dataJson['data']['flash_sales'];
      return Right(validateJsonList(list.cast<Map<String, dynamic>>(), FlashSaleModel.fromJson));
    } catch (e) {
      return Left(e.toString());
    }
  }




}
