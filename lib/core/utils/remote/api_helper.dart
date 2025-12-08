import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:event_bus/event_bus.dart';
import 'package:http/http.dart' as http;

import '../data_utils.dart';
import '../states/generic_state.dart';
import 'api_app_config.dart';



abstract class ApiHelper {
  Future<String> getData(
    String url, {
    String? token,
    String queries,
    Map<String, String> headers = const {},
    bool typeJSON = true,
    bool signOutOn = true,
    String? lang,
    bool validateByStatusCode = false,
    bool addAcceptJsonHeader  = false,
  });

  Future<String> postData(
    String url, {
    String? token,
    Map<String, dynamic> data,
    Map<String, String> headers,
    bool typeJSON = true,
    bool signOutOn = true,
    String? lang,
    bool validateByStatusCode = false,
  });

  Future<String> patchData(
    String url, {
    String? token,
    Map<String, dynamic> data,
    Map<String, String> headers,
    bool typeJSON = true,
    bool signOutOn = true,
    String? lang,
    bool validateByStatusCode = false,
  });

  Future<String> putData(
    String url, {
    String? token,
    Map<String, dynamic> data,
    Map<String, String> headers,
    bool typeJSON = true,
    bool signOutOn = true,
    String? lang,
    bool validateByStatusCode = false,
  });

  Future<dynamic> deleteData(
    String url, {
    String? token,
    Map<String, String> headers,
    Map<String, String> data,
    bool typeJSON = true,
    bool signOutOn = true,
    String? lang,
    bool validateByStatusCode = false,
  });
}

class ApiImpl extends ApiHelper {
  ApiImpl({
    String? baseUrl,
  }) : baseUrl = baseUrl ?? AppConfig.baseUrl;

  final String baseUrl;

  @override
  Future<String> getData(
    String url, {
    String? token,
    String queries = '',
    Map<String, String> headers = const {},
    bool typeJSON = false,
    bool signOutOn = true,
    String? lang,
    bool addAcceptJsonHeader  = false,
    bool validateByStatusCode = false,
  }) async {
    final base = baseUrl;
    String req =  '$base$url$queries' ;
    if (req.contains('??')) {
      req = req.replaceAll('??', '?');
    }
    final headersAll = {
      ...headers,
      if (validString(token)) "Authorization": "Bearer $token",
      if (typeJSON) 'Content-Type': 'application/json',
      if (addAcceptJsonHeader) 'Accept': 'application/json',
      if (lang != null) 'lang': lang,
    };
    return await _request(
      () async => await http.get(
        Uri.parse(req),
        headers: headersAll,
      ),
      req,
      method: 'GET',
      headers: headersAll,
      signOutOn: signOutOn,
      validateByStatusCode: validateByStatusCode,
    );
  }

  @override
  Future<String> postData(
    String url, {
    String? token,
    Map<String, dynamic> data = const {},
    Map<String, String> headers = const {},
    bool typeJSON = false,
    bool signOutOn = true,
    String? lang,
    bool validateByStatusCode = false,
  }) async {
    final base = baseUrl;
    String req = '$base$url';
    if (req.contains('??')) {
      req = req.replaceAll('??', '?');
    }
    final headersAll = {
      ...headers,
      if (validString(token)) "Authorization": "Bearer $token",
      if (typeJSON) 'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (lang != null) 'lang': lang,
    };
    return await _request(
      () async => await http.post(
        Uri.parse(req),
        headers: headersAll,
        body: jsonEncode(data),
      ),
      req,
      method: 'POST',
      headers: headersAll,
      data: data,
      signOutOn: signOutOn,
      validateByStatusCode: validateByStatusCode,
    );
  }

