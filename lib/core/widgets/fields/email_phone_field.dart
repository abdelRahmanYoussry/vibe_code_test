import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

import '../../localization/gen/loc.dart';

class EmailOrPhoneField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final Function(Country)? onCountryPicked;
  final ValueNotifier<Country>? countryNotifier;

  const EmailOrPhoneField({
    super.key,
    required this.controller,
    this.textInputAction,
    this.onCountryPicked,
    this.countryNotifier,
  });

  @override
  State<EmailOrPhoneField> createState() => _EmailOrPhoneFieldState();
}

class _EmailOrPhoneFieldState extends State<EmailOrPhoneField> {
  bool _isEmailMode = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_checkInputType);
  }

  void _checkInputType() {
    final text = widget.controller.text;
    final containsAt = text.contains('@');

    if (containsAt != _isEmailMode) {
      setState(() {
        _isEmailMode = containsAt;
      });
    }
  }

  String? _validator(String? value) {
    if (value == null || value.isEmpty) {
      return Loc.of(context).field_required;
    }

    if (_isEmailMode) {
      // Email validation
      final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
      if (!emailRegex.hasMatch(value)) {
        return Loc.of(context).invalid_email;
      }
    } else {
      // Phone validation
      if (value.length < 7) {
        return Loc.of(context).invalid_phone;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: TextInputType.text,
      textInputAction: widget.textInputAction,
      validator: _validator,
      decoration: InputDecoration(
        hintText: Loc.of(context).enter_email_or_phone,
        prefixIcon: Icon( Icons.person_3_outlined ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkInputType);
    super.dispose();
  }
}
