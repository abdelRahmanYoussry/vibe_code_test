import 'package:test_vibe/modules/app/check_out/widgets/payment_method_theme.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = PaymentMethodTheme.of(context);
    return SliverToBoxAdapter(
      child: Padding(
        padding:  EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          title,
          style: myTheme.titleTextStyle,
        ),
      ),
    );
  }
}
