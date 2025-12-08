import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/modules/app/orders/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/theme/constants/app_colors.dart';

class EditOrderOverview extends StatelessWidget {
  final OrderModel orderModel;
  final List<OrderProductModel> editableProducts;
  final Map<int, int> productQuantities;
  final bool isLoading;
  final VoidCallback onUpdateOrder;

  const EditOrderOverview({
    super.key,
    required this.orderModel,
    required this.editableProducts,
    required this.productQuantities,
    required this.isLoading,
    required this.onUpdateOrder,
  });

  double get _newSubTotal {
    return editableProducts.fold(0.0, (sum, product) {
      final qty = productQuantities[product.id] ?? product.qty;
      return sum + qty * product.price;
    });
  }

  double _parsePrice(String priceString) {
    // Remove currency symbols and extract numeric value
    final numericString = priceString.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(numericString) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final originalSubTotal = _parsePrice(orderModel.subTotal);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.greyF5,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Loc.of(context).order_summary,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          SizedBox(height: 12.h),
          _buildSummaryRow(
            Loc.of(context).original_subtotal,
            originalSubTotal.toStringAsFixed(2),
            isOriginal: true,
          ),
          _buildSummaryRow(
            Loc.of(context).new_subtotal,
            _newSubTotal.toStringAsFixed(2),
            isNew: true,
          ),
          Divider(height: 20.h),
          _buildSummaryRow(
            Loc.of(context).difference,
            (_newSubTotal - originalSubTotal).toStringAsFixed(2),
            isDifference: true,
          ),
          SizedBox(height: 20.h),
          CustomElevatedButton(
            onPressed: editableProducts.isEmpty ? null : onUpdateOrder,
            loading: isLoading,
            child: Text(Loc.of(context).update_order),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    bool isOriginal = false,
    bool isNew = false,
    bool isDifference = false,
  }) {
    Color? textColor;
    FontWeight? fontWeight;

    if (isOriginal) {
      textColor = Colors.grey;
    } else if (isNew) {
      textColor = AppColors.brown33;
      fontWeight = FontWeight.w600;
    } else if (isDifference) {
      final diff = double.parse(value);
      textColor = diff > 0
          ? Colors.green
          : diff < 0
              ? Colors.red
              : Colors.grey;
      fontWeight = FontWeight.w600;
    }

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: textColor,
              fontWeight: fontWeight,
            ),
          ),
        ],
      ),
    );
  }
}
