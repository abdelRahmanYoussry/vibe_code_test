import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/sheets/custom_sheet/custom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/di/di.dart';
import '../../../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../rewards/bloc/rewards_bloc.dart';
import '../../../rewards/bloc/rewards_state.dart';

class QrSheet extends StatefulWidget {
  const QrSheet({super.key});

  @override
  State<QrSheet> createState() => _QrSheetState();
}

class _QrSheetState extends State<QrSheet> {
  @override
  Widget build(BuildContext context) {
    return CustomSheet(
      title: Text(Loc.of(context).buyFiveGetOne),
      builder: (context) => BlocProvider(
        create: (context) => di<RewardsBloc>()..getQrItemRewards(),
        child: BlocSelector<RewardsBloc, RewardsState, RewardsQrState>(
          selector: (state) {
            return state.rewardsQrState;
          },
          builder: (context, state) {
            final data = state.data?.data;
            if (data == null && !state.loadingState.loading) {
              return const SizedBox();
            }
            if (state.loadingState.loading) {
              return SizedBox(
                height: 100.h,
                child: const Center(child: CircularLoadingWidget()),
              );
            }
            return Center(
              child: QrImageView(
                data:data?.qrToken??'',
                embeddedImage: AssetImage(Assets.icons.logoLight.path),
                version: QrVersions.auto,
                size: 250.0,
              ),
            );
          },
        ),
      ),
    );
  }
}
