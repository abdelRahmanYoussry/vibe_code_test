import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/sheets/custom_sheet/custom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/di/di.dart';
import '../../../../core/widgets/snack_bar/snack_bar.dart';
import '../bloc/settings_bloc.dart';
import '../bloc/settings_state.dart';

class DeleteAccountSheet extends StatelessWidget {
  const DeleteAccountSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSheet(
      title: Text(Loc.of(context).delete_account),
      builder: (context) => BlocProvider(
        create: (context) => di<SettingsBloc>(),
        child: BlocListener<SettingsBloc, SettingsState>(
          listener: (context, state) {
            if (state.deleteAccountState.success != null && state.deleteAccountState.success!) {
              Nav.login.replaceAll(context);
            } else if (state.deleteAccountState.error != null) {
              SnackBarBuilder.showFeedBackMessage(
                context,
                state.deleteAccountState.error ?? Loc.of(context).server_error,
                isSuccess: false,
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Loc.of(context).delete_account_message,
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 16.h),
              Text(
                Loc.of(context).delete_account_message_desc,
                style: TextStyle(fontSize: 14.sp, color: Colors.grey[600]),
              ),
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(Loc.of(context).cancel),
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: BlocSelector<SettingsBloc, SettingsState, DeleteAccountState>(
                      selector: (state) {
                        return state.deleteAccountState;
                      },
                      builder: (context, state) {
                        return CustomElevatedButton(
                          onPressed: () async {
                            context.read<SettingsBloc>().deleteAccount();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 12.h),
                          ),
                          loading: state.loadingState.loading,
                          child: Text(Loc.of(context).delete_account),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
