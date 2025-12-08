import 'package:country_picker/country_picker.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/fields/name_field.dart';
import 'package:test_vibe/core/widgets/snack_bar/snack_bar.dart';
import 'package:test_vibe/modules/auth/bloc/login_bloc.dart';
import 'package:test_vibe/modules/auth/bloc/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/components/page_header/page_header.dart';
import '../../../core/utils/constants.dart';
import '../../../core/widgets/fields/phone_field/phone_field.dart';


class ConfirmProfilePage extends StatefulWidget {
  const ConfirmProfilePage({
    super.key,
    required this.bloc,
  });

  final LoginBloc bloc;

  @override
  State<ConfirmProfilePage> createState() => _LoginPageState();
}

class _LoginPageState extends State<ConfirmProfilePage> {
  late final TextEditingController NameController;
  late final TextEditingController phoneController;
  late final ValueNotifier<Country> countryNotifier;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    countryNotifier = ValueNotifier(kDefaultCountry);
    NameController = TextEditingController();
    phoneController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  dispose() {
    NameController.dispose();
    phoneController.dispose();
    countryNotifier.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.bloc,
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if(state.confirmProfileState.error != null) {
            SnackBarBuilder.showFeedBackMessage(
              context,
            state.confirmProfileState.error ?? Loc.of(context).server_error,
              isSuccess: false,
            );
          }
          else if (state.confirmProfileState.success != null && state.confirmProfileState.success!) {
           Nav.root.replaceAll(context);
          }
        },
        child: CustomScaffold(
          appBar: CustomAppbar(
            title: Text(Loc.of(context).confirm_profile_title),

          ),
          body: SingleChildScrollView(
            padding: SpacingTheme.of(context).pagePadding,
            child: Form(
              key: _formKey,
              child: Padding(
                padding: SpacingTheme.of(context).pagePadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 43.h),
                    PageHeader(
                      title: Loc.of(context).confirm_profile_title,
                      subtitle: Loc.of(context).confirm_profile_subtitle,
                    ),
                    SizedBox(height: 43.h),
                    NameField(
                      controller: NameController,
                      textInputAction: TextInputAction.next,
                    ),
                    SizedBox(height: 16.h),
                    PhoneField(
                      controller: phoneController,
                      textInputAction: TextInputAction.next,
                      onCountryPicked: (value) => countryNotifier.value = value,
                    ),
                    SizedBox(height: 40.h),
                    BlocSelector<LoginBloc, LoginState, ConfirmProfileState>(
                      selector: (state) {
                      return  state.confirmProfileState;
                      },
                      builder: (context, state) {
                        return CustomElevatedButton(
                          loading: state.loadingState.loading,
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              final phone = '${countryNotifier.value.phoneCode}${phoneController.text}';
                              widget.bloc.confirmProfile(
                                name: NameController.text,
                                phone: phone,
                              );
                            }
                          },
                          child: Text(
                            Loc.of(context).confirm,
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 34.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
