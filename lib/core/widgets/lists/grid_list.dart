import 'package:flutter/material.dart';

class GridList extends StatelessWidget {
  const GridList({
    super.key,
    required this.itemCount,
    required this.gridDelegate,
    required this.itemBuilder,
    this.padding,
  });

  final EdgeInsetsGeometry? padding;
  final int itemCount;
  final SliverGridDelegate gridDelegate;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      gridDelegate: gridDelegate,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

class SliverGridList extends StatelessWidget {
  const SliverGridList({
    super.key,
    required this.itemCount,
    required this.gridDelegate,
    required this.itemBuilder,
    this.padding,
  });

  final int itemCount;
  final SliverGridDelegate gridDelegate;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: padding ?? EdgeInsets.zero,
      sliver: SliverGrid.builder(
        gridDelegate: gridDelegate,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
