import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class AnimatedListOrGrid extends StatelessWidget {
  const AnimatedListOrGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
    required this.isGrid,
    this.gridDelegate,
    this.padding = EdgeInsets.zero,
    this.physics = const BouncingScrollPhysics(),
    this.duration = const Duration(milliseconds: 500),
    this.animationDuration = const Duration(milliseconds: 900),
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.columnCount = 2,
    this.controller,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool isGrid;
  final SliverGridDelegate? gridDelegate;
  final EdgeInsetsGeometry padding;
  final ScrollPhysics physics;
  final Duration duration;
  final Duration animationDuration;
  final Curve curve;
  final int columnCount;
  final ScrollController? controller;


  @override
  Widget build(BuildContext context) {
    return AnimationLimiter(
      child: isGrid
          ? GridView.builder(
        physics: physics,
        controller: controller ,
        padding: padding,
        gridDelegate: gridDelegate ??
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
        itemCount: itemCount,
        itemBuilder: (context, index) => _buildAnimatedItem(index, context),
      )
          : ListView.builder(
        physics: physics,
        padding: padding,
        controller: controller,
        itemCount: itemCount,
        itemBuilder: (context, index) => _buildAnimatedItem(index, context),
      ),
    );
  }

  Widget _buildAnimatedItem(int index, BuildContext context) {
    return AnimationConfiguration.staggeredGrid(
      position: index,
      duration: duration,
      columnCount: columnCount,
      child: ScaleAnimation(
        duration: animationDuration,
        curve: curve,
        child: FadeInAnimation(
          child: itemBuilder(context, index),
        ),
      ),
    );
  }
}
