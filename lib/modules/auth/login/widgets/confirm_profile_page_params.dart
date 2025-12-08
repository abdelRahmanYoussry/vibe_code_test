import 'package:country_picker/country_picker.dart';
import 'package:equatable/equatable.dart';


class ConfirmNamePageParams extends Equatable {
final String phone;
final Country country;
  const ConfirmNamePageParams({ required this.phone, required this.country});

  @override
  List<Object?> get props => [
        phone,
        country,

      ];
}
