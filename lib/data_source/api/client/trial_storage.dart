import 'package:shared_preferences/shared_preferences.dart';

class TrialStorage {
  static const String _trialAcknowledgedKey = 'trial_acknowledged';

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

  static Future<void> setTrialAcknowledged(bool acknowledged) async {
    final prefs = await _preferences;
    await prefs.setBool(_trialAcknowledgedKey, acknowledged);
  }

  static Future<bool> isTrialAcknowledged() async {
    final prefs = await _preferences;
    return prefs.getBool(_trialAcknowledgedKey) ?? false;
  }

  static Future<void> clear() async {
    final prefs = await _preferences;
    await prefs.remove(_trialAcknowledgedKey);
  }
}
