import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:test_vibe/core/utils/remote/api_app_config.dart';
import 'package:test_vibe/modules/app/branches/models/branch_model.dart';
import 'package:test_vibe/modules/auth/repo/auth_repo.dart';

import '../../../../../../../../core/repos/lang_repo.dart';
import '../../../../../../../../core/theme/constants/app_strings.dart';
import '../../../../../../../../core/utils/data_utils.dart';
import '../../../../../../../../core/utils/remote/api_helper.dart';



class BranchesRepo {
  final ApiHelper apiHelper;
  final LangRepo langRepo;
  final AuthRepo authRepo;

  BranchesRepo({
    required this.apiHelper,
    required this.langRepo,
    required this.authRepo,
  });

  Future<Either<String,List<BranchModel>>> getBranches(String page) async {
    try {
      final rawData = await apiHelper.getData(
        AppConfig.getBranches({'page': page}),
        lang: langRepo.lang,
        typeJSON: true,
        token: authRepo.token,
      );
      if (rawData.isEmpty) {
        return Left(getServerError());
      }
      final dataJson = await jsonDecode(rawData);
      List<dynamic> list = dataJson['data']['data'] ;
      return Right(validateJsonList(list.cast<Map<String, dynamic>>(), BranchModel.fromJson));
    } catch (e) {
      return Left(e.toString());
    }
  }


  Future<Either<String,GlobalResponseModel>> assignBranchToUser({required int branchId}) async {
    try {
      final rawData = await apiHelper.postData(
        AppConfig.assignBranchToUser(branchId),
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



}
