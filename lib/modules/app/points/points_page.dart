import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';
import '../../../core/di/di.dart';
import '../../../core/widgets/appbars/app_bar_with_cart_widget.dart';
import '../../../core/widgets/empty/empty_widget.dart';
import '../../../core/widgets/loading/circular_loading_widget.dart';
import 'bloc/points_bloc.dart';
import 'bloc/points_state.dart';
import 'models/point_model_new.dart';
import 'widgets/point_item/point_item.dart';
import 'widgets/total_points_overview/total_points_overview.dart';


class PointsPage extends StatefulWidget {
  const PointsPage({super.key});

  @override
  State<PointsPage> createState() => _PointsPageState();
}

class _PointsPageState extends State<PointsPage> {
  final bool _useDemoData = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di<PointsBloc>()..getHistoryPoints(),
      child: CustomScaffold(
        appBar: CustomAppbar(
          title: AppBarTitleWithCart(title: Loc.of(context).coffee_points ,),
        ),
        body: BlocSelector<PointsBloc, PointsState, GetHistoryPointsState>(
          selector: (state) => state.getHistoryPoints,
          builder: (context, state) {
            if (state.loadingState.loading && !_useDemoData) {
              return const Center(child: CircularLoadingWidget());
            }
            final pointsResp = !_useDemoData ? state.data : null;
            final totalPointsStr = _useDemoData ? '0' : '${pointsResp?.totalPoints ?? 0}';
            final conversionTextStr = _useDemoData ? '' : (pointsResp?.conversionText ?? '');
            final history =
                _useDemoData ? demoLoyaltyPointData : (pointsResp?.history ?? <String, List<LoyaltyPointEntry>>{});
            return Column(
              children: [
                SizedBox(height: 24.h),
                Padding(
                  padding: SpacingTheme.of(context).pagePadding,
                  child: TotalPointsOverview(
                    totalPoints: totalPointsStr,
                    totalPointsDesc: conversionTextStr,
                  ),
                ),
                SizedBox(height: 24.h),
                Expanded(
                  child: history.isEmpty
                      ? Center(
                          child: EmptyWidget(
                            title: Loc.of(context).no_recorded_data_found,
                          ),
                        )
                      : ListView.builder(
                          padding: SpacingTheme.of(context).pagePadding,
                          itemCount: history.entries.length,
                          itemBuilder: (context, groupIndex) {
                            final entry = history.entries.elementAt(groupIndex);
                            final groupTitle = entry.key;
                            final groupItems = entry.value;

                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 16.h),
                                  child: Text(
                                    groupTitle,
                                    style:
                                        Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                                ...groupItems.map((p) => PointItem(model: p)),
                              ],
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
