import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/user_selector/user_selector.dart';
import 'package:test_vibe/modules/app/branches/models/branch_model.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/widgets/my_location_widget/bloc/branches_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../../../core/di/di.dart';
import 'bloc/branches_state.dart';
import 'branches_page_params.dart';
import 'my_location_widget_theme.dart';

class MyLocationWidget extends StatefulWidget {
  const MyLocationWidget({super.key});

  @override
  State<MyLocationWidget> createState() => _MyLocationWidgetState();
}

class _MyLocationWidgetState extends State<MyLocationWidget> {
  ValueNotifier<BranchModel?> selectedBranchNotifier = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    var myTheme = MyLocationWidgetTheme.of(context);
    return BlocProvider(
      create: (context) => di<BranchesBloc>(),
      child: BlocBuilder<BranchesBloc, BranchesState>(
        builder: (context, state) {
          return  UserSelector(builder: (context, user) {
            return ValueListenableBuilder(
              valueListenable: selectedBranchNotifier,
              builder: (context, value, child) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () async {
                  final result = await Nav.branches.push(
                    context,
                    args: BranchesPageParams(
                      bloc: context.read<BranchesBloc>(),
                      selectedBranch: selectedBranchNotifier.value,
                    ),
                  );
                  if (result != null && result is BranchModel) {
                    selectedBranchNotifier.value = result;
                  }
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Loc.of(context).our_branches,
                      style: myTheme.labelTextStyle,
                    ),
                    SizedBox(height: 3.h),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            // '${selectedBranchNotifier.value?.city ?? 'Al Ain'}, ${selectedBranchNotifier.value?.address ?? 'Neimah, The Spot...'}',
                            '${user?.store_locator?.name ?? 'Al Ain'}, ${user?.store_locator?.city ?? 'Neimah, The Spot...'}',
                            style: myTheme.titleTextStyle,
                            maxLines: 1,
                          ),
                        ),
                        IconTheme(
                          data: myTheme.expandIconThemeData,
                          child: Icon(CupertinoIcons.chevron_down),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },);
        },
      ),
    );
  }
}
