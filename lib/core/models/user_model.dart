import 'package:test_vibe/core/models/global_model/global_response_model.dart';
import 'package:test_vibe/modules/app/branches/models/branch_model.dart';
import 'package:equatable/equatable.dart';

import '../utils/data_utils.dart';

class UserModel extends GlobalResponseModel with EquatableMixin {
  final UserData userData;

  UserModel({
    required super.message,
    required super.error,
    required this.userData,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userData: UserData.fromJson(json['data'], json['data']['access_token']?.toString()),
      message: json["message"],
      error:json['error'],
    );
  }
  @override
  List<Object?> get props => [
        userData,
      ];
}

class UserData {
  final String id;
  final String name;
  final String dob;
  final String email;
  final String phone;
  final String token;
  final String? created_at;
  final String? updated_at;
  final String? confirmed_at;
  final StatusData? status;
  final bool? is_featured;
  final bool? is_vendor;
  final String? points;
  final String? verification_code;
  final String? verification_code_expires_at;
  String? avatar;
  BranchModel? store_locator;

  UserData({
    required this.id,
    required this.name,
    required this.phone,
    required this.dob,
    required this.email,
    required this.token,
    this.created_at,
    this.updated_at,
    this.confirmed_at,
    this.avatar,
    this.points,
    this.status,
    this.is_featured,
    this.is_vendor,
    this.verification_code,
    this.verification_code_expires_at,
    this.store_locator,
  });

  factory UserData.fromJson(Map<String, dynamic> json, [String? token]) {
    return UserData(
      id: validateString(json['id']?.toString()),
      name: validateString(json['name']?.toString()),
      phone: validateString(json['phone']?.toString()),
      avatar: json['avatar'] == null ? null : validateString(json['avatar']?.toString()),
      email: validateString(json['email']?.toString()),
      token: token ?? validateString(json['access_token']?.toString()),
      points: validateString(json['points']?.toString()),
      dob: validateString(json['dob']?.toString()),
      created_at: json['created_at'] == null ? null : validateString(json['created_at']?.toString()),
      updated_at: json['updated_at'] == null ? null : validateString(json['updated_at']?.toString()),
      confirmed_at:
          json['confirmed_at'] == null ? null : validateString(json['confirmed_at']?.toString()),
      status: json['status'] == null ? null : StatusData.fromJson(json['status'] ?? {}),
      is_featured: json['is_featured'] == null
          ? null
          : json['is_featured'] == 0
              ? false
              : true,
      is_vendor: json['is_vendor'] == null
          ? null
          : json['is_vendor'] == 0
              ? false
              : true,
      verification_code: json['verification_code'] == null
          ? null
          : validateString(json['verification_code']?.toString()),
      verification_code_expires_at: json['verification_code_expires_at'] == null
          ? null
          : validateString(json['verification_code_expires_at']?.toString()),
      store_locator: json['store_locator'] == null ? null : BranchModel.fromJson(json['store_locator'] ?? {}),
    );
  }
  Map<String, dynamic> toJson() => {
        'data': {
          if (validString(id)) 'id': id,
          if (validString(name)) 'name': name,
          if (validString(phone)) 'phone': phone,
          if (validString(avatar)) 'avatar': avatar,
          if (validString(dob)) 'dob': dob,
          if (validString(created_at)) 'created_at': created_at,
          if (validString(updated_at)) 'updated_at': updated_at,
          if (validString(confirmed_at)) 'confirmed_at': confirmed_at,
          if (status != null) 'status': status!.toJson(),
          if (is_featured != null) 'is_featured': is_featured == true ? 1 : 0,
          if (is_vendor != null) 'is_vendor': is_vendor == true ? 1 : 0,
          if (validString(verification_code)) 'verification_code': verification_code,
          if (validString(verification_code_expires_at)) 'verification_code_expires_at': verification_code_expires_at,
          if (validString(email)) 'email': email,
          if (validString(points)) 'points': points,
          if (store_locator != null) 'store_locator': store_locator?.toJson(),
            'access_token': token,
        },
      };
}

class StatusData {
  final String? value;
  final String? label;

  StatusData({
    this.value,
    this.label,
  });

  factory StatusData.fromJson(Map<String, dynamic> json) {
    return StatusData(
      value: json['value'] == null ? null : validateString(json['value']?.toString()),
      label: json['label'] == null ? null : validateString(json['label']?.toString()),
    );
  }

  Map<String, dynamic> toJson() => {
        if (validString(value)) 'value': value,
        if (validString(label)) 'label': label,
      };
}
