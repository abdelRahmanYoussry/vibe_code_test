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

import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../login/widgets/confirm_profile_page_params.dart';
import 'widgets/resend_otp_section/resend_otp_section.dart';
import 'package:pinput/pinput.dart';

class OTPPage extends StatefulWidget {
  const OTPPage({
    super.key,
    required this.phone,
    required this.country,
  });

  final String phone;
  final Country country;

  @override
  State<OTPPage> createState() => _OTPPageState();
}

class _OTPPageState extends State<OTPPage> with CodeAutoFill {
  late final TextEditingController otpController;
  late final FocusNode otpFocusNode;
  final scaffoldKey = GlobalKey();

  @override
  void initState() {
    otpController = TextEditingController();
    otpFocusNode = FocusNode();
    listenForCode();
    // Optionally fetch app signature for Android logs (no-op on iOS)
    // SmsAutoFill().getAppSignature.then((sig) => debugPrint('AppSignature: $sig'));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      otpFocusNode.requestFocus();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Now context has access to BlocProvider
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
                previous.submitLoginState != current.submitLoginState,
            listener: (context, state) {
              if (state.verifyCodeState.success != null &&
                  state.verifyCodeState.success!) {
                if (state.verifyCodeState.userModel?.userData.name ==
                    'No Name') {
                  ConfirmNamePageParams params = ConfirmNamePageParams(
                    phone: widget.phone,
                    country: widget.country,
                  );
                  Nav.confirmNamePage.push(context, args: params);
                } else {
                  Nav.root.replaceAll(context);
                }
              } else if (state.verifyCodeState.error != null) {
                SnackBarBuilder.showFeedBackMessage(
                  context,
                  state.verifyCodeState.error!,
                  isSuccess: false,
                );
              }
              // else if(state.submitLoginState.error != null) {
              //   SnackBarBuilder.showFeedBackMessage(
              //     context,
              //     state.submitLoginState.error?? Loc.of(context).server_error,
              //     isSuccess: false,
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
                          final phone =
                              '${widget.country.phoneCode}${widget.phone}';
                          context.read<LoginBloc>().verifyCode(
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
                    //       final phone =
                    //           '${widget.country.phoneCode}${widget.phone}';
                    //       context.read<LoginBloc>().verifyCode(
                    //             phone: phone,
                    //             code: value,
                    //           );
                    //     }
                    //   },
                    //   onCodeSubmitted: (value) {
                    //     if (value.length == 6) {
                    //       final phone =
                    //           '${widget.country.phoneCode}${widget.phone}';
                    //       context.read<LoginBloc>().verifyCode(
                    //             phone: phone,
                    //             code: value,
                    //           );
                    //     }
                    //   },
                    //   controller: otpController ,
                    //   keyboardType: TextInputType.number,
                    //   decoration: BoxLooseDecoration (
                    //     textStyle: TextStyle(
                    //       fontWeight: FontWeight.w500,
                    //       fontSize: 14.sp,
                    //       letterSpacing: -.43.sp,
                    //       color: AppColors.brown33,
                    //     ),
                    //    strokeColorBuilder: const FixedColorBuilder(Color(0xffD9D9D9)),
                    //     bgColorBuilder: const FixedColorBuilder(Color(0xFFf7f6f2)),
                    //     radius: const Radius.circular(8),
                    //   ),
                    //
                    // ),
                    SizedBox(height: 24.h),
                    ResendOtpSection(
                      onResendOtp: () {
                        final phone =
                            '${widget.country.phoneCode}${widget.phone}';
                        context
                            .read<LoginBloc>()
                            .loginWithPhoneNumber(phone: phone);
                      },
                    ),
                    SizedBox(height: 98.h),
                    BlocSelector<LoginBloc, LoginState, bool>(
                      selector: (state) =>
                          state.verifyCodeState.loadingState.loading,
                      builder: (context, state) {
                        return CustomElevatedButton(
                          loading: state,
                          onPressed: () {
                            // //todo send otp action
                            //
                            // Nav.root.replaceAll(context);
                            final phone =
                                '${widget.country.phoneCode}${widget.phone}';
                            debugPrint('phone: $phone');
                            context.read<LoginBloc>().verifyCode(
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
