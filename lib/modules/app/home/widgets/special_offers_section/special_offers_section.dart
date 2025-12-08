import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/section_label/section_label.dart';
import 'package:test_vibe/modules/app/offers/bloc/offers_bloc.dart';
import 'package:test_vibe/modules/app/offers/widgets/offers_carousel/offers_carousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/widgets/empty/empty_widget.dart';
import '../../../../../core/widgets/loading/circular_loading_widget.dart';
import '../../../offers/bloc/offers_state.dart';

class SpecialOffersSection extends StatelessWidget {
  const SpecialOffersSection({super.key, required this.offersBloc});
  final SpecialOffersBloc offersBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => offersBloc..getAllSpecialOffers(),
      child: BlocSelector<SpecialOffersBloc, SpecialOffersState, GetAllSpecialOffersState>(
        selector: (state) {
          return state.getAllSpecialOffersState;
        },
        builder: (context, state) {
          final list = state.data;
          if (list.isEmpty && !state.loadingState.loading) {
            return Center(child: const EmptyWidget());
          }
          if (state.loadingState.loading) {
            return SizedBox(
              height: 200.h,
              child: const Center(child: CircularLoadingWidget()),
            );
          }
          return SectionLabel(
            label: Loc.of(context).special_offers,
            labelPadding: SpacingTheme.of(context).pagePadding,
            onSeeMorePressed: () {
              Nav.offers.push(context,args: list);
            },
            child: OffersCarousel(
              models: list,
            ),
          );
        },
      ),
    );
  }
}
