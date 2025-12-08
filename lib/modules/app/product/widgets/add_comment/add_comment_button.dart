import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/navigation/nav.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import 'add_comment_header/add_comment_header.dart';
import 'add_comment_params.dart';

class AddCommentButton extends StatelessWidget {
  const AddCommentButton({super.key, required this.params});
final AddCommentParams params;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Nav.addCommentSheet.sheet(context,args: params);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: AddCommentHeader(
          trailing: Builder(
            builder: (context) {
              final iconTheme = IconTheme.of(context);
              return Pic(
                Assets.icons.addCircle.path,
                size: iconTheme.size,
                color: iconTheme.color,
              );
            },
          ),
        ),
      ),
    );
  }
}
