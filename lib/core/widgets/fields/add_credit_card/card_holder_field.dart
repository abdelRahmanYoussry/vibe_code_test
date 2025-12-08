import 'package:flutter/material.dart';

import '../../../localization/gen/loc.dart';
import '../../../utils/data_utils.dart';
import '../field_label.dart';

class CardHolderField extends StatefulWidget {
  const CardHolderField({
    super.key,
    required this.controller,
    this.textInputAction = TextInputAction.next,
    this.focusNode,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<CardHolderField> createState() => _CardHolderFieldState();
}

class _CardHolderFieldState extends State<CardHolderField> {
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
      label: Loc.of(context).cardHolderName,
      child: TextFormField(
        controller: widget.controller,
        focusNode: focusNode,
        textDirection: TextDirection.ltr,
        onTapOutside: (event) => focusNode.unfocus(),
        onFieldSubmitted: widget.onFieldSubmitted,
        textAlign: TextAlign.start,
        textInputAction: widget.textInputAction,
        autofillHints: const [
          AutofillHints.name,
        ],
        validator: (value) {
          final result = validate(context, value);
          return result;
        },
        decoration: InputDecoration(
          hintText: 'Esther Howard',
        ),
      ),
    );
  }

  String? validate(BuildContext context, String? value) {
    if (!validString(value)) {
      return Loc.of(context).empty_field(Loc.of(context).cardHolderName);
    }
    if (!validCardNameHolder(value)) {
      return Loc.of(context).invalid_card_holder_name;
    }
    return null;
  }
}
