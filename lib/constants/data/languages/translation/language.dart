import 'package:get/get.dart';
import 'package:milk_mix/constants/data/language_arabic_data.dart';
import 'package:milk_mix/constants/data/language_bangla_data.dart';
import 'package:milk_mix/constants/data/language_chinese_data.dart';
import 'package:milk_mix/constants/data/language_dutch_data.dart';
import 'package:milk_mix/constants/data/language_english_data.dart';
import 'package:milk_mix/constants/data/language_french_data.dart';
import 'package:milk_mix/constants/data/language_german_data.dart';
import 'package:milk_mix/constants/data/language_hindi_data.dart';
import 'package:milk_mix/constants/data/language_italian_data.dart';
import 'package:milk_mix/constants/data/language_japanese_data.dart';
import 'package:milk_mix/constants/data/language_portuguese_data.dart';
import 'package:milk_mix/constants/data/language_spanish_data.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': languageEnglishData,
    'bn_BD': languageBanglaData,
    'ar_SA': languageArabicData,
    'fr_FR': languageFrenchData,
    'hi_IN': languageHindiData,
    'it_IT': languageItalianData,
    'ja_JP': languageJapaneseData,
    'pt_PT': languagePortugueseData,
    'es_ES': languageSpanishData,
    'nl_NL': languageDutchData,
    'zh_CN': languageChineseData,
    'de_DE': languageGermanData,
  };
}
