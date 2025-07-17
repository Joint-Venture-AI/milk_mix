import 'package:get/get.dart';
import 'package:milk_mix/constants/data/language_bangla_data.dart';
import 'package:milk_mix/constants/data/language_english_data.dart';
import 'package:milk_mix/constants/data/language_french_data.dart';
import 'package:milk_mix/constants/data/language_german_data.dart';
import 'package:milk_mix/constants/data/language_spanish_data.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_Us': languageEnglishData,
    'bn_BD': languageBanglaData,
    'fr_FR': languageFrenchData,
    'es_ES': languageSpanishData,
    'de_DE': languageGermanData,
  };
}
