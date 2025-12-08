import 'package:flutter/material.dart';
import 'package:test_vibe/core/localization/gen/loc.dart';
import 'package:test_vibe/core/widgets/sheets/custom_sheet/custom_sheet.dart';

class LanguageSelectionSheet extends StatefulWidget {
  const LanguageSelectionSheet({super.key, required this.currentLang});

  final String currentLang;

  @override
  State<LanguageSelectionSheet> createState() => _LanguageSelectionSheetState();
}

class _LanguageSelectionSheetState extends State<LanguageSelectionSheet> {
  @override
  void initState() {
    super.initState();
    // context.read<SettingsBloc>().getLang();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSheet(
      title: Text(Loc.of(context).language),
      icon: Icon(Icons.language),
      builder: (context) => Column(
        children: [
          _buildLanguageOption(
            context: context,
            title: 'English',
            langCode: 'en',
            isSelected: widget.currentLang == 'en',
          ),
          const SizedBox(height: 16),
          _buildLanguageOption(
            context: context,
            title: 'العربية',
            langCode: 'ar',
            isSelected: widget.currentLang == 'ar',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required String title,
    required String langCode,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        if (!isSelected) {
          Navigator.pop(context, langCode);
        }
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Theme.of(context).colorScheme.primaryContainer : Colors.transparent,
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.white : Theme.of(context).textTheme.bodyLarge?.color,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}
