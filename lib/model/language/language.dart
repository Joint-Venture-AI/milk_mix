import 'package:get/get.dart';
import 'package:milk_mix/constants/data/language_bangla_data.dart';
import 'package:milk_mix/constants/data/language_english_data.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_Us': languageEnglishData,
    'bn_BD': languageBanglaData,
  };
}
