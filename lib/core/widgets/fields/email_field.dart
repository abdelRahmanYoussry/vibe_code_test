import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/fields/field_label.dart';
import 'package:flutter/material.dart';

class EmailField extends StatefulWidget {
  const EmailField({
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
  State<EmailField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<EmailField> {
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = widget.focusNode ?? FocusNode();
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
    return FieldLabel(
      label: Loc.of(context).email,
      child: TextFormField(
        controller: widget.controller,
        focusNode: focusNode,
        textDirection: TextDirection.ltr,
        onTapOutside: (event) => focusNode.unfocus(),
        onFieldSubmitted: widget.onFieldSubmitted,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.emailAddress,
        textInputAction: widget.textInputAction,
        autofillHints: const [
          AutofillHints.email,
        ],
        validator: (value) {
          final result = validate(context, value);
          return result;
        },
        decoration: InputDecoration(
          hintText: Loc.of(context).email_hint,
        ),
      ),
    );
  }

  String? validate(BuildContext context, String? value) {
    if (!validString(value)) {
      return Loc.of(context).empty_field(Loc.of(context).email);
    }
    if (!validEmail(value)) {
      return Loc.of(context).invalid_email;
    }
    return null;
  }
}
