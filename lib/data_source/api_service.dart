import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:milk_mix/data_source/client/custom_http_client.dart';
import 'package:milk_mix/data_source/client/http_client_config.dart';
import 'package:milk_mix/data_source/client/result.dart';
import 'package:milk_mix/data_source/client/token_storage.dart';
import 'package:milk_mix/model/accepted_farm_response.dart';
import 'package:milk_mix/model/add_member_response.dart';
import 'package:milk_mix/model/auth_response.dart';
import 'package:milk_mix/model/create_history.dart';
import 'package:milk_mix/model/farm_members_response.dart';
import 'package:milk_mix/model/get_milk_history_response.dart';
import 'package:milk_mix/model/get_pending_req_for_consultant_response.dart';
import 'package:milk_mix/model/member_request.dart';
import 'package:milk_mix/model/milk_history_response.dart';
import 'package:milk_mix/model/pending_consultant_request_response.dart';
import 'package:milk_mix/model/profile_response.dart';
import 'package:milk_mix/model/search_farm_response.dart';

class ApiConfig {
  static const String baseUrl = 'http://10.10.12.9:8002';
  static const Duration timeout = Duration(seconds: 30);

  // API Endpoints
  static const String auth = '/auth';
  static const String milkHistory = '/milk-history';
  static const String members = '/members';
  static const String consultants = '/consultants';
  static const String support = '/support';
}

class ApiService {
  final CustomHttpClient _httpClient;
  static ApiService? _instance;
  bool _isInitialized = false;

  ApiService._internal(this._httpClient) {
    _initialize();
  }

