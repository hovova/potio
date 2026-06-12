import 'package:flutter/foundation.dart';

class LanguageService {
  LanguageService._();

  static final LanguageService instance = LanguageService._();

  final ValueNotifier<String> languageCode = ValueNotifier<String>('en');

  void setLanguage(String code) {
    final safeCode = switch (code) {
      'uk' => 'uk',
      'ru' => 'ru',
      _ => 'en',
    };

    languageCode.value = safeCode;
  }
}