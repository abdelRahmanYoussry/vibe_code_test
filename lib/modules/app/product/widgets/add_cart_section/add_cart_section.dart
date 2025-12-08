import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/quantity_counter/quantity_counter.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'add_cart_section_theme.dart';

class AddCartSection extends StatelessWidget {
  const AddCartSection({
    super.key,
    this.initial = 1,
    this.min = 1,
    this.max = 9999,
    this.onQuantityChanged,
    this.onAddToCartPressed,
    this.loading = false,
    this.price = "",
  });

  final int initial;
  final int min;
  final int max;
  final void Function(int quantity)? onQuantityChanged;
  final void Function(int quantity)? onAddToCartPressed;
  final bool loading ;
  final String price;
  @override
  Widget build(BuildContext context) {
    final myTheme = AddCartSectionTheme.of(context);
    return Container(
      height: 115.h,
      decoration: myTheme.backgroundDecoration,
      child: Material(
        child: Padding(
          padding: SpacingTheme.of(context).pagePadding,
          child: IntrinsicHeight(
            child: Row(
              spacing: 8.w,
              children: [
                Expanded(
                  child: QuantityCounter(
                    theme: myTheme.counterTheme,
                    initial: initial,
                    max: max,
                    min: min,
                    onChanged: onQuantityChanged,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: CustomElevatedButton(
                    style: myTheme.addCartButtonStyle,
                    loading: loading,
                    onPressed: onAddToCartPressed != null
                        ? () => onAddToCartPressed!(initial) // Default to initial value
                        : null,
                    child:price == "" ? Text(Loc.of(context).add_to_cart) :  Text('${Loc.of(context).add_to_cart} $price AED'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
