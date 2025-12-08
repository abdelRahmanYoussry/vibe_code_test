import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/fields/field_label.dart';
import 'package:flutter/material.dart';

class NameField extends StatefulWidget {
  const NameField({
    super.key,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.textInputAction = TextInputAction.next,
    this.filled ,
    this.backgroundColor,
  });

  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final bool ?filled ;
  final Color ?backgroundColor;
  @override
  State<NameField> createState() => _EmailFieldState();
}

class _EmailFieldState extends State<NameField> {
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
      label: Loc.of(context).name,
      child: TextFormField(
        controller: widget.controller,
        focusNode: focusNode,
        textDirection: TextDirection.ltr,
        onTapOutside: (event) => focusNode.unfocus(),
        onFieldSubmitted: widget.onFieldSubmitted,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.name,
        textInputAction: widget.textInputAction,
        autofillHints: const [
          AutofillHints.name,
        ],
        validator: (value) {
          final result = validate(context, value);
          return result;
        },
        decoration: InputDecoration(
          hintText: Loc.of(context).name_hint,
          fillColor: widget.backgroundColor,
          filled: widget.filled ,
        ),
      ),
    );
  }

  String? validate(BuildContext context, String? value) {
    if (!validString(value)) {
      return Loc.of(context).empty_field(Loc.of(context).name);
    }
    if (!validName(value)) {
      return Loc.of(context).invalid_name;
    }
    return null;
  }
}
