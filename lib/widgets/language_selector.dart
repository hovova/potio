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
      _LanguageOption('en', '🇬🇧', 'English'),
      _LanguageOption('uk', '🇺🇦', 'Українська'),
      _LanguageOption('ru', '🇷🇺', 'Русский'),
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: languages.map((language) {
        final isSelected = selectedLanguageCode == language.code;

        return ChoiceChip(
          selected: isSelected,
          label: Text('${language.flag} ${language.name}'),
          selectedColor: const Color(0xFFFFCC7A),
          backgroundColor: const Color(0xFFFFF1D9).withValues(alpha: 0.10),
          labelStyle: TextStyle(
            color: isSelected
                ? const Color(0xFF241109)
                : const Color(0xFFFFE2B8),
            fontWeight: FontWeight.w800,
          ),
          side: BorderSide(
            color: isSelected
                ? const Color(0xFFFFCC7A)
                : const Color(0xFFFFE2B8).withValues(alpha: 0.18),
          ),
          onSelected: (_) => onChanged(language.code),
        );
      }).toList(),
    );
  }
}

class _LanguageOption {
  final String code;
  final String flag;
  final String name;

  const _LanguageOption(
    this.code,
    this.flag,
    this.name,
  );
}