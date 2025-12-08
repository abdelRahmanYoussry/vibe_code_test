import 'package:country_picker/country_picker.dart';
import 'package:test_vibe/core/components/page_header/page_header.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';

import 'package:test_vibe/core/widgets/snack_bar/snack_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import 'package:sms_autofill/sms_autofill.dart';

import '../../../core/parameters/register_parameters.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import 'widgets/resend_otp_section/resend_otp_section.dart';
import 'package:pinput/pinput.dart';

class RegisterOTPPage extends StatefulWidget {
  const RegisterOTPPage({
    super.key,
    required this.phone,
    required this.country,
    required this.profilePageParams,
  });

  final String phone;
  final Country country;
  final ProfileParameters profilePageParams;

  @override
  State<RegisterOTPPage> createState() => _RegisterOTPPageState();
}

class _RegisterOTPPageState extends State<RegisterOTPPage> with CodeAutoFill {
  late final TextEditingController otpController;
  late final FocusNode otpFocusNode;
  final scaffoldKey = GlobalKey();

  @override
  void initState() {
    otpController = TextEditingController();
    otpFocusNode = FocusNode();
    listenForCode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      otpFocusNode.requestFocus();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void codeUpdated() {
    setState(() {
      otpController.text = code ?? '';
    });
  }

  @override
  dispose() {
    unregisterListener();
    otpController.dispose();
    otpFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      key: scaffoldKey,
      body: Builder(
        builder: (context) {
          return BlocListener<LoginBloc, LoginState>(
            listenWhen: (previous, current) =>
                previous.verifyCodeState != current.verifyCodeState ||
                previous.registerUserState != current.registerUserState,
            listener: (context, state) {
              if (state.verifyCodeState.success != null && state.verifyCodeState.success!) {
                Nav.root.replaceAll(context);
              } else if (state.verifyCodeState.error != null) {
                SnackBarBuilder.showFeedBackMessage(
                  context,
                  state.verifyCodeState.error!,
                  isSuccess: false,
                );
              }

              // else if (state.registerUserState.error != null) {
              //   SnackBarBuilder.showFeedBackMessage(
              //     context,
              //     state.registerUserState.error ?? Loc.of(context).server_error,
              //     isSuccess: false,
              //   );
              // }
              //  if(state.registerUserState.success != null && state.registerUserState.success!){
              //   SnackBarBuilder.showFeedBackMessage(
              //     context,
              //    state.registerUserState.globalResponseModel?.message?? Loc.of(context).code_sent_successfully,
              //     isSuccess: true,
              //   );
              // }
            },
            child: Center(
              child: SingleChildScrollView(
                padding: SpacingTheme.of(context).pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    PageHeader(
                      title: Loc.of(context).verify_code,
                      subtitle: Loc.of(context).otp_subtitle,
                      subtitle2: '+${widget.country.phoneCode} ${widget.phone}',
                      isTitle2Style: true,
                    ),
                    SizedBox(height: 98.h),
                    Pinput(
                      controller: otpController,
                      focusNode: otpFocusNode,
                      length: 6,
                      autofocus: true,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      keyboardType: TextInputType.number,
                      // defaultPinTheme: customTheme.defaultPinTheme,
                      // focusedPinTheme: customTheme.focusedPinTheme,
                      // submittedPinTheme: customTheme.submittedPinTheme,
                      onCompleted: (String code) {
                        this.code = code;
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (code.length == 6) {
                          final phone = '${widget.country.phoneCode}${widget.phone}';
                          context.read<LoginBloc>().verifyRegisterLoginCode(
                                phone: phone,
                                code: code,
                              );
                        }
                      },
                    ),
                    // PinFieldAutoFill(
                    //   codeLength: 6,
                    //   currentCode: otpController.text,
                    //   onCodeChanged: (value) {
                    //     if (value == null) return;
                    //     otpController.text = value;
                    //     if (value.length == 6) {
                    //       final phone = '${widget.country.phoneCode}${widget.phone}';
                    //       context.read<LoginBloc>().verifyRegisterLoginCode(
                    //             phone: phone,
                    //             code: value,
                    //           );
                    //     }
                    //   },
                    //   onCodeSubmitted: (value) {
                    //     if (value.length == 6) {
                    //       final phone = '${widget.country.phoneCode}${widget.phone}';
                    //       context.read<LoginBloc>().verifyRegisterLoginCode(
                    //             phone: phone,
                    //             code: value,
                    //           );
                    //     }
                    //   },
                    //   keyboardType: TextInputType.number,
                    //   controller: otpController ,
                    //   decoration: BoxLooseDecoration (
                    //     textStyle: TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 14.sp,
                    //       letterSpacing: -.43.sp,
                    //       color: AppColors.brown33,
                    //     ),
                    //     strokeColorBuilder: const FixedColorBuilder(Color(0xffD9D9D9)),
                    //     bgColorBuilder: const FixedColorBuilder(Color(0xFFf7f6f2)),
                    //     radius: const Radius.circular(8),
                    //   ),
                    // ),
                    SizedBox(height: 24.h),
                    ResendOtpSection(
                      onResendOtp: () {
                        context.read<LoginBloc>().registerUser(params: widget.profilePageParams);
                      },
                    ),
                    SizedBox(height: 98.h),
                    BlocSelector<LoginBloc, LoginState, bool>(
                      selector: (state) => state.verifyCodeState.loadingState.loading,
                      builder: (context, state) {
                        return CustomElevatedButton(
                          loading: state,
                          onPressed: () {
                            // //todo send otp action
                            //
                            // Nav.root.replaceAll(context);
                            final phone = '${widget.country.phoneCode}${widget.phone}';
                            debugPrint('phone: $phone');
                            context.read<LoginBloc>().verifyRegisterLoginCode(
                                  phone: phone,
                                  code: otpController.text,
                                );
                          },
                          child: Text(
                            Loc.of(context).sign_in,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
// class SampleStrategy extends OTPStrategy {
//   @override
//   Future<String> listenForCode() {
//     return Future.delayed(
//       const Duration(seconds: 4),
//           () => 'كود التحقق الخاص بك هو :741014', // Test with Arabic format
//     );
//   }
//
//
//
//
// }
