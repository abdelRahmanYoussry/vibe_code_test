import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:size_config/size_config.dart';

import '../../../products/models/product_model_api.dart';
import 'product_customization_theme.dart';

class ProductCustomization extends StatefulWidget {
  const ProductCustomization({
    super.key,
    required this.model,
    required this.onOptionSelected,
  });

  final ProductOptionApiModel model;
  final Function(String optionId, String? selectedValue) onOptionSelected;
  @override
  State<ProductCustomization> createState() => _ProductCustomizationState();
}

class _ProductCustomizationState extends State<ProductCustomization> {
  late final ValueNotifier<String?> selectedIdNotifier;

  @override
  void initState() {
    super.initState();
    selectedIdNotifier = ValueNotifier(null);
    selectedIdNotifier.addListener(() {
      widget.onOptionSelected(widget.model.id, selectedIdNotifier.value);
    });
  }

  @override
  void dispose() {
    selectedIdNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myTheme = ProductCustomizationTheme.of(context);
    final header = ExpandableButton(
      theme: myTheme.expandableThemeData,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 4.h,
              children: [
                Text(
                  widget.model.name,
                  style: myTheme.titleTextStyle,
                ),
                Text(
                  Loc.of(context).choose_n(1),
                  style: myTheme.subtitleStyle,
                ),
              ],
            ),
          ),
          ExpandableIcon(
            theme: myTheme.expandableThemeData,
          ),
        ],
      ),
    );

    return DividerTheme(
      data: myTheme.dividerThemeData,
      child: ExpandableNotifier(
        initialExpanded: true,
        child: Expandable(
          theme: myTheme.expandableThemeData,
          collapsed: header,
          expanded: ValueListenableBuilder(
            valueListenable: selectedIdNotifier,
            builder: (context, id, child) => Column(
              children: [
                header,
                for (final item in widget.model.values) ...[
                  InkWell(
                    onTap: () {
                      if (item.id == selectedIdNotifier.value) {
                        // Deselect if already selected
                        selectedIdNotifier.value = null;
                      } else {
                        // Select if not selected
                        selectedIdNotifier.value = item.id;
                      }
                    },
                    child: RadioListTile<String>(
                      value: item.id,
                      groupValue: id,
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.name,
                        style: myTheme.optionTextStyle,
                      ),
                      fillColor: myTheme.radioFillColor,
                      controlAffinity: ListTileControlAffinity.trailing,
                      // Make it completely non-interactive
                      onChanged: null,
                    ),
                  ),
                  Divider(),
                ],
                // for (final item in widget.model.values) ...[
                //   RadioListTile<String>(
                //     value: item.id,
                //     groupValue: id,
                //     contentPadding: EdgeInsets.zero,
                //     selected: selectedIdNotifier.value == item.id,
                //     title: Text(
                //       '${item.name} (${item.formatPrice.replaceAll("+", '').replaceAll(" ", '')})',
                //       style: myTheme.optionTextStyle,
                //     ),
                //     fillColor: myTheme.radioFillColor,
                //     controlAffinity: ListTileControlAffinity.trailing,
                //     onChanged: (value) {
                //       debugPrint('selected optionnnn: ${selectedIdNotifier.value}');
                //       debugPrint('selected optionoon: ${value}');
                //       if(selectedIdNotifier.value == value){
                //         selectedIdNotifier.value = null;
                //         // debugPrint('Unselected option: $value');
                //       }else {
                //         // debugPrint('Unselected op2tion: $value');
                //         // debugPrint('Selected option: ${selectedIdNotifier.value}');
                //         selectedIdNotifier.value = value;
                //       }
                //     },
                //   ),
                //   Divider(),
                // ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
