import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:test_vibe/modules/app/product/widgets/add_comment/add_comment_header/add_comment_header_theme.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class AddCommentHeader extends StatelessWidget {
  const AddCommentHeader({
    super.key,
    this.trailing,
  });

  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final myTheme = AddCommentHeaderTheme.of(context);
    return Row(
      children: [
        Pic(
          Assets.icons.noteFavorite.path,
          size: myTheme.leadingIconStyle.size,
          color: myTheme.leadingIconStyle.color,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            Loc.of(context).add_your_comment,
            style: myTheme.titleTextStyle,
          ),
        ),
        if (trailing != null)
          IconTheme(
            data: myTheme.trailingIconStyle,
            child: trailing!,
          ),
      ],
    );
  }
}
