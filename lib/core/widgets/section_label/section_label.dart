import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/buttons/custom_text_button.dart';
import 'package:test_vibe/core/widgets/section_label/section_label_theme.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';
import 'package:sliver_tools/sliver_tools.dart';


class SectionLabel extends StatelessWidget {
  const SectionLabel({
    super.key,
    required this.label,
    required this.child,
    this.labelPadding,
    this.onSeeMorePressed,
    this.isRichText = false,
    this.label2,
    this.labelStyle,
    this.showNumbersOfFreeCubs = false,
    this.numbersOfFreeCubs,
  });

  final Widget child;
  final String label;
  final EdgeInsetsGeometry? labelPadding;
  final VoidCallback? onSeeMorePressed;
  final bool isRichText ;
   final String? label2;
   final String? numbersOfFreeCubs;
   final TextStyle? labelStyle;
 final bool?showNumbersOfFreeCubs;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: onSeeMorePressed != null ? EdgeInsets.zero : EdgeInsets.only(bottom: 8.h),
          child: SectionLabelHeader(
            label: label,
            labelPadding: labelPadding,
            onSeeMorePressed: onSeeMorePressed,
            isRichText: isRichText,
            label2: label2,
            labelStyle: labelStyle ,
            showNumbersOfFreeCubs: showNumbersOfFreeCubs ,
            numbersOfFreeCubs: numbersOfFreeCubs,
          ),
        ),
        child,
      ],
    );
  }
}

class SliverSectionLabel extends StatelessWidget {
  const SliverSectionLabel({
    super.key,
    required this.label,
    required this.sliver,
    this.labelContentGap,
    this.labelPadding,
    this.onSeeMorePressed,
  });

  final Widget sliver;
  final String label;
  final double? labelContentGap;
  final EdgeInsetsGeometry? labelPadding;
  final VoidCallback? onSeeMorePressed;

  @override
  Widget build(BuildContext context) {
    return MultiSliver(
      children: [
        SliverToBoxAdapter(
          child: Padding(
            padding: onSeeMorePressed != null ? EdgeInsets.zero : EdgeInsets.only(bottom: labelContentGap ?? 8.h),
            child: SectionLabelHeader(
              label: label,
              labelPadding: labelPadding,
              onSeeMorePressed: onSeeMorePressed,
            ),
          ),
        ),
        sliver,
      ],
    );
  }
}

class SectionLabelHeader extends StatelessWidget {
  const SectionLabelHeader({
    super.key,
    required this.label,
    this.labelPadding,
    this.onSeeMorePressed,
    this.labelStyle,
    this.isRichText = false,
    this.label2,
    this.showNumbersOfFreeCubs = false,
    this.numbersOfFreeCubs,

  });

  final String label;
  final String? label2;
  final String? numbersOfFreeCubs;
  final EdgeInsetsGeometry? labelPadding;
  final VoidCallback? onSeeMorePressed;
  final TextStyle? labelStyle;
  final bool isRichText ;
 final bool?showNumbersOfFreeCubs;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween ,
      children: [
        if (isRichText)
          Padding(
            padding: EdgeInsetsDirectional.only(start: 8.w, end: 8.w),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: labelStyle ?? SectionLabelTheme.of(context).labelStyle,
                  ),
                  if (label2 != null)
                    TextSpan(
                      text: ' $label2',
                      style:  SectionLabelTheme.of(context).labelStyle,
                    ),
                ],
              ),
            ),
          )
        else
        Expanded(
          child: Padding(
            padding: labelPadding ?? EdgeInsets.zero,
            child: Text(
              label,
              style: labelStyle ?? SectionLabelTheme.of(context).labelStyle,
            ),
          ),
        ),
        if (onSeeMorePressed != null)
          Padding(
            padding: EdgeInsetsDirectional.only(end: 8.w),
            child: CustomTextButton(
              onPressed: onSeeMorePressed,
              child: Text(
                Loc.of(context).see_all,
              ),
            ),
          ),
        if (showNumbersOfFreeCubs == true )
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$numbersOfFreeCubs',
                  style: labelStyle,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
