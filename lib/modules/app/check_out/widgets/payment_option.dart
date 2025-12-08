import 'package:test_vibe/modules/app/check_out/widgets/payment_method_theme.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../core/theme/constants/app_colors.dart';

class PaymentOption extends StatelessWidget {
  final IconData? icon;
  final String label;
  final String value;
  final String? groupValue;
  final Widget? leadingWidget;
  final ValueChanged<String?> onChanged;

  const PaymentOption({
    super.key,
    this.icon,
    required this.label,
    required this.value,
    required this.groupValue,
    this.leadingWidget,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final myTheme = PaymentMethodTheme.of(context);
    return SliverToBoxAdapter(
      key: ValueKey(value),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.greyD9, width: 2),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: RadioListTile<String>(
          value: value,
          groupValue: groupValue,
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
          title: Text(
            label,
            style: myTheme.paymentMethodStyle,
          ),
          secondary: leadingWidget ??
              (icon != null ? Icon(icon, size: 28) : null),
          controlAffinity: ListTileControlAffinity.trailing,
          fillColor: myTheme.radioFillColor,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
