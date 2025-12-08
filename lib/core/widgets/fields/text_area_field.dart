import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:flutter/material.dart';

class TextAreaField extends StatefulWidget {
  const TextAreaField({
    super.key,
    this.controller,
    required this.hint,
    this.focusNode,
    this.onFieldSubmitted,
    this.maxChars,
    this.decoration,
    this.autoFocus = false,
    this.readOnly = false,
    this.required = true,
    this.minLines,
    this.maxLines,
    this.textInputAction,
  });

  final String hint;
  final bool autoFocus;
  final int? maxChars;
  final int? minLines;
  final int? maxLines;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final InputDecoration? decoration;
  final ValueChanged<String>? onFieldSubmitted;
  final bool readOnly;
  final bool required;
  final TextInputAction? textInputAction;

  @override
  State<TextAreaField> createState() => _TextAreaFieldState();
}

class _TextAreaFieldState extends State<TextAreaField> {
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
    if (widget.autoFocus) {
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: focusNode,
      onTapOutside: (event) => focusNode.unfocus(),
      onFieldSubmitted: widget.onFieldSubmitted,
      keyboardType: TextInputType.multiline,
      minLines: widget.minLines ?? 5,
      maxLines: widget.maxLines ?? 10,
      maxLength: widget.maxChars,
      readOnly: widget.readOnly,
      textInputAction: widget.textInputAction,
      validator: !widget.required
          ? null
          : (value) {
              final result = validate(context, value);
              return result;
            },
      decoration: widget.decoration ??
          InputDecoration(
            hintText: widget.hint,
          ),
    );
  }

  String? validate(BuildContext context, String? value) {
    if (!validString(value)) {
      return widget.hint;
    }
    return null;
  }
}
