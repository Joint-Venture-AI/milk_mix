import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageStorage {
  static const String _languageKey = 'selected_language';
  static const String _countryKey = 'selected_country';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  static Future<SharedPreferences> get _preferences async {
    if (_prefs == null) {
      await init();
    }
    return _prefs!;
  }

  // Save selected language
  static Future<bool> saveLanguage(
    String languageCode,
    String countryCode,
  ) async {
    try {
      final prefs = await _preferences;
      await prefs.setString(_languageKey, languageCode);
      await prefs.setString(_countryKey, countryCode);
      debugPrint('✅ Language saved: ${languageCode}_$countryCode');
      return true;
    } catch (e) {
      debugPrint('❌ Failed to save language: $e');
      return false;
    }
  }

  // Get saved language
  static Future<String?> getLanguageCode() async {
    try {
      final prefs = await _preferences;
      return prefs.getString(_languageKey);
    } catch (e) {
      debugPrint('❌ Failed to get language code: $e');
      return null;
    }
  }

  // Get saved country
  static Future<String?> getCountryCode() async {
    try {
      final prefs = await _preferences;
      return prefs.getString(_countryKey);
    } catch (e) {
      debugPrint('❌ Failed to get country code: $e');
      return null;
    }
  }

  // Get saved locale
  static Future<String?> getSavedLocale() async {
    try {
      final languageCode = await getLanguageCode();
      final countryCode = await getCountryCode();

      if (languageCode != null && countryCode != null) {
        return '${languageCode}_$countryCode';
      }
      return null;
    } catch (e) {
      debugPrint('❌ Failed to get saved locale: $e');
      return null;
    }
  }

  // Clear saved language
  static Future<bool> clearLanguage() async {
    try {
      final prefs = await _preferences;
      await prefs.remove(_languageKey);
      await prefs.remove(_countryKey);
      debugPrint('✅ Language preferences cleared');
      return true;
    } catch (e) {
      debugPrint('❌ Failed to clear language: $e');
      return false;
    }
  }
}
