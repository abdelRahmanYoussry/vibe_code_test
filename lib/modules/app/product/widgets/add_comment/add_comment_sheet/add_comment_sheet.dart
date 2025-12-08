import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/theme/extensions/spacing_theme.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/fields/text_area_field.dart';
import 'package:test_vibe/core/widgets/system_colors_widget.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_bloc.dart';
import 'package:test_vibe/modules/app/cart/bloc/add_to_cart_state.dart';
import 'package:test_vibe/modules/app/product/widgets/add_comment/add_comment_header/add_comment_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_config/size_config.dart';

import '../add_comment_params.dart';

class AddCommentSheet extends StatefulWidget {
  const AddCommentSheet({super.key, required this.params});

  final AddCommentParams params;

  @override
  State<AddCommentSheet> createState() => _AddCommentSheetState();
}

class _AddCommentSheetState extends State<AddCommentSheet> {
  late final TextEditingController commentController;
  late final ValueNotifier<bool> hasCommentNotifier;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
    hasCommentNotifier = ValueNotifier<bool>(false);
    commentController.addListener(() {
      hasCommentNotifier.value = commentController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    commentController.dispose();
    hasCommentNotifier.dispose();
    commentController.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.params.bloc,
      child: BlocListener<AddToCartBloc, AddToCartState>(
        listenWhen: (previous, current) => previous.addCommentToProductState != current.addCommentToProductState,
        listener: (context, state) {
          if (state.addCommentToProductState.success != null && state.addCommentToProductState.success!) {
            Navigator.of(context).pop(commentController.text);
          }
        },
        child: Builder(
          builder: (context) {
            return SystemColorsWidget(
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 1.5, // اجعل الارتفاع يغطي الشاشة بالكامل
                child: Padding(
                  padding: SpacingTheme.of(context).pagePadding,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 16.h),
                      AddCommentHeader(),
                      SizedBox(height: 16.h),
                      SizedBox(
                        height: 118.h,
                        child: TextAreaField(
                          controller: commentController,
                          hint: Loc.of(context).add_your_comment_hint,
                          onFieldSubmitted: (value) {
                            widget.params.bloc.addCommentToProduct(
                              productId: widget.params.productId,
                              Comment: value,
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 33.h),
                      Row(
                        spacing: 8.w,
                        children: [
                          Expanded(
                            child: OutlinedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text(Loc.of(context).cancel),
                            ),
                          ),
                          BlocSelector<AddToCartBloc, AddToCartState, AddCommentToProductState>(
                            selector: (state) {
                              return state.addCommentToProductState;
                            },
                            builder: (context, state) {
                              return ValueListenableBuilder(
                                  valueListenable: hasCommentNotifier,
                                  builder: (context, hasComment, _) {
                                    return Expanded(
                                      child: CustomElevatedButton(
                                        loading: state.loadingState.loading,
                                        enabled: hasComment,
                                        onPressed: () {
                                          widget.params.bloc.addCommentToProduct(
                                            productId: widget.params.productId,
                                            Comment: commentController.text,
                                          );
                                        },
                                        child: Text(Loc.of(context).add),
                                      ),
                                    );
                                  },);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 35.h),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
