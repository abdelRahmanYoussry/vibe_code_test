import 'package:auto_size_text/auto_size_text.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/utils/functions.dart';
import 'package:test_vibe/modules/app/orders/models/order_model.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../../../core/navigation/nav.dart';
import '../../../../../core/theme/constants/app_colors.dart';
import '../../../../../core/widgets/pic.dart';
import '../../../qr_codes/widgets/qr_product_item/qr_product_item_theme.dart';

class OrderProductItem extends StatefulWidget {
  const OrderProductItem({
    super.key,
    required this.model,
    this.showProductType = true,
    this.isOffer = false,
    this.onCancelOrder,
    this.isDeleteLoading = false,
  });

  final OrderModel model;
  final bool showProductType;
  final bool isOffer;
  final VoidCallback? onCancelOrder;
  final bool isDeleteLoading;

  @override
  State<OrderProductItem> createState() => _OrderProductItemState();
}

class _OrderProductItemState extends State<OrderProductItem> {
  bool _expanded = true;

  bool get _canCancelOrder {
    final status = widget.model.status.toLowerCase();
    return status == 'pending';
  }

  void _showCancelConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Loc.of(context).cancel_order),
          content: Text(
            '${Loc.of(context).are_you_sure_cancel_order} #${widget.model.orderId} ?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                Loc.of(context).no,
                style: TextStyle(
                  color: AppColors.brown33,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                widget.onCancelOrder?.call();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
              ),
              child: Text(Loc.of(context).yes_cancel),
            ),
          ],
        );
      },
    );
  }

  bool get _canEditOrder {
    final status = widget.model.status.toLowerCase();
    final hasOffers = widget.model.products.any((product) => product.isOffer || product.isFreeOffer);
    return (status == 'pending') && !hasOffers;
  }

  void _showEditOrder() {
    Nav.editOder.push(context, args: widget.model);
  }

  @override
  Widget build(BuildContext context) {
    final qrProductItemTheme = QrProductItemTheme.of(context);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        setState(() {
          _expanded = !_expanded;
        });
      },
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: !widget.isOffer ? Colors.transparent : AppColors.red6E,
                width: !widget.isOffer ? 0.sp : 2.sp,
              ),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Column(
              children: [
                // ListTile(
                //   contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                //   title: Row(
                //     children: [
                //       Text(
                //         Loc.of(context).order_number(widget.model.orderId),
                //         style: qrProductItemTheme.titleTextStyle,
                //       ),
                //       Spacer(),
                //       Container(
                //         padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                //         decoration: BoxDecoration(
                //           color: _getStatusColor(widget.model.status),
                //           borderRadius: BorderRadius.circular(4),
                //         ),
                //         child: Text(
                //           widget.model.status.toUpperCase(),
                //           style: TextStyle(
                //             color: Colors.white,
                //             fontSize: 10.sp,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                //   subtitle: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Text(
                //         '${Loc.of(context).items_count}: ${widget.model.productsCount}',
                //         style: qrProductItemTheme.subtitleTextStyle,
                //       ),
                //       Text(
                //         '${Loc.of(context).subtotal}: ${widget.model.subTotal}',
                //         style: qrProductItemTheme.subtitleTextStyle,
                //       ),
                //       Text(
                //         '${Loc.of(context).date}: ${convertUtcToLocalTime(widget.model.createdAt, 'MMM d, yyyy h:mm a')}',
                //         style: qrProductItemTheme.subtitleTextStyle,
                //       ),
                //       if (_canCancelOrder)
                //         Padding(
                //           padding: EdgeInsets.only(top: 8.h),
                //           child: widget.isDeleteLoading
                //               ? CircularProgressIndicator()
                //               : GestureDetector(
                //                   onTap: _showCancelConfirmation,
                //                   child: Container(
                //                     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                //                     decoration: BoxDecoration(
                //                       color: Colors.red.withOpacity(0.1),
                //                       borderRadius: BorderRadius.circular(4),
                //                       border: Border.all(color: Colors.red, width: 1),
                //                     ),
                //                     child: Text(
                //                       Loc.of(context).cancel_order,
                //                       style: TextStyle(
                //                         color: Colors.red,
                //                         fontSize: 12.sp,
                //                         fontWeight: FontWeight.w500,
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //         ),
                //       if (_canEditOrder)
                //         Padding(
                //           padding: EdgeInsets.only(top: 8.h),
                //           child: GestureDetector(
                //             onTap: _showEditOrder,
                //             child: Container(
                //               padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                //               decoration: BoxDecoration(
                //                 color: Colors.blue.withOpacity(0.1),
                //                 borderRadius: BorderRadius.circular(4),
                //                 border: Border.all(color: Colors.blue, width: 1),
                //               ),
                //               child: Text(
                //                 Loc.of(context).edit_order,
                //                 style: TextStyle(
                //                   color: Colors.blue,
                //                   fontSize: 12.sp,
                //                   fontWeight: FontWeight.w500,
                //                 ),
                //               ),
                //             ),
                //           ),
                //         ),
                //     ],
                //   ),
                //   trailing: IconButton(
                //     icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more),
                //     onPressed: () {
                //       setState(() {
                //         _expanded = !_expanded;
                //       });
                //     },
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 12.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              Loc.of(context).order_number(widget.model.orderId),
                              style: qrProductItemTheme.titleTextStyle.copyWith(
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                            decoration: BoxDecoration(
                              color: _getStatusColor(widget.model.status),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.model.status.toUpperCase(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 12.w),
                          if (_canEditOrder)
                            Container(
                              width: 32.w,
                              height: 32.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.green, width: 2.sp),
                              ),
                              child: IconButton(
                                onPressed: _showEditOrder,
                                icon: Icon(
                                  Icons.mode_edit_outline_outlined,
                                  size: 18.sp,
                                  color: Colors.green,
                                ),
                                style: ButtonStyle(
                                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                  padding: WidgetStateProperty.all(EdgeInsets.zero),
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      // Order details
                      Text(
                        '${Loc.of(context).items_count}: ${widget.model.productsCount}',
                        style: qrProductItemTheme.subtitleTextStyle,
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '${Loc.of(context).date}: ${convertUtcToLocalTime(widget.model.createdAt, 'MMM d, yyyy h:mm a')}',
                        style: qrProductItemTheme.subtitleTextStyle,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${Loc.of(context).subtotal}: ${widget.model.subTotal}',
                            style: qrProductItemTheme.subtitleTextStyle,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color:AppColors.brown33, width: 1),
                            ),
                            child: IconButton(
                              style: ButtonStyle(
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                padding: WidgetStateProperty.all(EdgeInsets.zero),
                              ),
                              icon: Icon(
                                _expanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                                color: AppColors.brown33,
                                size: 22.sp,
                              ),
                              onPressed: () {
                                setState(() {
                                  _expanded = !_expanded;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      // if (_canCancelOrder)
                      // SizedBox(height: 12.h),
                      // Action buttons row
                      if (_canCancelOrder)
                      widget.isDeleteLoading
                          ? CircularProgressIndicator()
                          : GestureDetector(
                              onTap: _showCancelConfirmation,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(color: Colors.grey, width: 1),
                                ),
                                child: Text(
                                  Loc.of(context).cancel_order,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
                if (_expanded)
                  Column(
                    children: widget.model.products.map((product) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                        child: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Nav.productDetailsSheet.sheet(context, args: product);
                          },
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                                child: Pic(
                                  product.imageUrl?.url ?? '',
                                  fit: BoxFit.cover,
                                  width: 60.w,
                                  height: 60.w,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AutoSizeText(
                                      product.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: qrProductItemTheme.titleTextStyle,
                                      minFontSize: 8.sp,
                                      maxFontSize: qrProductItemTheme.titleTextStyle.fontSize ?? 14.sp,
                                      stepGranularity: 1.sp,
                                    ),
                                    if (product.description.isNotEmpty)
                                      Text(
                                        product.description ?? Loc.of(context).no_description,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: qrProductItemTheme.subtitleTextStyle,
                                      ),
                                    Text(
                                      product.isFreeOffer ? Loc.of(context).free : product.formattedPrice,
                                      style: qrProductItemTheme.titleTextStyle,
                                    ),
                                    Text(
                                      '${Loc.of(context).quantity}: ${product.qty}',
                                      style: qrProductItemTheme.subtitleTextStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
          SizedBox(height: 16.h),
          Divider(),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  static final gridDelegate = SliverGridDelegateWithMaxCrossAxisExtent(
    maxCrossAxisExtent: 175.w,
    mainAxisExtent: 200.h,
    crossAxisSpacing: 8.w,
    mainAxisSpacing: 24.h,
  );
}

Color _getStatusColor(String status) {
  switch (status.toLowerCase()) {
    case 'pending':
      return Colors.amber;
    case 'processing':
      return Color(0xff2196F3);
    case 'preparing':
      return Color(0xffFF9800);
    case 'ready':
      return Colors.green;
    case 'completed':
      return Colors.green;
    default:
      return Colors.grey;
  }
}
