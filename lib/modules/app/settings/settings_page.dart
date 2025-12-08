import 'package:dash_flags/dash_flags.dart';
import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/utils/constants.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/profile/widgets/profile_action_tile/profile_action_tile.dart';
import 'package:test_vibe/modules/app/settings/bloc/settings_bloc.dart';
import 'package:test_vibe/modules/app/settings/bloc/settings_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/di/di.dart';
import '../live_tracking/live_tracking_repo.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late final ValueNotifier<bool> enableNotificationsNotifier;
   final ValueNotifier<bool> autoAssignBranchNotifier= ValueNotifier<bool>(true);

  static const String _autoAssignBranchKey = 'autoAssignBranchEnabled';

  @override
  void initState() {
    super.initState();
    enableNotificationsNotifier = ValueNotifier(true);

    _loadAutoAssignBranch();
  }
  Future<void> _loadAutoAssignBranch() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool(_autoAssignBranchKey) ?? true;
    autoAssignBranchNotifier.value = enabled; // Update the existing notifier

    // Set the value in LiveTrackingRepo
    di<LiveTrackingRepo>().autoAssignBranchEnabled = autoAssignBranchNotifier.value;
    autoAssignBranchNotifier.addListener(() {
      di<LiveTrackingRepo>().autoAssignBranchEnabled = autoAssignBranchNotifier.value;
    });
  }

  Future<void> _saveAutoAssignBranch(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_autoAssignBranchKey, value);
    di<LiveTrackingRepo>().autoAssignBranchEnabled = value;
    if(value){
      await di<LiveTrackingRepo>().startLocationTracking();
    }else{
      await di<LiveTrackingRepo>().stopLocationTracking();
    }
  }

  @override
  void dispose() {
    enableNotificationsNotifier.dispose();
    autoAssignBranchNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<SettingsBloc>()..getLang(),
      child: BlocListener<SettingsBloc, SettingsState>(
        listener: (context, state) {

        },
        child: Builder(
          builder: (context) {
            return CustomScaffold(
              appBar: CustomAppbar(
                title: Text(Loc.of(context).settings),
                elevated: false,
              ),
              body: Column(
                children: [
                  SizedBox(height: 32.h),
                  Padding(
                    padding: SpacingTheme.of(context).pagePadding,
                    child: Column(
                      spacing: 16.h,
                      children: [
                        ValueListenableBuilder(
                          valueListenable: enableNotificationsNotifier,
                          builder: (context, enabled, child) => ProfileActionTile(
                            title: Text(Loc.of(context).notifications),
                            leading: Pic(Assets.icons.notification.path, inherit: true),
                            trailing: IgnorePointer(
                              child: CupertinoSwitch(
                                value: enabled,
                                onChanged: (value) {},
                              ),
                            ),
                            onPressed: () {
                              enableNotificationsNotifier.value = !enableNotificationsNotifier.value;
                            },
                          ),
                        ),
                        // --- Auto Assign Branch Switch ---
                        ValueListenableBuilder(
                          valueListenable: autoAssignBranchNotifier,
                          builder: (context, enabled, child) => ProfileActionTile(
                            title: Text(Loc.of(context).auto_assigned_branch),
                            leading: Icon(Icons.location_on_rounded, color: Theme.of(context).primaryColor),
                            trailing: IgnorePointer(
                              child: CupertinoSwitch(
                                value: enabled,
                                onChanged: (value) {
                                  if(value){
                                    autoAssignBranchNotifier.value = true;
                                    _saveAutoAssignBranch(autoAssignBranchNotifier.value);

                                  }
                                },
                              ),
                            ),
                            onPressed: () async {
                              autoAssignBranchNotifier.value = !autoAssignBranchNotifier.value;
                              await _saveAutoAssignBranch(autoAssignBranchNotifier.value);
                            },
                          ),
                        ),
                        BlocBuilder<SettingsBloc, SettingsState>(
                          builder: (context, state) {
                            final currentLang = state.getLangState.lang ?? 'en';
                            debugPrint('Current language: $currentLang');
                            return ProfileActionTile(
                              title: Text(Loc.of(context).language),
                              leading: Pic(Assets.icons.languageCircle.path, inherit: true),
                              trailing: Row(
                                children: [
                                  BlocBuilder<SettingsBloc, SettingsState>(
                                    builder: (context, state) {

                                      return Text(currentLang == 'en' ? 'English' : 'العربية');
                                    },
                                  ),
                                  Icon(CupertinoIcons.right_chevron),
                                ],
                              ),
                              onPressed: () async {
                                final result = await Nav.selectLangSheet.sheet(context, args: currentLang);
                                if (result != null && context.mounted) {
                                  debugPrint('11111111111111111');
                                  // context.read<SettingsBloc>().changeLang(result, context);
                                }
                              },
                            );
                          },
                        ),
                        ProfileActionTile(
                          title: Text(Loc.of(context).country),
                          leading: ClipOval(
                            child: AspectRatio(
                              aspectRatio: 1,
                              child: CountryFlag(
                                country: Country.fromCode(
                                  kDefaultCountry.countryCode,
                                ),
                                height: 20.h,
                              ),
                            ),
                          ),
                          trailing: Row(
                            children: [
                              Text('United Arab Emirates'),
                              Icon(CupertinoIcons.right_chevron),
                            ],
                          ),
                          onPressed: () {
                            //todo select country
                          },
                        ),
                        ProfileActionTile(
                          title: Text(
                            Loc.of(context).delete_account,
                            style: TextStyle(color: Colors.red),
                          ),
                          leading: Pic(Assets.icons.trash.path, inherit: true, color: Colors.red),
                          onPressed: () {
                            Nav.deleteAccountSheet.sheet(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
