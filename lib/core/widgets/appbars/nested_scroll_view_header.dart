import 'package:test_vibe/core/theme/themes/light_theme.dart';
import 'package:flutter/material.dart';

class NestedScrollViewHeader extends StatelessWidget {
  const NestedScrollViewHeader({
    super.key,
    required this.builder,
  }) : sliver = false;

  const NestedScrollViewHeader.sliver({
    super.key,
    required this.builder,
  }) : sliver = true;

  final bool sliver;
  final Widget Function(BuildContext context, double t) builder;

  @override
  Widget build(BuildContext context) {
    final sliverAppbar = context.findAncestorWidgetOfExactType<SliverAppBar>();
    final minHeight = sliverAppbar?.collapsedHeight ?? Theme.of(context).appBarTheme.toolbarHeight ?? kDefaultAppBarHeight;
    final maxHeight = sliverAppbar?.expandedHeight ?? minHeight;

    Widget builder(BuildContext context, BoxConstraints constraints) {
      final top = (constraints.maxHeight - MediaQuery.paddingOf(context).top) - minHeight;
      final bottom = maxHeight - minHeight;

      final result = (top / bottom).clamp(0.0, 1.0);
      final progress = Curves.easeInOut.transform(1 - result);

      return this.builder(context, progress);
    }

    return sliver
        ? SliverLayoutBuilder(
            builder: (context, constraints) => builder(context, constraints.asBoxConstraints()),
          )
        : LayoutBuilder(
            builder: builder,
          );
  }
}
