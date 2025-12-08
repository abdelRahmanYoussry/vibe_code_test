import 'package:test_vibe/core/components/page_header/page_header.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/fields/password_field.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({
    super.key,
  });

  @override
  State<PasswordPage> createState() => _PasswordPageState();
}

class _PasswordPageState extends State<PasswordPage> {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    super.initState();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  @override
  dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: SpacingTheme.of(context).pagePadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PageHeader(
                title: Loc.of(context).new_password,
                subtitle: Loc.of(context).new_password_description,
              ),
              SizedBox(height: 98.h),
              PasswordField(
                controller: passwordController,
                textInputAction: TextInputAction.next,
              ),
              SizedBox(height: 16.h),
              PasswordField(
                label: Loc.of(context).confirm_password,
                controller: confirmPasswordController,
                textInputAction: TextInputAction.done,
                confirmedPassword: passwordController.text,
              ),
              SizedBox(height: 98.h),
              CustomElevatedButton(
                onPressed: () {
                  //todo confirm password action
                },
                child: Text(
                  Loc.of(context).create_new_password,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
