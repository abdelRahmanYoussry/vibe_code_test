import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/constants/app_colors.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/fields/coupon_field/coupon_field_theme.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class CouponField extends StatefulWidget {
  const CouponField({
    super.key,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<CouponField> createState() => _CouponFieldState();
}

class _CouponFieldState extends State<CouponField> {
  late final FocusNode focusNode;
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleSubmit() {
    if (_controller.text.isNotEmpty && widget.onFieldSubmitted != null) {
      widget.onFieldSubmitted!(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: CouponFieldTheme.of(context).inputDecorationTheme,
      ),
      child: TextFormField(
        controller: _controller,
        focusNode: focusNode,
        textDirection: TextDirection.ltr,
        onTapOutside: (event) => focusNode.unfocus(),
        onFieldSubmitted: widget.onFieldSubmitted,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.text,
        textInputAction: widget.textInputAction,
        validator: (value) {
          final result = validate(context, value);
          return result;
        },
        decoration: InputDecoration(
          hintText: Loc.of(context).enter_coupon_code,
          fillColor: CouponFieldTheme.of(context).inputDecorationTheme.fillColor,
          filled: true,
          suffixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: ValueListenableBuilder<TextEditingValue>(
              valueListenable: _controller,
              builder: (context, value, child) {
                final hasText = value.text.isNotEmpty;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (hasText)
                      GestureDetector(
                        onTap: _handleSubmit,
                        child: Builder(
                          builder: (context) {
                            // final iconTheme = IconTheme.of(context);
                            return SizedBox(
                              height: 35.h,
                              width: 90.w,
                              child: CustomElevatedButton(
                                onPressed: _handleSubmit,
                                child: Text(
                                  Loc.of(context).apply,
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    // SizedBox(width: hasText ? 2.w : 0),
                    if (!hasText)
                      Builder(
                        builder: (context) {
                          final iconTheme = IconTheme.of(context);
                          return Pic(
                            Assets.icons.ticket.path,
                            size: iconTheme.size,
                            color: iconTheme.color,
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String? validate(BuildContext context, String? value) {
    if (!validString(value)) {
      return Loc.of(context).empty_field(Loc.of(context).coupon);
    }
    return null;
  }
}
