import 'dart:io';

class ProfileParameters {
  late String name;
  late String? email;
  late String? phone;
  late String? phoneCode;
  late String? device_token;
  late int? stateId;
  late int? step_id;
  late int? countryId;
  late File? image;
  ProfileParameters({
   required this.name,
    required this.email,
  required  this.phone,
    this.stateId,
    this.step_id,
    this.countryId,
    this.phoneCode,
    this.image,
    this.device_token,
  });
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (stateId != null) 'state_id': stateId,
      if (countryId != null) 'country_id': countryId,
      if (phoneCode != null) 'phoneCode': phoneCode,
      if (image?.path != null) 'image': image!.path,
      if (device_token != null) 'device_token': device_token,
      if (step_id != null) 'step_id': step_id,
      // Check if image is not null
      // 'first_name': firstName,
      // 'email': email,
      // 'phone': phone,
      // 'last_name': familyName,
      // 'gender': gender,
      // 'cityId': cityId,
      // 'countryId': countryId,
      // 'phoneCode': phoneCode,
      // 'image': image?.path, // Convert image to file path or null
    };
  }

  // void clear() {
  //   firstName = null;
  //   email = null;
  //   phone = null;
  //   familyName = null;
  //   gender = null;
  //   phoneCode = null;
  //   stateId = null;
  //   countryId = null;
  //   image = null;
  //   step_id = null;
  // }
}
