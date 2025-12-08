import 'package:flutter/material.dart';

import '../../../localization/gen/loc.dart';
import '../../../utils/data_utils.dart';
import '../field_label.dart';

class CardCvvField extends StatefulWidget {
  const CardCvvField({
    super.key,
   required this.controller,
     this.textInputAction= TextInputAction.next,
    this.focusNode,
    this.onFieldSubmitted,
  });

  final TextEditingController controller;
 final  TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;

  @override
  State<CardCvvField> createState() => _CardCvvFieldState();
}

class _CardCvvFieldState extends State<CardCvvField> {
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
      label: Loc.of(context).cvv,
      child: TextFormField(
        controller: widget.controller,
        focusNode: focusNode,
        textDirection: TextDirection.ltr,
        onTapOutside: (event) => focusNode.unfocus(),
        onFieldSubmitted: widget.onFieldSubmitted,
        textAlign: TextAlign.start,
        textInputAction: widget.textInputAction,
        keyboardType: TextInputType.number ,
        autofillHints: const [
          AutofillHints.creditCardSecurityCode,
        ],
        validator: (value) {
          final result = validate(context, value);
          return result;
        },
        decoration: InputDecoration(
          hintText: '0000',
        ),
      ),
    );


  }
  String? validate(BuildContext context, String? value) {
    if (!validString(value)) {
      return Loc.of(context).empty_field(Loc.of(context).cvv);
    }
    if (!validCardNumber(value)) {
      return Loc.of(context).invalid_cvv;
    }
    return null;
  }
}
