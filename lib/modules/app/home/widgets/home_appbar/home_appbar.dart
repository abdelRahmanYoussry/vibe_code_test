import 'dart:ui';

import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/navigation/system_colors.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/utils/functions.dart';
import 'package:test_vibe/core/widgets/anim/lerped_opacity.dart';
import 'package:test_vibe/core/widgets/appbars/nested_scroll_view_header.dart';
import 'package:test_vibe/core/widgets/fields/search_field/search_field.dart';
import 'package:test_vibe/core/widgets/logo.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/home_appbar_theme.dart';
import 'package:test_vibe/modules/app/home/widgets/home_appbar/widgets/home_appbar_actions/home_appbar_actions.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'widgets/my_location_widget/my_location_widget.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final myTheme = HomeAppbarTheme.of(context);
    // final inputFieldHeight = theme.inputDecorationTheme.constraints?.maxHeight;
    final spacingTheme = SpacingTheme.of(context);
    final pagePadding = spacingTheme.pagePadding;
    final pageStartPadding = pagePadding.horizontal / 2;

    return Theme(
      data: theme.copyWith(
        appBarTheme: myTheme.appBarTheme,
      ),
      child: SliverAppBar(
        pinned: true,
        floating: true,
        snap: true,
        collapsedHeight:  isMobileDevice(context)? 85.h: 120.h,
        expandedHeight: isMobileDevice(context)? 250.h: 300.h,
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemColors.getStyleFromPage(context, Nav.home),
        flexibleSpace: NestedScrollViewHeader(
          builder: (context, t0) {
            final t = Curves.easeOutExpo.transform(t0);
            return Stack(
              children: [
                PositionedDirectional(
                  top: lerpDouble(70.h, 55.h, t),
                  start: pageStartPadding,
                  child: Logo(
                    brightness: Brightness.dark,
                    height: 37.h,
                  ),
                ),
                PositionedDirectional(
                  top: lerpDouble(135.h, 35.h, t),
                  start: pageStartPadding,
                  child: LerpedOpacity(
                    opacity: lerpDouble(1, 0, t),
                    child: Container(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width /2,
                          minWidth: 100.w,
                        ),
                        child: MyLocationWidget(),),
                  ),
                ),
                PositionedDirectional(
                  top: lerpDouble(135.h, 55.h, t),
                  end: pageStartPadding,
                  child: HomeAppbarActions(),
                ),
                PositionedDirectional(
                  bottom: lerpDouble(24.h, 0.h, t),
                  start: pageStartPadding,
                  end: pageStartPadding,
                  child: LerpedOpacity(
                    opacity: lerpDouble(1, 0, t),
                    child: Row(
                      children: [
                        SizedBox(
                          height: 45.h,
                          width:MediaQuery.of(context).size.width -40.w ,
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Nav.search.push(context);
                            },
                            child: IgnorePointer(
                              ignoring: true,
                              child: Theme(
                                data: theme.copyWith(
                                  inputDecorationTheme: myTheme.searchInputDecorationTheme,
                                ),
                                child: SearchField(),
                              ),
                            ),
                          ),
                        ),
                        // HomeAppBarActionButton(
                        //   height: inputFieldHeight,
                        //   width: inputFieldHeight,
                        //   icon: Assets.icons.filter.path,
                        //   onPressed: () {
                        //     //todo filter action
                        //   },
                        // ),
                      ],
                    ),
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
