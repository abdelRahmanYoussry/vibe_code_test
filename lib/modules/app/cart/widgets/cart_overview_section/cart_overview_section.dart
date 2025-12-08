import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/fields/coupon_field/coupon_field.dart';
import 'package:test_vibe/core/widgets/snack_bar/snack_bar.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/di/di.dart';
import '../../../check_out/bloc/check_out_bloc.dart';
import '../../../check_out/bloc/check_out_state.dart';
import '../../models/add_to_cart_model.dart';
import 'cart_overview_section_theme.dart';

class CartOverviewSection extends StatefulWidget {
  const CartOverviewSection(
      {super.key, required this.cartData, this.enableCheckOut = true, required this.onCouponApplied,});

  final AddToCartDataModel cartData;
  final bool enableCheckOut;
  final VoidCallback onCouponApplied;

  @override
  State<CartOverviewSection> createState() => _CartOverviewSectionState();
}

class _CartOverviewSectionState extends State<CartOverviewSection> {
  late ExpandableController expandableController;

  @override
  void initState() {
    super.initState();
    expandableController = ExpandableController(initialExpanded: false);
  }

  @override
  void dispose() {
    expandableController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = CartOverviewSectionTheme.of(context);
    int totalItems = widget.cartData.count;
    return Container(
      decoration: myTheme.backgroundDecoration,
      padding: SpacingTheme.of(context).pagePadding,
      child: Column(
        children: [
          SizedBox(height: 24.h),
          _buildItem(myTheme, '${Loc.of(context).subtotal}:', widget.cartData.subTotalPrice),
          SizedBox(height: 10.h),
          _buildItem(myTheme, '${Loc.of(context).items_count}:', Loc.of(context).nItems(totalItems)),
          SizedBox(height: 10.h),
          _buildItem(myTheme, '${Loc.of(context).taxes}:', widget.cartData.taxes),
          SizedBox(height: 10.h),
          _buildItem(myTheme, '${Loc.of(context).discount}:', widget.cartData.discount ?? 'AED 0.00'),
          SizedBox(height: 10.h),
          _buildItem(myTheme, '${Loc.of(context).total_price}:', widget.cartData.totalPrice),
          SizedBox(height: 10.h),
          _buildExpandableItem(myTheme, Loc.of(context).add_coupon),
          SizedBox(height: 24.h),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Nav.root.replaceAll(context);
                  },
                  child: Text(
                    Loc.of(context).add_item,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              BlocProvider(
                create: (context) => di<CheckOutBloc>(),
                child: BlocListener<CheckOutBloc, CheckOutState>(
                  listener: (context, state) {
                    if (state.orderCheckState.success != null &&
                        state.orderCheckState.success! &&
                        state.orderCheckState.data?.isCreditCardPayment() == false) {
                      SnackBarBuilder.showFeedBackMessage(
                        context,
                        state.orderCheckState.data?.message ?? Loc.of(context).successfully_added('order'),
                        isSuccess: true,
                        duration: 3,
                        onTap: () {},
                      );
                      Nav.root.replaceAll(context);
                    } else if (state.orderCheckState.error != null) {
                      SnackBarBuilder.showFeedBackMessage(
                        context,
                        state.orderCheckState.error ?? Loc.of(context).something_went_wrong,
                        isSuccess: false,
                        duration: 3,
                        onTap: () {},
                      );
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      return Expanded(
                        child: BlocSelector<CheckOutBloc, CheckOutState, OrderCheckState>(
                          selector: (state) {
                            return state.orderCheckState;
                          },
                          builder: (context, state) {
                            return CustomElevatedButton(
                              enabled: widget.enableCheckOut,
                              loading: state.loadingState.loading,
                              onPressed: () {
                                if (widget.cartData.subTotalPrice == 'AED 0.00') {
                                  BlocProvider.of<CheckOutBloc>(context).checkOutOrder(paymentType: 'cash');
                                } else {
                                  Nav.paymentMethods.push(context);
                                }
                              },
                              child: Text(
                                Loc.of(context).checkout,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 35.h),
        ],
      ),
    );
  }

  Widget _buildItem(CartOverviewSectionTheme myTheme, String label, String value) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLabel(myTheme, label),
            _buildValue(myTheme, value),
          ],
        ),
        SizedBox(height: 8.h),
        Divider(),
      ],
    );
  }

  Widget _buildExpandableItem(CartOverviewSectionTheme myTheme, String label) {
    final _couponController = TextEditingController();
    final header = GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        expandableController.expanded = true;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLabel(myTheme, label),
          ValueListenableBuilder(
            valueListenable: expandableController,
            builder: (context, expanded, child) => TweenAnimationBuilder<double>(
              duration: myTheme.couponInputExpandableTheme.animationDuration ?? Duration(milliseconds: 250),
              curve: myTheme.couponInputExpandableTheme.fadeCurve ?? Curves.easeInOut,
              tween: Tween(end: expanded ? 0 : 1),
              builder: (context, value, child) => Opacity(
                opacity: value.clamp(0, 1),
                child: child!,
              ),
              child: child,
            ),
            child: Icon(
              myTheme.couponInputExpandableTheme.expandIcon,
              size: myTheme.couponInputExpandableTheme.iconSize,
              color: myTheme.couponInputExpandableTheme.iconColor,
            ),
          ),
        ],
      ),
    );
    return BlocProvider(
      create: (context) => di<CheckOutBloc>(),
      child: BlocListener<CheckOutBloc, CheckOutState>(
        listener: (context, state) {
          if (state.validateCouponState.success != null && state.validateCouponState.success == true) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              Loc.of(context).coupon_applied,
            );
            expandableController.expanded = false;
            widget.onCouponApplied();
          } else if (state.validateCouponState.error != null) {
            SnackBarBuilder.showFeedBackMessage(
              context,
              state.validateCouponState.error ?? 'Error applying coupon',
            );
          }
        },
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                ExpandableNotifier(
                  controller: expandableController,
                  child: Expandable(
                    theme: myTheme.couponInputExpandableTheme,
                    collapsed: header,
                    expanded: Column(
                      children: [
                        header,
                        SizedBox(height: 10.h),
                        CouponField(
                          controller: _couponController,
                          onFieldSubmitted: (value) {
                            context.read<CheckOutBloc>().validateCoupon(coupon: value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 24.h),
                Divider(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildLabel(CartOverviewSectionTheme myTheme, String label) => Text(
        label,
        style: myTheme.labelTextStyle,
      );

  Widget _buildValue(CartOverviewSectionTheme myTheme, String value) => Text(
        value,
        style: myTheme.valueTextStyle,
      );
}
