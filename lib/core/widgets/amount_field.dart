import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/fields/field_label.dart';
import 'package:flutter/material.dart';

class AmountField extends StatefulWidget {
  const AmountField({
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
  State<AmountField> createState() => _AmountFieldState();
}

class _AmountFieldState extends State<AmountField> {
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
      label: Loc.of(context).transfer_amount,
      child: TextFormField(
        controller: widget.controller,
        focusNode: focusNode,
        textDirection: TextDirection.ltr,
        onTapOutside: (event) => focusNode.unfocus(),
        onFieldSubmitted: widget.onFieldSubmitted,
        textAlign: TextAlign.start,
        keyboardType: TextInputType.number,
        textInputAction: widget.textInputAction,
        autofillHints: const [
          AutofillHints.transactionAmount,
        ],
        validator: (value) {
          final result = validate(context, value);
          return result;
        },
        decoration: InputDecoration(
          hintText: '1 to 600 ${Loc.of(context).point}',
        ),
      ),
    );
  }

  String? validate(BuildContext context, String? value) {
    if (!validInt(value)) {
      return Loc.of(context).empty_field(Loc.of(context).points);
    }
    final intVal = int.tryParse(value ?? '') ?? 0;
    if (!validTransferPoints(intVal)) {
      return Loc.of(context).invalid_points;
    }
    return null;
  }
}
