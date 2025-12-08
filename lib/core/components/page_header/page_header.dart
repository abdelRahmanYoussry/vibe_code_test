import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'page_header_theme.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.subtitle2,
    this.crossAxisAlignment,
    this.isTitle2Style = false,
  });

  final String title;
  final String subtitle;
  final String? subtitle2;
  final CrossAxisAlignment? crossAxisAlignment;
  final bool isTitle2Style;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: isTitle2Style ? PageHeaderTheme.of(context).title2Style : PageHeaderTheme.of(context).titleStyle,
        ),
        SizedBox(height: 8.h),
        Text(
          subtitle,
          style: PageHeaderTheme.of(context).subtitleStyle,
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
        if (subtitle2 != null) ...[
          SizedBox(height: 4.h),
          Text(
            subtitle2!,
            style: PageHeaderTheme.of(context).subtitle2Style,
          ),
        ],
      ],
    );
  }
}
