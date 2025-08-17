import 'package:milk_mix/constants/data/languages/model/language_model.dart';

List<LanguageModel> languages = [
  LanguageModel(
    code: 'ar',
    name: 'Arabic',
    flag: 'assets/flags/arab.png',
    locale: 'ar_SA',
  ),
  LanguageModel(
    code: 'bn',
    name: 'Bangla',
    flag: 'assets/flags/bd.png',
    locale: 'bn_BD',
  ),
  LanguageModel(
    code: 'zh',
    name: 'Chinese',
    flag: 'assets/flags/cn.png',
    locale: 'zh_CN',
  ),
  LanguageModel(
    code: 'nl',
    name: 'Dutch',
    flag: 'assets/flags/nl.png',
    locale: 'nl_NL',
  ),
  LanguageModel(
    code: 'de',
    name: 'German',
    flag: 'assets/flags/de.png',
    locale: 'de_DE',
  ),
  LanguageModel(
    code: 'en',
    name: 'English (United States)',
    flag: 'assets/flags/us.png',
    locale: 'en_US',
  ),
  LanguageModel(
    code: 'en',
    name: 'English (United Kingdom)',
    flag: 'assets/flags/gb.png',
    locale: 'en_GB',
  ),
  LanguageModel(
    code: 'fr',
    name: 'French',
    flag: 'assets/flags/fr.png',
    locale: 'fr_FR',
  ),
  LanguageModel(
    code: 'hi',
    name: 'Hindi',
    flag: 'assets/flags/in.png',
    locale: 'hi_IN',
  ),
  LanguageModel(
    code: 'it',
    name: 'Italian',
    flag: 'assets/flags/it.png',
    locale: 'it_IT',
  ),
  LanguageModel(
    code: 'ja',
    name: 'Japanese',
    flag: 'assets/flags/jp.png',
    locale: 'ja_JP',
  ),
  LanguageModel(
    code: 'pt',
    name: 'Portuguese',
    flag: 'assets/flags/pt.png',
    locale: 'pt_PT',
  ),
  LanguageModel(
    code: 'es',
    name: 'Spanish',
    flag: 'assets/flags/es.png',
    locale: 'es_ES',
  ),
];

// Helper function to get locale from language code
String getLocaleFromLanguageCode(String languageCode) {
  // Default to English US for most cases
  switch (languageCode) {
    case 'ar':
      return 'ar_SA';
    case 'bn':
      return 'bn_BD';
    case 'zh':
      return 'zh_CN';
    case 'nl':
      return 'nl_NL';
    case 'de':
      return 'de_DE';
    case 'en':
      return 'en_US';
    case 'fr':
      return 'fr_FR';
    case 'hi':
      return 'hi_IN';
    case 'it':
      return 'it_IT';
    case 'ja':
      return 'ja_JP';
    case 'pt':
      return 'pt_PT';
    case 'es':
      return 'es_ES';
    default:
      return 'en_US';
  }
}

// Helper function to get language and country codes from locale
Map<String, String> getLanguageAndCountryFromLocale(String locale) {
  final parts = locale.split('_');
  if (parts.length == 2) {
    return {'language': parts[0], 'country': parts[1]};
  }
  return {'language': 'en', 'country': 'US'};
}
