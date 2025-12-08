import 'package:flutter/material.dart';

class VerticalListView extends StatelessWidget {
  const VerticalListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.padding,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      itemCount: itemCount,
      separatorBuilder: separatorBuilder,
      itemBuilder: itemBuilder,
    );
  }
}

class VerticalSliverListView extends StatelessWidget {
  const VerticalSliverListView({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.padding,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverList.separated(
        itemCount: itemCount,
        separatorBuilder: separatorBuilder,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
