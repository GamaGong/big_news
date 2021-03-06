import 'dart:ui';

import 'package:big_news/generated/l10n.dart';
import 'package:built_value/built_value.dart';

enum AppLocale {
  en,
  ru,
  system,
}

extension LocaleExtenstion on AppLocale {
  static Map<AppLocale, Locale> _langCodes = Map.fromIterables(
      AppLocale.values.where((element) => element != AppLocale.system),
      S.delegate.supportedLocales);

  static const _langTags = {
    AppLocale.en: '🇺🇸',
    AppLocale.ru: '🇷🇺',
    AppLocale.system: '📱',
  };

  @nullable
  Locale get locale => _langCodes[this] ?? Locale('sys');

  String get tag => _langTags[this];

  static AppLocale fromString(String str) => (str != null && str.isNotEmpty)
      ? AppLocale.values.firstWhere((element) => element.tag == str)
      : AppLocale.system;
}
