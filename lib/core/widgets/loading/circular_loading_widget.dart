import 'package:flutter/material.dart';

class CircularLoadingWidget extends StatelessWidget {
  const CircularLoadingWidget({
    super.key,
    this.size,
    this.color,
  });

  final double? size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
