import 'package:test_vibe/core/di/di.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/constants/app_bools.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/modules/app/live_tracking/live_tracking_repo.dart';
import 'package:test_vibe/modules/app/root/widgets/root_bottom_navbar/root_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/notifications/init_notifications.dart';
import '../../../core/utils/notifications/setup_notifications.dart';
import 'bloc/root_bloc.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key, this.initialIndex = RootIndex.home});
final RootIndex? initialIndex ;
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  @override
  void initState() {
    super.initState();
    RootBloc.of(context).changePage( widget.initialIndex??RootIndex.home);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      di<LiveTrackingRepo>().checkOrdersAndDetermineTracking();
      di<LiveTrackingRepo>().startLocationTracking();
      if (mounted&&AppBools.showSpinners) {
        // Nav.spinners.push(context);
      }
    });
    requestPermissions();
    SetupFCM.i.loggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: BlocSelector<RootBloc, RootState, int>(
        selector: (state) => state.currentIndex.index,
        builder: (context, index) => IndexedStack(
          index: index,
          children: [
            Nav.home.getWidget(context),
            Nav.orders.getWidget(context),
            Nav.profile.getWidget(context),
          ],
        ),
      ),
      bottomNavigationBar: BlocSelector<RootBloc, RootState, int>(
        selector: (state) => state.currentIndex.index,
        builder: (context, index) => BottomAppbar(
          currentIndex: index,
          onTap: (int value) {
            RootBloc.of(context).changePage(RootIndex.values[value]);
          },
        ),
      ),
    );
  }
}
