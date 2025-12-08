import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/system_colors_widget.dart';
import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.body,
    this.overridePageName,
    this.appBar,
    this.bottomNavigationBar,
  });

  final Nav? overridePageName;
  final PreferredSizeWidget? appBar;
  final Widget body;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return SystemColorsWidget(
      overridePageName: overridePageName,
      child: Scaffold(
        appBar: appBar,
        body: body,
        bottomNavigationBar: bottomNavigationBar,
      ),
    );
  }
}
