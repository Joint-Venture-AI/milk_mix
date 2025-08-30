import 'package:flutter/foundation.dart';
import 'package:milk_mix/data_source/api/client/custom_http_client.dart';
import 'package:milk_mix/data_source/api/client/http_client_config.dart';
import 'package:milk_mix/data_source/api/client/token_storage.dart';
import 'package:milk_mix/data_source/api/service/advertisement_service.dart';
import 'package:milk_mix/data_source/api/provider/api_config.dart';
import 'package:milk_mix/data_source/api/service/auth_service.dart';
import 'package:milk_mix/data_source/api/service/consultants_service.dart';
import 'package:milk_mix/data_source/api/service/farm_members_service.dart';
import 'package:milk_mix/data_source/api/service/milk_history_service.dart';
import 'package:milk_mix/data_source/api/service/support_service.dart';

class ApiProvider {
  final CustomHttpClient _httpClient;
  static ApiProvider? _instance;
  bool _isInitialized = false;

  ApiProvider._internal(this._httpClient) {
    _initialize();
  }

  factory ApiProvider({CustomHttpClient? httpClient}) {
    _instance ??= ApiProvider._internal(
      httpClient ??
          CustomHttpClient(
            HttpClientConfig(
              baseUrl: '${ApiConfig.baseUrl}/api',
              timeout: ApiConfig.timeout,
              enableLogging: kDebugMode,
              sanitizeLoggedHeaders: false,
            ),
          ),
    );
    return _instance!;
  }

  static ApiProvider get instance => ApiProvider();

  AuthService get auth => AuthService(_httpClient);

  MilkHistoryService get milkHistory => MilkHistoryService(_httpClient);

  FarmMembersService get farmMembers => FarmMembersService(_httpClient);

  ConsultantsService get consultants => ConsultantsService(_httpClient);

  SupportService get support => SupportService(_httpClient);

  AdvertisementService get advertisements => AdvertisementService(_httpClient);

  void _initialize() async {
    if (_isInitialized) return;

    debugPrint('🚀 Initializing API Service...');

    await TokenStorage.init();

    await _restoreStoredTokens();

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

  // Future<bool> _attemptTokenRefresh() async {
  //   try {
  //     final refreshResult = await auth.refreshToken();

  //     if (refreshResult.isSuccess) {
  //       debugPrint('✅ Token refreshed successfully');
  //       return true;
  //     } else {
  //       debugPrint('❌ Token refresh failed: ${refreshResult.error}');
  //       await TokenStorage.clearAll();
  //       _httpClient.clearAuth();
  //       return false;
  //     }
  //   } catch (e) {
  //     debugPrint('❌ Token refresh error: $e');
  //     await TokenStorage.clearAll();
  //     _httpClient.clearAuth();
  //     return false;
  //   }
  // }

  Future<void> logout() async {
    await TokenStorage.clearAll();
    _httpClient.clearAuth();
    debugPrint('✅ Logged out and cleared all data');
  }
}
