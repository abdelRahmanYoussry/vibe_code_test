import 'package:country_picker/country_picker.dart';
import 'package:dash_flags/dash_flags.dart' as flags;
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/utils/constants.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/fields/field_label.dart';
import 'package:test_vibe/core/widgets/fields/phone_field/custom_phone_formatter.dart';
import 'package:test_vibe/core/widgets/fields/phone_field/phone_country_picker_theme.dart';
import 'package:test_vibe/core/widgets/fields/search_field/search_field.dart';
import 'package:test_vibe/core/widgets/snack_bar/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class PhoneField extends StatefulWidget {
  const PhoneField({
    super.key,
    required this.textInputAction,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.onValidated,
    this.onCountryPicked,
    this.autoFocus = false,
    this.enable = true,
    this.userCountry,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final ValueChanged<Country>? onCountryPicked;
  final ValueChanged<bool>? onValidated;
  final bool autoFocus;
  final TextInputAction textInputAction;
   final bool enable ;
   final Country? userCountry;
  @override
  State<PhoneField> createState() => _PhoneFieldState();
}

class _PhoneFieldState extends State<PhoneField> {
  late Country country;
  int? maskLength;
  late final FocusNode focusNode;
  late final TextEditingController controller;
  @override
  void initState() {
    super.initState();
    country = widget.userCountry ?? kDefaultCountry;
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      controller.dispose();
    }
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(country.phoneCode);
    return FieldLabel(
      label: Loc.of(context).phone,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextFormField(
          controller: controller,
          focusNode: focusNode,
          textDirection: TextDirection.ltr,
          onTapOutside: (event) => focusNode.unfocus(),
          onFieldSubmitted: widget.onFieldSubmitted,
          keyboardType: TextInputType.phone,
          enabled: widget.enable,
          textInputAction: widget.textInputAction,

          autofillHints: const [
            AutofillHints.telephoneNumber,
            AutofillHints.telephoneNumberLocal,
            AutofillHints.telephoneNumberNational,
            AutofillHints.telephoneNumberDevice,
          ],
          inputFormatters: [
            // CustomPhoneFormatter(
            //   allowEndlessPhone: false,
            //   onCountrySelected: (data) {
            //     final correctMask = data?.getCorrectMask(country.countryCode).length;
            //     if (mounted) {
            //       setState(() {
            //         maskLength = correctMask;
            //       });
            //     }
            //   },
            //   defaultCountryCode: country.countryCode,
            // ),
          ],
          autofocus: widget.autoFocus,
          validator: _validatePhoneNumber,
          decoration: InputDecoration(
            hintText: Loc.of(context).phone_hint,
            prefixIcon: buildCountryPickerIcon(context),
           errorStyle: TextStyle(
             fontSize: 11.sp,
             fontWeight: FontWeight.w500,
           ),
          ),
        ),
      ),
    );
  }

  String? validate(String? value) {
    if(value?.isEmpty?? true) {
      return Loc.of(context).empty_field(Loc.of(context).phone);
    }
    if (!validString(value) || !isPhoneValid(controller.text, defaultCountryCode: country.countryCode)) {
      return Loc.of(context).invalid_phone;
    }
    return null;
  }
  String? _validatePhoneNumber(String? value) {
    return PhoneValidator.validate(value, country,context);
  }
  Widget buildCountryPickerIcon(BuildContext context) {
    final countryListThemeData = PhoneCountryPickerTheme.of(context).countryListThemeData;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: InkWell(
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: true,
            exclude: [
              'IL',
            ],
            favorite: [
              kDefaultCountry.countryCode,
            ],
            countryListTheme: CountryListThemeData(
              backgroundColor: countryListThemeData.backgroundColor,
              inputDecoration: countryListThemeData.inputDecoration?.copyWith(
                hintText: Loc.of(context).search,
                prefixIcon: SearchFieldPrefixIcon(),
              ),
              borderRadius: countryListThemeData.borderRadius,
              bottomSheetHeight: MediaQuery.of(context).size.height * SpacingTheme.of(context).bottomSheetHeightFactor,
            ),
            onSelect: (Country country) {
              if (mounted) {
                setState(() {
                  this.country = country;
                });
                widget.onCountryPicked?.call(country);
                if(country.countryCode != kDefaultCountry.countryCode){
                 SnackBarBuilder.showFeedBackMessage(context,  Loc.of(context).sms_otp_uae_only,isSuccess: false,
                 duration: 4,
                 );
                }
              }
            },
          );
        },
        child: IntrinsicHeight(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 20.w),
              flags.CountryFlag(
                country: flags.Country.fromCode(
                  country.countryCode,
                ),
                height: 20.h,
              ),
              SizedBox(width: 12.w),
              Text(
                "+${country.phoneCode}",
              ),
              SizedBox(width: 12.w),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 14.0.h),
                child: Container(
                  width: .5.sp,
                  height: double.infinity,
                  color: IconTheme.of(context).color,
                ),
              ),
              SizedBox(width: 12.w),
            ],
          ),
        ),
      ),
    );
  }
}
