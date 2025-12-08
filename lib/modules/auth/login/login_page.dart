import 'package:country_picker/country_picker.dart';
import 'package:test_vibe/core/components/page_header/page_header.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/utils/constants.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/fields/phone_field/phone_field.dart';
import 'package:test_vibe/core/widgets/logo.dart';
import 'package:test_vibe/core/widgets/snack_bar/snack_bar.dart';
import 'package:test_vibe/modules/auth/otp/widgets/otp_page_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/di/di.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import 'widgets/social_login_section/social_login_section.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController phoneController;
  late final TextEditingController passwordController;
  late final ValueNotifier<Country> countryNotifier;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    countryNotifier = ValueNotifier(kDefaultCountry);
    _formKey = GlobalKey<FormState>();
  }

  @override
  dispose() {
    phoneController.dispose();
    passwordController.dispose();
    countryNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<LoginBloc>(),
      child: Builder(
        builder: (context) {
          return BlocListener<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.submitLoginState.success != null && state.submitLoginState.success!) {
                Nav.otp.push(
                  context,
                  args: OtpPageParams(
                    country: countryNotifier.value,
                    phoneNumber: phoneController.text,
                    // bloc: context.read<LoginBloc>(),
                  ),
                );
              }
              if (state.submitLoginState.error != null) {
                SnackBarBuilder.showFeedBackMessage(
                  context,
                  state.submitLoginState.error ?? Loc.of(context).server_error,
                  isSuccess: false,
                );
              }
              if (state.loginSocialState.success != null && state.loginSocialState.success!) {
                if ((state.loginSocialState.userModel?.userData.name.isEmpty ?? false) || (state.loginSocialState.userModel?.userData.phone.isEmpty ?? false)) {
                  // Nav.confirmProfilePage.push(context, args: context.read<LoginBloc>());
                  Nav.root.replaceAll(context);
                } else {
                  Nav.root.replaceAll(context);
                }
              }
            },
            child: CustomScaffold(
              body: SingleChildScrollView(
                padding: SpacingTheme.of(context).pagePadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 85.h),
                      Logo(height: 43.h,brightness: Brightness.light),
                      SizedBox(height: 100.h),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: PageHeader(
                          title: Loc.of(context).sign_in,
                          subtitle: Loc.of(context).sign_in_subtitle,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      SizedBox(height: 43.h),
                      PhoneField(
                        controller: phoneController,
                        textInputAction: TextInputAction.next,
                        onCountryPicked: (value) => countryNotifier.value = value,
                      ),
                      SizedBox(height: 32.h),
                      BlocSelector<LoginBloc, LoginState, bool>(
                        selector: (state) => state.submitLoginState.loadingState.loading,
                        builder: (context, state) {
                          return CustomElevatedButton(
                            loading: state,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final phone = '${countryNotifier.value.phoneCode}${phoneController.text}';
                                context.read<LoginBloc>().loginWithPhoneNumber(phone: phone);
                              }
                            },
                            child: Text(
                              Loc.of(context).sign_in,
                            ),
                          );
                        },
                      ),
                      SizedBox(height: 69.h),
                      SocialLoginSection(
                        onAppleLogin: () {
                          context.read<LoginBloc>().loginWithApple();
                        },
                        onGoogleLogin: () {
                          context.read<LoginBloc>().loginWithGoogle();
                        },
                      ),
                      SizedBox(height: 24.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: Theme.of(context).textTheme.bodyMedium,
                          children: [
                            TextSpan(
                              text: Loc.of(context).dont_have_account_sign_up_now.split('Sign up')[0],
                            ),
                            WidgetSpan(
                              alignment: PlaceholderAlignment.middle,
                              child: GestureDetector(
                                onTap: () {
                                  Nav.signUp.push(context);
                                },
                                child: Text(
                                  Loc.of(context).sign_up,
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: Theme.of(context).colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class LoginPageArgs {
  final String phone;
  final LoginBloc bloc;

  LoginPageArgs({
    required this.phone,
    required this.bloc,
  });
}
