import 'package:test_vibe/modules/app/check_out/widgets/payment_method_theme.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import '../../../../core/theme/constants/app_colors.dart';

class AddCreditCardOption extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  final Widget leading;

  const AddCreditCardOption({
    super.key,
    required this.label,
    required this.onTap,
   required this.leading,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = PaymentMethodTheme.of(context);
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyD9, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: ListTile(
          leading: leading,
          title: Text(
            label,
            style: myTheme.titleTextStyle,
          ),
          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
          onTap: onTap,
        ),
      ),
    );
  }
}
