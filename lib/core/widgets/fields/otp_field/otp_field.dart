import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/fields/otp_field/otp_field_theme.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:size_config/size_config.dart';

class OtpField extends StatefulWidget {
  const OtpField({
    super.key,
    this.controller,
    this.focusNode,
    this.onCompleted,
  });

  final TextEditingController? controller;
  final ValueChanged<String>? onCompleted;
  final FocusNode? focusNode;

  @override
  State<OtpField> createState() => _OtpFieldState();
}

class _OtpFieldState extends State<OtpField> {
  late final FocusNode focusNode;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  dispose() {
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
    const numberOfDigits = 6;
    final otpTheme = OTPFieldTheme.of(context);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: TapRegion(
        onTapOutside: (event) {
          focusNode.unfocus();
        },
        child: PinCodeTextField(
          appContext: context,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          // separatorBuilder: (context, index) => SizedBox(width: 10.w),
          focusNode: focusNode,
          controller: controller,
          validator: (value) {
            if (validString(value)) {
              if (value!.length < numberOfDigits) {
                return '';
              }
            }
            return null;
          },
          backgroundColor: Colors.transparent,
          autoDismissKeyboard: true,
          autoFocus: true,
          autoUnfocus: true,
          errorTextSpace: 20.h,
          enablePinAutofill: true ,
          useHapticFeedback: true,
          errorTextDirection: Directionality.of(context),
          autoDisposeControllers: false,
          length: numberOfDigits,
          pinTheme: otpTheme.pinTheme,
          keyboardType: TextInputType.number,
          textStyle: otpTheme.textStyle,
          dialogConfig:  DialogConfig(
            dialogTitle: 'Paste OTP',
            dialogContent: 'Would you like to paste the OTP code?',
            affirmativeText: 'Yes',
            negativeText: 'No',
          ),
          enabled: true,
          enableActiveFill: true,
          onCompleted: (value) {
            widget.onCompleted?.call(value);
          },
          onChanged: (value) {},
        ),
      ),
    );
  }
}
