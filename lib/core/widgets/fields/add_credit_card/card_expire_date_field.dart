import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../localization/gen/loc.dart';
import '../../../utils/data_utils.dart';
import '../field_label.dart';

class CardExpireDateField extends StatefulWidget {
  const CardExpireDateField({
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
  State<CardExpireDateField> createState() => _CardExpireDateFieldState();
}

class _CardExpireDateFieldState extends State<CardExpireDateField> {
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
      label: Loc.of(context).expiryDate,
      child: TextFormField(
        controller: widget.controller,
        focusNode: focusNode,
        textDirection: TextDirection.ltr,
        onTapOutside: (event) => focusNode.unfocus(),
        onFieldSubmitted: widget.onFieldSubmitted,
        textAlign: TextAlign.start,
        textInputAction: widget.textInputAction,
        keyboardType: TextInputType.number,
        autofillHints: const [
          AutofillHints.creditCardExpirationDate,
        ],
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4), // MM/YY is 5 characters
          CardExpireDateInputFormatter(),
        ],
        validator: (value) {
          final result = validate(context, value);
          return result;
        },
        decoration: InputDecoration(
          hintText: '02/30',
        ),
      ),
    );
  }

  String? validate(BuildContext context, String? value) {
    if (!validString(value)) {
      return Loc.of(context).empty_field(Loc.of(context).expiryDate);
    }
    if (!validCardExpiry(value)) {
      return Loc.of(context).invalid_expiry_date;
    }
    return null;
  }
}

class CardExpireDateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text.replaceAll('/', '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      if (i == 2) {
        buffer.write('/');
      }
      buffer.write(text[i]);
    }
    final formattedText = buffer.toString();
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
