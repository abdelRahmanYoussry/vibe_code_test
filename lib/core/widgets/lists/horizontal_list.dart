import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  const HorizontalListView({
    super.key,
    required this.itemCount,
    required this.height,
    required this.itemBuilder,
    required this.separatorBuilder,
    this.padding,
    this.controller,
  });

  final EdgeInsetsGeometry? padding;
  final int itemCount;
  final double height;
  final IndexedWidgetBuilder itemBuilder;
  final IndexedWidgetBuilder separatorBuilder;
  final ScrollController? controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        padding: padding,
        itemCount: itemCount,
        controller: controller ,
        scrollDirection: Axis.horizontal,
        separatorBuilder: separatorBuilder,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
