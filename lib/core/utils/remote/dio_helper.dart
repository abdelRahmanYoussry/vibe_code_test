import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_app_config.dart';
abstract class DioHelper {
  Future<dynamic> postMultiPart(String url, {dynamic data, String? token, required String lang});
}

class DioImpl extends DioHelper {
  final Dio dioCode = Dio(
    BaseOptions(
      baseUrl: AppConfig.baseUrl,
      receiveDataWhenStatusError: true,
    ),
  )..interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
    ),);

  @override
  Future postMultiPart(String url, {dynamic data, String? token, required String lang}) async {
    dioCode.options.headers = token != null
        ? {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token',
            'lang': lang,
          }
        : {
            'Content-Type': 'application/x-www-form-urlencoded',
            'Accept': 'application/json',
            'lang': lang,
          };

    if (url.contains('??')) {
      url = url.replaceAll('??', '?');
    }
    return await _request(
      () async => await dioCode.post(url, data: data),
      url,
      data,
    );
  }
}

extension on DioHelper {
  Future _request(Future<Response> Function() request, String url, data) async {
    try {
      var r = await request.call();
      return r.data;
    } on DioException catch (e) {
      if (e.response!.statusCode == 422) {
        return e.response!.data;
      }
      debugPrint('_request error $e');
      debugPrint('_request error $e.response');
      rethrow;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }
}
