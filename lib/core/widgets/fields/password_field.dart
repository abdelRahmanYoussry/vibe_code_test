import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/utils/data_utils.dart';
import 'package:test_vibe/core/widgets/fields/field_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.controller,
    this.focusNode,
    this.onFieldSubmitted,
    this.confirmedPassword,
    this.label,
    this.textInputAction = TextInputAction.next,
  });

  final TextEditingController? controller;
  final TextInputAction textInputAction;
  final FocusNode? focusNode;
  final ValueChanged<String>? onFieldSubmitted;
  final String? confirmedPassword;
  final String? label;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
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
    bool obscurePass = true;
    return StatefulBuilder(
      builder: (context, setState) => FieldLabel(
        label: widget.label ?? Loc.of(context).password,
        child: TextFormField(
          controller: widget.controller,
          focusNode: focusNode,
          onTapOutside: (event) => focusNode.unfocus(),
          onFieldSubmitted: widget.onFieldSubmitted,
          obscureText: obscurePass,
          textAlign: TextAlign.start,
          textInputAction: widget.textInputAction,
          autofillHints: const [
            AutofillHints.password,
            AutofillHints.newPassword,
          ],
          validator: (value) {
            final result = validate(context, value);
            return result;
          },
          decoration: InputDecoration(
            hintText: Loc.of(context).password_hint,
            errorMaxLines: 3,
            suffixIcon: ExcludeFocus(
              child: IconButton(
                onPressed: () => setState.call(() => obscurePass = !obscurePass),
                icon: Icon(
                  obscurePass ? CupertinoIcons.eye_slash : CupertinoIcons.eye,
                  color: Theme.of(context).inputDecorationTheme.suffixIconColor,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String? validate(BuildContext context, String? value) {
    if (!validString(value)) {
      return Loc.of(context).empty_field(widget.label ?? Loc.of(context).password);
    }
    if (validString(widget.confirmedPassword)) {
      if (value != widget.confirmedPassword) {
        return Loc.of(context).password_mismatch;
      }
    } else {
      if (!validPasswordLength(value)) {
        return Loc.of(context).short_password;
      }
      if (!validPasswordContent(value)) {
        return Loc.of(context).weak_password;
      }
    }
    return null;
  }
}