  @override
  Future<String> patchData(
    String url, {
    String? token,
    Map<String, dynamic> data = const {},
    Map<String, String> headers = const {},
    bool signOutOn = true,
    bool typeJSON = false,
    String? lang,
    bool validateByStatusCode = false,
  }) async {
    String req = '$baseUrl$url';
    if (req.contains('??')) {
      req = req.replaceAll('??', '?');
    }
    final headersAll = {
      ...headers,
      if (validString(token)) "Authorization": "Bearer $token",
      if (typeJSON) 'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (lang != null) 'lang': lang,
    };
    return await _request(
      () async => await http.patch(
        Uri.parse(req),
        headers: headersAll,
        body: jsonEncode(data),
      ),
      req,
      method: 'POST',
      headers: headersAll,
      signOutOn: signOutOn,
      data: data,
      validateByStatusCode: validateByStatusCode,
    );
  }

  @override
  Future<String> putData(String url,
      {String? token,
      Map<String, dynamic> data = const {},
      Map<String, String> headers = const {},
      bool typeJSON = false,
      bool signOutOn = true,
      String? lang,
      bool validateByStatusCode = false,}) async {
    String req = '$baseUrl$url';
    if (req.contains('??')) {
      req = req.replaceAll('??', '?');
    }
    final headersAll = {
      ...headers,
      if (validString(token)) "Authorization": "Bearer $token",
      if (typeJSON) 'Accept': 'application/json',
      'Content-Type': 'application/json',
      if (lang != null) 'lang': lang,
    };
    return await _request(
        () async => await http.put(
              Uri.parse(req),
              headers: headersAll,
              body: jsonEncode(data),
            ),
        req,
        method: 'POST',
        headers: headersAll,
        data: data,
        signOutOn: signOutOn,
        validateByStatusCode: validateByStatusCode,);
  }

  @override
  Future deleteData(String url,
      {String? token,
      Map<String, String> headers = const {},
      Map<String, String> data = const {},
      bool typeJSON = false,
      bool signOutOn = true,
      String? lang,
      bool validateByStatusCode = false,}) async {
    String req = '$baseUrl$url';
    if (req.contains('??')) {
      req = req.replaceAll('??', '?');
    }
    final headersAll = {
      ...headers,
      if (validString(token)) "Authorization": "Bearer $token",
      if (typeJSON) 'Accept': 'application/json',
      if (lang != null) 'lang': lang,
    };
    return await _request(
      () async => await http.delete(
        Uri.parse(req),
        headers: headersAll,
        body: data,
      ),
      req,
      method: 'Delete',
      headers: headersAll,
      validateByStatusCode: validateByStatusCode,
      data: data,
      signOutOn: signOutOn,
    );
  }
}

extension on ApiHelper {
  Future<String> _request(
    Future<http.Response> Function() request,
    String url, {
    Map<String, String>? headers,
    Map<String, dynamic>? data,
    required bool signOutOn,
    required String method,
    required bool validateByStatusCode,
  }) async {
    try {
      log('Call URL => $url');
      log('Call Method => $method');
      log('Call Headers => ${prettify(headers)}');
      log('Call Data => ${prettify(data)}');

      var r = await request.call();

      log('Response URL => ${r.request?.url}');
      log('Response Method => ${r.request?.method}');
      log('Response Headers => ${prettify(headers)}');
      log('Response Data => ${prettify(data)}');
      log('Response Code => ${r.statusCode}');
      log('Response Body => ${r.body}');
      log('Response message => ${jsonDecode(r.body)['message']}');
      if (r.statusCode == 401 && signOutOn) {
        eventBus.fire(UserLoggedOutEvent());
      }
      if (r.statusCode == 401) {
        eventBus.fire(UserLoggedOutEvent());
      }

      if (r.statusCode == 500) {
        return throw ServerFailure();
      }
      if (r.statusCode == 404 && validateByStatusCode) {
        throw r.statusCode;
      }
      return r.body;
    } catch (e, s) {
      log(e.toString());
      log(s.toString());
      rethrow;
    }
  }
}

EventBus eventBus = EventBus();

class UserLoggedOutEvent {
  UserLoggedOutEvent();
}

class GetUserOrdersEvent {}




class RefreshBuyXGetYEvent {}
