import 'package:flutter/material.dart';

class LanguageSelector extends StatelessWidget {
  final String selectedLanguageCode;
  final ValueChanged<String> onChanged;

  const LanguageSelector({
    super.key,
    required this.selectedLanguageCode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const languages = [
      ('en', '🇬🇧', 'English'),
      ('uk', '🇺🇦', 'Українська'),
      ('ru', '🇺🇦', 'Русский'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: languages.map((language) {
        final isSelected = selectedLanguageCode == language.$1;
        return ChoiceChip(
          selected: isSelected,
          label: Text('${language.$2} ${language.$3}'),
          selectedColor: const Color(0xFFFFCC7A),
          backgroundColor: const Color(0xFFFFF1D9).withValues(alpha: 0.10),
          labelStyle: TextStyle(
            color: isSelected ? const Color(0xFF241109) : const Color(0xFFFFE2B8),
            fontWeight: FontWeight.w700,
          ),
          onSelected: (_) => onChanged(language.$1),
        );
      }).toList(),
    );
  }
}
