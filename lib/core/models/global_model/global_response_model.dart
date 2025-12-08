

import '../../utils/data_utils.dart';

class GlobalResponseModel {
  final String? errors;
  final String? message;
  final bool? error;
  final dynamic data;

  GlobalResponseModel({this.error = false, this.errors, this.message, this.data});

  static fromJson(Map<String, dynamic> data) {
    // print(data);
    return GlobalResponseModel(
      error: data["error"] == true,
      message: data["message"],
      data: data["data"],
      errors: data["errors"] != null ? getError(data["errors"]) : null,
    );
  }

  showError() {
    return !validString(errors) ? (error == true ? message : null) : errors;
  }

  static String getError(data) {
    String error = '';
    if (data is Map) {
      for (int i = 0; i < ((data)).keys.length; i++) {
        final f = (((data))[((data)).keys.elementAt(i)]);

        error += "\n${(f is List) ? f.first : f}";
      }
    }
    return error;
  }
}