  factory ApiService({CustomHttpClient? httpClient}) {
    _instance ??= ApiService._internal(
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

  static ApiService get instance => ApiService();

  AuthService get auth => AuthService(_httpClient);

  MilkHistoryService get milkHistory => MilkHistoryService(_httpClient);

  FarmMembersService get farmMembers => FarmMembersService(_httpClient);

  ConsultantsService get consultants => ConsultantsService(_httpClient);

  SupportService get support => SupportService(_httpClient);

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

class AuthService {
  final CustomHttpClient _httpClient;

  AuthService(this._httpClient);

  // -------------
  Future<Result<AuthResponse>> login({
    required String email,
    required String password,
  }) async {
    final result = await _httpClient.post(
      '${ApiConfig.auth}/login/',
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
      await TokenStorage.saveRole(authResponse.role ?? '');
    }

    return result;
  }

  Future<Result<dynamic>> register({
    required String name,
    required String email,
    required String password,
    required String role,
  }) {
    final body = {
      'name': name,
      'email': email,
      'password': password,
      'role': role,
    };
    return _httpClient.post('${ApiConfig.auth}/register/', body: body);
  }

  Future<Result<AuthResponse>> verifyOtp({
    required String otp,
    required String email,
  }) {
    final body = {'email': email, 'otp': otp};
    return _httpClient.post(
      '${ApiConfig.auth}/otp/verify/',
      body: body,
      fromJson: (json) => AuthResponse.fromJson(json),
    );
  }

  Future<Result<dynamic>> passwordResetRequest({required String email}) {
    final body = {'email': email};
    return _httpClient.post(
      '${ApiConfig.auth}/password-reset/request/',
      body: body,
      fromJson: (json) => json,
    );
  }

  Future<Result<dynamic>> passwordResetConfirm({
    required String email,
    required String otp,
    required String newPassword,
  }) {
    final body = {'email': email, 'otp': otp, 'new_password': newPassword};
    return _httpClient.post(
      '${ApiConfig.auth}/password-reset/confirm/',
      body: body,
      fromJson: (json) => json,
    );
  }

  Future<Result<dynamic>> changePassword({
    required String currentPassword,
    required String newPassword,
  }) {
    final body = {
      'current_password': currentPassword,
      'new_password': newPassword,
    };
    return _httpClient.post(
      '${ApiConfig.auth}/password-change/',
      body: body,
      fromJson: (json) => json,
    );
  }

  // -----------------
  Future<Result<User>> getProfile() {
    return _httpClient.get(
      '${ApiConfig.auth}/profile/',
      fromJson: (json) => User.fromJson(json),
    );
  }

  Future<Result<dynamic>> updateProfile({
    String? name,
    String? phoneNumber,
    File? profilePicture,
  }) async {
    final fields = <String, String>{};
    final files = <MultipartFile>[];

    // Add name only if not null
    if (name != null) {
      fields['name'] = name;
    }

    // Add phone number only if not null
    if (phoneNumber != null) {
      fields['phone_number'] = phoneNumber;
    }

    if (profilePicture != null) {
      files.add(
        MultipartFile.fromFile(
          'profile_picture',
          profilePicture,
          filename: profilePicture.path.split('/').last,
          contentType: 'image/jpeg',
        ),
      );
    }

    final result = await _httpClient.putMultipart<Map<String, dynamic>>(
      '${ApiConfig.auth}/profile/',
      formData: FormData(fields: fields, files: files),
      fromJson: (json) => json,
    );

    return result;
  }
}

class MilkHistoryService {
  final CustomHttpClient _httpClient;

  MilkHistoryService(this._httpClient);

  Future<Result<MilkHistoryResponse>> createMilkHistory({
    required CreateHistory createHistory,
  }) {
    return _httpClient.post(
      '${ApiConfig.milkHistory}/create/',
      body: createHistory.toJson(),
      fromJson: (json) => MilkHistoryResponse.fromJson(json),
    );
  }

  // get history of the firm
  Future<Result<List<GetMilkHistoryData>>> getMilkHistory() {
    return _httpClient.get(
      '${ApiConfig.milkHistory}/',
      fromJson: (json) {
        return GetMilkHistoryData.listFromJson(json);
      },
    );
  }

  Future<Result<List<MilkHistoryData>>> getMilkHistoryByUser(int id) {
    return _httpClient.get(
      '${ApiConfig.milkHistory}/user/$id/',
      fromJson: (json) => MilkHistoryData.fromJsonList(json['data']),
    );
  }

  Future<Result<dynamic>> clearMilkHistory() {
    return _httpClient.delete(
      '${ApiConfig.milkHistory}/user/delete/',
      fromJson: (json) => json,
    );
  }
}

class FarmMembersService {
  final CustomHttpClient _httpClient;

  FarmMembersService(this._httpClient);

  Future<Result<AddMemberResponse>> addMember({
    required MemberRequest memberRequest,
  }) {
    return _httpClient.post(
      '${ApiConfig.members}/create/',
      fromJson: (json) => AddMemberResponse.fromJson(json),
      body: memberRequest.toJson(),
    );
  }

  Future<Result<FarmMembersResponse>> getAllMembers({required int farmId}) {
    return _httpClient.get(
      '${ApiConfig.members}/farm/$farmId/',
      fromJson: (json) => FarmMembersResponse.fromJson(json),
    );
  }

  Future<Result<dynamic>> deleteMember({required int memberId}) {
    return _httpClient.delete(
      '${ApiConfig.members}/$memberId/delete/',
      fromJson: (json) => json,
    );
  }
}

class ConsultantsService {
  final CustomHttpClient _httpClient;

  ConsultantsService(this._httpClient);

  Future<Result<SearchFarmResponse>> searchFarms({required String query}) {
    return _httpClient.get(
      '${ApiConfig.consultants}/search/farm/?name=$query',
      fromJson: (json) => SearchFarmResponse.fromJson(json),
    );
  }

  Future<Result<dynamic>> joinRequest({
    required int farmId,
    required int consultantId,
  }) {
    return _httpClient.post(
      '${ApiConfig.consultants}/request/',
      body: {'farm': farmId, 'consultant': consultantId},
      fromJson: (json) => json,
    );
  }

  Future<Result<AcceptedFarmResponse>> getAcceptedFarms() {
    return _httpClient.get(
      '${ApiConfig.consultants}/farm/list',
      fromJson: (json) => AcceptedFarmResponse.fromJson(json),
    );
  }

  Future<Result<dynamic>> getFarmMembers({required String farmId}) {
    return _httpClient.get(
      '${ApiConfig.consultants}/farm/$farmId/memnber-list/',
      fromJson: (json) => json,
    );
  }

  //
  Future<Result<PendingConsultantRequestResponse>> getPendingRequests() {
    return _httpClient.get(
      '${ApiConfig.consultants}/request-list/',
      fromJson: (json) => PendingConsultantRequestResponse.fromJson(json),
    );
  }

  Future<Result<GetPendingReqForConsultantResponse>>
  getPendingRequestsForConsultant() {
    return _httpClient.get(
      '${ApiConfig.consultants}/get/pending-request/',
      fromJson: (json) => GetPendingReqForConsultantResponse.fromJson(json),
    );
  }

  Future<Result<dynamic>> acceptRequest({required int requestId}) {
    return _httpClient.post(
      '${ApiConfig.consultants}/request/$requestId/manage/',
      body: {"action": "accept"},
      fromJson: (json) => json,
    );
  }
}

class FarmService {
  final CustomHttpClient _httpClient;

  FarmService(this._httpClient);
}

class SupportService {
  final CustomHttpClient _httpClient;

  SupportService(this._httpClient);

  Future<Result<dynamic>> sendFeedback({
    required String email,
    required String problem,
    required String description,
  }) {
    final body = {
      'email': email,
      'problem': problem,
      'description': description,
    };
    return _httpClient.post(
      '${ApiConfig.support}/submit/',
      body: body,
      fromJson: (json) => json,
    );
  }
}
