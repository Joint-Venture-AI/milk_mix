import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenStorage {
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';

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

  // Save tokens
  static Future<bool> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    try {
      final prefs = await _preferences;

      await prefs.setString(_accessTokenKey, accessToken);

      if (refreshToken != null) {
        await prefs.setString(_refreshTokenKey, refreshToken);
      }

      debugPrint('✅ Tokens saved successfully');
      return true;
    } catch (e) {
      debugPrint('❌ Failed to save tokens: $e');
      return false;
    }
  }

  // Get access token
  static Future<String?> getAccessToken() async {
    try {
      final prefs = await _preferences;
      return prefs.getString(_accessTokenKey);
    } catch (e) {
      debugPrint('❌ Failed to get access token: $e');
      return null;
    }
  }

  // Get refresh token
  static Future<String?> getRefreshToken() async {
    try {
      final prefs = await _preferences;
      return prefs.getString(_refreshTokenKey);
    } catch (e) {
      debugPrint('❌ Failed to get refresh token: $e');
      return null;
    }
  }

  static Future<bool> clearAll() async {
    try {
      final prefs = await _preferences;

      await Future.wait([
        prefs.remove(_accessTokenKey),
        prefs.remove(_refreshTokenKey),
      ]);

      debugPrint('✅ All tokens and user data cleared');
      return true;
    } catch (e) {
      debugPrint('❌ Failed to clear tokens: $e');
      return false;
    }
  }

  // Get all stored auth data
  static Future<StoredAuthData?> getStoredAuthData() async {
    try {
      final accessToken = await getAccessToken();
      final refreshToken = await getRefreshToken();

      if (accessToken != null) {
        return StoredAuthData(
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      }
      return null;
    } catch (e) {
      debugPrint('❌ Failed to get stored auth data: $e');
      return null;
    }
  }
}

class StoredAuthData {
  final String accessToken;
  final String? refreshToken;

  StoredAuthData({required this.accessToken, this.refreshToken});
}
