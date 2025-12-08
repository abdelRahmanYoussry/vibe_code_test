import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/appbars/custom_appbar.dart';
import 'package:test_vibe/core/widgets/buttons/custom_elevated_button.dart';
import 'package:test_vibe/core/widgets/custom_scaffold.dart';
import 'package:test_vibe/core/widgets/fields/add_credit_card/card_holder_field.dart';
import 'package:test_vibe/core/widgets/fields/add_credit_card/card_number_field.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../core/theme/extensions/spacing_theme.dart';
import '../../../core/widgets/fields/add_credit_card/card_cvv_field.dart';
import '../../../core/widgets/fields/add_credit_card/card_expire_date_field.dart';

class AddCreditCardPage extends StatefulWidget {
  const AddCreditCardPage({super.key});

  @override
  State<AddCreditCardPage> createState() => _AddCreditCardPageState();
}

class _AddCreditCardPageState extends State<AddCreditCardPage> {
  late final TextEditingController cardHolderController;
  late final TextEditingController cardNumberController;
  late final TextEditingController expiryDateController;
  late final TextEditingController cvvController;
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    super.initState();
    cardHolderController = TextEditingController();
    cardNumberController = TextEditingController();
    expiryDateController = TextEditingController();
    cvvController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  dispose() {
    cardHolderController.dispose();
    cardNumberController.dispose();
    expiryDateController.dispose();
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: CustomAppbar(
        title: Text(Loc.of(context).addCard),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: SpacingTheme.of(context).pagePadding,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 8.h,
                            ),
                            CardHolderField(
                              controller: cardHolderController,
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            CardNumberField(
                              controller: cardNumberController,
                            ),
                            SizedBox(
                              height: 24.h,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CardExpireDateField(
                                    controller: expiryDateController,
                                  ),
                                ),
                                SizedBox(
                                  width: 16.w,
                                ),
                                Expanded(
                                  child: CardCvvField(
                                    controller: cvvController,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CustomElevatedButton(
                          child: Text(Loc.of(context).addCard),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {


                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
