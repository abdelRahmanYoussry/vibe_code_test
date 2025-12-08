import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/navigation/system_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SystemColorsWidget extends StatelessWidget {
  const SystemColorsWidget({
    super.key,
    required this.child,
    this.overridePageName,
  });

  final Widget child;
  final Nav? overridePageName;

  @override
  Widget build(BuildContext context) {
    final sysCols = overridePageName != null
        ? SystemColors.getStyleFromPage(context, overridePageName!)
        : SystemColors.getStyleFromCurrentPage(context);
    return sysCols == null
        ? child
        : AnnotatedRegion<SystemUiOverlayStyle>(
            value: sysCols,
            child: child,
          );
  }
}
