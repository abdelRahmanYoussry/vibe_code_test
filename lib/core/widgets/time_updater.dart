import 'dart:async';

import 'package:flutter/material.dart';

class TimeUpdater extends StatefulWidget {
  const TimeUpdater({
    super.key,
    required this.builder,
  });

  final Widget Function(BuildContext context, DateTime time) builder;

  @override
  State<TimeUpdater> createState() => _TimeUpdaterState();
}

class _TimeUpdaterState extends State<TimeUpdater> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(context, DateTime.now());
  }
}
