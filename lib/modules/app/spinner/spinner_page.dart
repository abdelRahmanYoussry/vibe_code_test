import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/modules/app/spinner/widgets/spinner_reward/spinner_reward_sheet_params.dart';
import 'package:test_vibe/modules/app/spinners/bloc/spinners_state.dart';
import 'package:test_vibe/modules/app/spinners/models/spinner_model_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../core/di/di.dart';
import '../../../core/widgets/dialogs/try_again_dialog/try_again_dialog.dart';
import '../../../core/widgets/empty/empty_widget.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import '../spinners/bloc/spinners_bloc.dart';
import 'widgets/spinner/spinner.dart';

class SpinnerPage extends StatefulWidget {
  const SpinnerPage({
    super.key,
    required this.model,
  });

  final SpinnerModel model;

  @override
  State<SpinnerPage> createState() => _SpinnerPageState();
}

class _SpinnerPageState extends State<SpinnerPage> {
  late final SpinnerController spinnerController;
  bool _isSpinning = true;

  @override
  void initState() {
    super.initState();
    spinnerController = SpinnerController(
      models: widget.model.items,
      spinnerId: widget.model.id,
    );
  }

  @override
  void dispose() {
    spinnerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<SpinnersBloc>()..spinTheWheel(widget.model.id),
      child: BlocListener<SpinnersBloc, SpinnersState>(
        listenWhen: (previous, current) => previous.spinTheWheelState.data != current.spinTheWheelState.data,
        listener: (context, state) {
          final spinnerRewardResult = state.spinTheWheelState.data;
          if (spinnerRewardResult != null) {
            spinnerController.spinIndefinitely();
          }
        },
        child: CustomScaffold(
          appBar: CustomAppbar(
            title: Text(
              validateString(widget.model.title, Loc.of(context).spinner),
            ),
            elevated: false,
          ),
          body: Padding(
            padding: SpacingTheme.of(context).pagePadding,
            child: Center(
              child: BlocSelector<SpinnersBloc, SpinnersState, SpinTheWheelState>(
                selector: (state) {
                  return state.spinTheWheelState;
                },
                builder: (context, state) {
                  final data = state.data;
                  if (data == null && !state.loadingState.loading) {
                    return Center(
                      child: EmptyWidget(
                        title: Loc.of(context).error_while_getting_spin_wheel_data,
                      ),
                    );
                  }
                  if (state.loadingState.loading) {
                    return SizedBox(
                      height: 200.h,
                      child: const Center(child: CircularLoadingWidget()),
                    );
                  }
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Spinner(
                        controller: spinnerController,
                      ),
                      SizedBox(height: 77.h),
                      CustomElevatedButton(
                        enabled: data != null && _isSpinning,
                        // loading: _isSpinning,
                        onPressed: () async {
                          if (!_isSpinning) return;
                          if (mounted) {
                            setState(() {
                              _isSpinning = false;
                            });
                          }

                          await spinnerController.stop(preloadedResult: data);

                          try {
                            final reward = spinnerController.selectedItem;
                            if (reward != null && context.mounted) {
                              SpinnerRewardSheetParams args = SpinnerRewardSheetParams(
                                // model: reward,
                                result: data!,
                                bloc: context.read<SpinnersBloc>(),
                              );
                              if (data.type == 'try_again') {
                                showDialog(
                                  context: context,
                                  builder: (context) => SingleButtonAlertDialog(
                                    title: Loc.of(context).better_luck_next_time,
                                    subtitle: Loc.of(context).try_spinner_again,
                                    buttonText: Loc.of(context).confirm,
                                    icon: Icon(Icons.refresh_rounded),
                                  ),
                                ).then((_) {
                                  if (context.mounted) {
                                    Nav.root.popUntil(context);
                                  }
                                });
                              } else {
                                Nav.spinnerRewardSheet.sheet(
                                  context,
                                  args: args,
                                  isDismissible: false,
                                  showDragHandle: false,
                                );
                              }
                            }
                          } finally {}
                        },
                        child: Text(Loc.of(context).stop),
                      ),
                      SizedBox(height: 77.h),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
