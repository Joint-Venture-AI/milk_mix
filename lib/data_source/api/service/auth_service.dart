import 'dart:io';
import 'package:milk_mix/data_source/api/client/custom_http_client.dart';
import 'package:milk_mix/data_source/api/client/result.dart';
import 'package:milk_mix/data_source/api/client/token_storage.dart';
import 'package:milk_mix/model/auth_response.dart';
import 'package:milk_mix/model/profile_response.dart';
import '../provider/api_config.dart';

class AuthService {
  final CustomHttpClient _httpClient;

  AuthService(this._httpClient);

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
    required String farmName,
    required String email,
    required String password,
    required String role,
  }) {
    final body = {
      'name': name,
      'farm_name': farmName,
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

  Future<Result<User>> getProfile() {
    return _httpClient.get(
      '${ApiConfig.auth}/profile/',
      fromJson: (json) => User.fromJson(json),
    );
  }

  Future<Result<dynamic>> updateProfile({
    String? name,
    String? farmName,
    String? phoneNumber,
    File? profilePicture,
  }) async {
    final fields = <String, String>{};
    final files = <MultipartFile>[];

    if (name != null) {
      fields['name'] = name;
    }
    if (phoneNumber != null) {
      fields['phone_number'] = phoneNumber;
    }
    if (farmName != null) {
      fields['farm_name'] = farmName;
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
