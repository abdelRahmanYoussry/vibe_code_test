import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/navigation/system_colors.dart';
import 'package:test_vibe/core/theme/themes/light_theme.dart';
import 'package:test_vibe/modules/app/root/bloc/root_bloc.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

// class CustomAppbar extends AppBar {
//   CustomAppbar({
//     required BuildContext context,
//     super.key,
//     super.title,
//   }) : super(
//           systemOverlayStyle: SystemColors.getStyleFromCurrentPage(context),
//           leading: ModalRoute.of(context)?.impliesAppBarDismissal == true ? const BackButton() : null,
//         );
// }

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({
    super.key,
    this.title,
    this.elevated = false,
    this.overridePageName,
    this.showBackButton=true,
  });

  @override
  Size get preferredSize => _PreferredAppBarSize();

  final Widget? title;
  final Nav? overridePageName;
  final bool elevated;
  final bool showBackButton;
  @override
  Widget build(BuildContext context) {
    final parentRoute = ModalRoute.of(context);
    final canBack = parentRoute?.impliesAppBarDismissal == true;
    final isRoot = parentRoute?.settings.name == Nav.root.name;
    final rootBloc = RootBloc.of(context);
    final isHome = rootBloc.state.currentIndex.index == RootIndex.home.index;
    return AppBar(
      title: title,
      titleTextStyle: TextStyle(
        color: Colors.black,
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
      ),
      elevation: elevated ? 20 : 0,
      scrolledUnderElevation: elevated ? 20 : 0,
      systemOverlayStyle: overridePageName != null
          ? SystemColors.getStyleFromPage(context, overridePageName!)
          : SystemColors.getStyleFromCurrentPage(context),
      leading: canBack
          ? const BackButton()
          : isRoot && !isHome && showBackButton
              ? BackButton(
                  onPressed: () {
                    rootBloc.changePage(RootIndex.home);
                  },
                )
              : null,
    );
  }
}

class _PreferredAppBarSize extends Size {
  _PreferredAppBarSize({
    this.toolbarHeight,
    this.bottomHeight,
  }) : super.fromHeight((toolbarHeight ?? kDefaultAppBarHeight) + (bottomHeight ?? 0));

  final double? toolbarHeight;
  final double? bottomHeight;
}
