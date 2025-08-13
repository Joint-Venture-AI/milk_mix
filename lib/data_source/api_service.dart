import 'package:flutter/foundation.dart';
import 'package:milk_mix/data_source/client/custom_http_client.dart';
import 'package:milk_mix/data_source/client/http_client_config.dart';
import 'package:milk_mix/data_source/client/result.dart';
import 'package:milk_mix/data_source/client/token_storage.dart';
import 'package:milk_mix/model/auth_response.dart';

class ApiConfig {
  static const String baseUrl = 'http://10.10.12.9:8002';
  static const Duration timeout = Duration(seconds: 30);

  // API Endpoints
  static const String auth = '/auth';
  static const String refresh = '/auth/refresh';
}

class ApiService {
  final CustomHttpClient _httpClient;
  static ApiService? _instance;
  bool _isInitialized = false;

  ApiService._internal(this._httpClient);

  factory ApiService({CustomHttpClient? httpClient}) {
    _instance ??= ApiService._internal(
      httpClient ??
          CustomHttpClient(
            HttpClientConfig(
              baseUrl: '${ApiConfig.baseUrl}/api',
              timeout: ApiConfig.timeout,
              enableLogging: kDebugMode,
            ),
          ),
    );
    return _instance!;
  }

  static ApiService get instance => ApiService();

  AuthService get auth => AuthService(_httpClient);

  Future<void> initialize() async {
    if (_isInitialized) return;

    debugPrint('🚀 Initializing API Service...');

    await TokenStorage.init();

    await _restoreStoredTokens();

    // Register token refresher so HTTP client can auto-refresh on 401
    _httpClient.registerTokenRefresher(_attemptTokenRefresh);

    _isInitialized = true;
    debugPrint('✅ API Service initialized');
  }

  Future<void> _restoreStoredTokens() async {
    try {
      final storedAuth = await TokenStorage.getStoredAuthData();

      if (storedAuth != null) {
        _httpClient.setAuthToken(
          accessToken: storedAuth.accessToken,
          refreshToken: storedAuth.refreshToken,
        );
        debugPrint('✅ Restored valid tokens from storage');
      } else {
        debugPrint('ℹ️ No stored tokens found');
      }
    } catch (e) {
      debugPrint('❌ Failed to restore tokens: $e');
      await TokenStorage.clearAll();
    }
  }

  Future<bool> _attemptTokenRefresh() async {
    try {
      final refreshResult = await auth.refreshToken();

      if (refreshResult.isSuccess) {
        debugPrint('✅ Token refreshed successfully');
        return true;
      } else {
        debugPrint('❌ Token refresh failed: ${refreshResult.error}');
        await TokenStorage.clearAll();
        _httpClient.clearAuth();
        return false;
      }
    } catch (e) {
      debugPrint('❌ Token refresh error: $e');
      await TokenStorage.clearAll();
      _httpClient.clearAuth();
      return false;
    }
  }

  Future<void> logout() async {
    await TokenStorage.clearAll();
    _httpClient.clearAuth();
    debugPrint('✅ Logged out and cleared all data');
  }
}

class AuthService {
  final CustomHttpClient _httpClient;

  AuthService(this._httpClient);

  Future<Result<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    final result = await _httpClient.post<AuthResponse>(
      '${ApiConfig.auth}/login',
      body: {'email': email, 'password': password},
      fromJson: (json) => AuthResponse.fromJson(json),
    );

    if (result.isSuccess) {
      final authResponse = result.data!;
      _httpClient.setAuthToken(
        accessToken: authResponse.accessToken ?? '',
        refreshToken: authResponse.refreshToken,
      );
      await TokenStorage.saveTokens(
        accessToken: authResponse.accessToken ?? '',
        refreshToken: authResponse.refreshToken,
      );
    }

    return result;
  }

  Future<Result<AuthResponse>> refreshToken() async {
    final storedRefresh = await TokenStorage.getRefreshToken();
    if (storedRefresh == null || storedRefresh.isEmpty) {
      return const Failure<AuthResponse>(
        'No refresh token available',
        type: FailureType.unauthorized,
      );
    }

    final result = await _httpClient.post<AuthResponse>(
      ApiConfig.refresh,
      body: {'refresh_token': storedRefresh},
      fromJson: (json) => AuthResponse.fromJson(json),
    );

    if (result.isSuccess) {
      final authResponse = result.data!;
      final newAccess = authResponse.accessToken ?? '';
      final newRefresh = authResponse.refreshToken ?? storedRefresh;

      _httpClient.setAuthToken(
        accessToken: newAccess,
        refreshToken: newRefresh,
      );
      await TokenStorage.saveTokens(
        accessToken: newAccess,
        refreshToken: newRefresh,
      );
    }

    return result;
  }
}
