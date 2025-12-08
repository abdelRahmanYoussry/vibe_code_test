import 'package:test_vibe/core/assets/gen/assets.gen.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/utils/debouncer.dart';
import 'package:test_vibe/core/widgets/pic.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.label,
    this.textAlign,
    this.keyboardType,
    this.maxLines = 1,
    this.style,
    this.decoration,
    this.textInputAction,
    this.autoFocus = false,
    this.clientSearch = false,
    this.onClearPressed,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final ValueChanged<String?>? onFieldSubmitted;
  final String? label;
  final TextInputType? keyboardType;
  final TextAlign? textAlign;
  final TextStyle? style;
  final InputDecoration? decoration;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final bool autoFocus;
  final bool clientSearch;
  final VoidCallback? onClearPressed;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final FocusNode focusNode;
  late final Debouncer debouncer;
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller ?? TextEditingController();
    focusNode = widget.focusNode ?? FocusNode();
    debouncer = Debouncer();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    if (widget.controller == null) {
      controller.dispose();
    }
    debouncer.dispose();
    super.dispose();
  }

  // search() {
  //   String? v = controller.text.trim();
  //   if (!widget.clientSearch) {
  //     if (v.length < 3) {
  //       v = null;
  //     }
  //   }
  //   debouncer.runLazy(
  //     () => widget.onFieldSubmitted?.call(v),
  //     widget.clientSearch ? 5 : 1250,
  //   );
  // }

  search() {
    String? v = controller.text.trim();
    if (v.length >= 3) {
      debouncer.runLazy(
            () => widget.onFieldSubmitted?.call(v),
        widget.clientSearch ? 1000 : 1250,
      );
    }
  }

  bool get hasSearch => controller.text.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, value, child) => TextFormField(
        controller: controller,
        focusNode: focusNode,
        onTapOutside: (event) => focusNode.unfocus(),
        onFieldSubmitted: (value) => search(),
        onChanged: (value) => search(),
        textAlign: widget.textAlign ?? TextAlign.start,
        keyboardType: widget.keyboardType,
        maxLines: widget.maxLines,
        textInputAction: widget.textInputAction,
        autofocus: widget.autoFocus,
        autofillHints: const [
          AutofillHints.name,
          AutofillHints.middleName,
          AutofillHints.familyName,
          AutofillHints.givenName,
          AutofillHints.nickname,
          AutofillHints.username,
          AutofillHints.newUsername,
        ],
        validator: (value) {
          final result = validate(context, value);
          return result;
        },
        style: widget.style,
        decoration: widget.decoration ??
            InputDecoration(
              hintText: widget.label ?? Loc.of(context).search,
              fillColor: Colors.white,
              filled:  true,
              suffixIcon: !hasSearch
                  ? null
                  : ExcludeFocus(
                      child: IconButton(
                        onPressed: () {
                          controller.clear();
                          if (widget.onClearPressed != null) {
                            widget.onClearPressed!();
                          } else {
                            search();
                          }
                        },
                        icon: Icon(
                          Icons.close,
                          color: Theme.of(context).inputDecorationTheme.suffixIconColor,
                        ),
                      ),
                    ),
              prefixIcon: SearchFieldPrefixIcon(),
            ),
      ),
    );
  }

  String? validate(BuildContext context, String? value) {
    if (!validString(value?.trim())) {
      return Loc.of(context).empty_field(widget.label ?? '').trim();
    }
    return null;
  }
}

class SearchFieldPrefixIcon extends StatelessWidget {
  const SearchFieldPrefixIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Pic(
          Assets.icons.search.path,
          size: 15.sp,
        ),
      ],
    );
  }
}
