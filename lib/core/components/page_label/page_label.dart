import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';

import 'page_label_theme.dart';

class PageLabel extends StatelessWidget {
  const PageLabel({
    super.key,
    required this.label,
    required this.child,
  });

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          label,
          style: PageLabelTheme.of(context).labelStyle,
        ),
        SizedBox(height: 16.h),
        child,
      ],
    );
  }
}

class PageLabelSliver extends StatelessWidget {
  const PageLabelSliver({
    super.key,
    required this.label,
    required this.sliver,
  });

  final String label;
  final Widget sliver;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Text(
            label,
            style: PageLabelTheme.of(context).labelStyle,
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16.h)),
        sliver,
      ],
    );
  }
}
