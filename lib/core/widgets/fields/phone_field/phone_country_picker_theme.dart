import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class PhoneCountryPickerTheme extends ThemeExtension<PhoneCountryPickerTheme> {
  static PhoneCountryPickerTheme of(BuildContext context) => Theme.of(context).extension<PhoneCountryPickerTheme>()!;

  final CountryListThemeData countryListThemeData;

  const PhoneCountryPickerTheme({
    required this.countryListThemeData,
  });

  @override
  ThemeExtension<PhoneCountryPickerTheme> copyWith({
    CountryListThemeData? countryListThemeData,
  }) =>
      PhoneCountryPickerTheme(
        countryListThemeData: countryListThemeData ?? this.countryListThemeData,
      );

  @override
  PhoneCountryPickerTheme lerp(PhoneCountryPickerTheme? other, double t) {
    if (other == null) return this;
    return PhoneCountryPickerTheme(
      countryListThemeData: other.countryListThemeData,
    );
  }
}
