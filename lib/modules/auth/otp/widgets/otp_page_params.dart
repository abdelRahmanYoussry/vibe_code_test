import 'package:country_picker/country_picker.dart';
import 'package:test_vibe/core/parameters/register_parameters.dart';
import 'package:equatable/equatable.dart';

class OtpPageParams extends Equatable {
  final String phoneNumber;
  final Country country;
  // final LoginBloc bloc;

  const OtpPageParams({
    required this.country,
    required this.phoneNumber,
    // required this.bloc,
  });

  @override
  List<Object?> get props => [
        country,
        // bloc,
        phoneNumber,
      ];
}


class RegisterOtpPageParams extends Equatable {
  final String phoneNumber;
  final Country country;
  final ProfileParameters profilePageParams;

  const RegisterOtpPageParams({
    required this.country,
    required this.phoneNumber,
    required this.profilePageParams,
  });

  @override
  List<Object?> get props => [
    country,
    profilePageParams,
    phoneNumber,
  ];
}
