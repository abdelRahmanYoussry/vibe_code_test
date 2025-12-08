import 'package:country_picker/country_picker.dart';
import 'package:test_vibe/core/components/page_header/page_header.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/fields/name_field.dart';
import 'package:test_vibe/core/widgets/fields/phone_field/phone_field.dart';
import 'package:test_vibe/core/widgets/fields/email_field.dart';
import 'package:test_vibe/core/widgets/logo.dart';
import 'package:test_vibe/core/widgets/snack_bar/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/di/di.dart';
import '../../../core/utils/constants.dart';
import '../bloc/login_bloc.dart';
import '../bloc/login_state.dart';
import '../../../core/parameters/register_parameters.dart';
import '../otp/widgets/otp_page_params.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController emailController;
  late final ValueNotifier<Country> countryNotifier;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    emailController = TextEditingController();
    countryNotifier = ValueNotifier(kDefaultCountry);
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
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
              if (state.registerUserState.success != null && state.registerUserState.success!) {
                SnackBarBuilder.showFeedBackMessage(
                  context,
                  Loc.of(context).register_success,
                  isSuccess: true,
                );
                // Nav.root.replaceAll(context);
                Nav.registerOTP.push(
                  context,
                  args: RegisterOtpPageParams(
                    country: countryNotifier.value,
                    phoneNumber: phoneController.text,
                    profilePageParams: ProfileParameters(
                      name: nameController.text,
                      email: emailController.text,
                      phone:
                          '${countryNotifier.value.phoneCode}${phoneController.text}',
                    ),
                  ),
                );
              }
              if (state.registerUserState.error != null) {
                SnackBarBuilder.showFeedBackMessage(
                  context,
                  (state.registerUserState.error ?? Loc.of(context).server_error).trim(),
                  isSuccess: false,
                );
              }
            },
            child: CustomScaffold(
              appBar: CustomAppbar(
                title: Text(Loc.of(context).sign_up),
              ) ,
              body: SingleChildScrollView(
                padding: SpacingTheme.of(context).pagePadding,
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 20.h),
                      Logo(height: 43.h, brightness: Brightness.light),
                      SizedBox(height: 60.h),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: PageHeader(
                          title: Loc.of(context).sign_up,
                          subtitle: Loc.of(context).sign_up_description,
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      SizedBox(height: 43.h),
                      NameField(
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 24.h),
                      PhoneField(
                        controller: phoneController,
                        textInputAction: TextInputAction.next,
                        onCountryPicked: (value) => countryNotifier.value = value,
                      ),
                      SizedBox(height: 24.h),
                      EmailField(
                        controller: emailController,
                        textInputAction: TextInputAction.done,
                      ),
                      SizedBox(height: 50.h),
                      BlocSelector<LoginBloc, LoginState, bool>(
                        selector: (state) => state.registerUserState.loadingState.loading,
                        builder: (context, loading) {
                          return CustomElevatedButton(
                            loading: loading,
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                final phone = '${countryNotifier.value.phoneCode}${phoneController.text}';
                                final params = ProfileParameters(
                                  name: nameController.text,
                                  email: emailController.text,
                                  phone: phone,
                                );
                                context.read<LoginBloc>().registerUser(params: params);
                              }
                            },
                            child: Text(
                              Loc.of(context).confirm,
                            ),
                          );
                        },
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

