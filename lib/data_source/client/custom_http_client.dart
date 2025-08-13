import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'result.dart';
import 'http_client_config.dart';
import 'authentication_manager.dart';
import 'interceptors.dart';

class CustomHttpClient {
  final HttpClientConfig _config;
  final http.Client _client;
  final AuthenticationManager _authManager;
  final List<RequestInterceptor> _requestInterceptors = [];
  final List<ResponseInterceptor> _responseInterceptors = [];
  Future<bool> Function()? _tokenRefresher;

  CustomHttpClient(this._config)
    : _client = http.Client(),
      _authManager = AuthenticationManager();

  // Authentication methods
  void setAuthToken({
    required String accessToken,
    String? refreshToken,
    // DateTime? expiry,
  }) {
    _authManager.setTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
      // expiry: expiry,
    );
  }

  void clearAuth() => _authManager.clearTokens();

  // Register a token refresher that is invoked on 401 responses.
  void registerTokenRefresher(Future<bool> Function() refresher) {
    _tokenRefresher = refresher;
  }

  // Interceptor management
  void addRequestInterceptor(RequestInterceptor interceptor) {
    _requestInterceptors.add(interceptor);
  }

  void addResponseInterceptor(ResponseInterceptor interceptor) {
    _responseInterceptors.add(interceptor);
  }

  // HTTP Methods
  Future<Result<T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _performRequest<T>(
      'GET',
      endpoint,
      headers: headers,
      queryParams: queryParams,
      fromJson: fromJson,
    );
  }

  Future<Result<T>> post<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _performRequest<T>(
      'POST',
      endpoint,
      headers: headers,
      body: body,
      queryParams: queryParams,
      fromJson: fromJson,
    );
  }

  Future<Result<T>> put<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _performRequest<T>(
      'PUT',
      endpoint,
      headers: headers,
      body: body,
      queryParams: queryParams,
      fromJson: fromJson,
    );
  }

  Future<Result<T>> patch<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _performRequest<T>(
      'PATCH',
      endpoint,
      headers: headers,
      body: body,
      queryParams: queryParams,
      fromJson: fromJson,
    );
  }

  Future<Result<T>> delete<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    return _performRequest<T>(
      'DELETE',
      endpoint,
      headers: headers,
      queryParams: queryParams,
      fromJson: fromJson,
    );
  }

  Future<Result<T>> _performRequest<T>(
    String method,
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    int retryCount = 0;
    bool attemptedRefresh = false;

    while (retryCount <= _config.maxRetries) {
      try {
        final result = await _executeRequest<T>(
          method,
          endpoint,
          headers: headers,
          body: body,
          queryParams: queryParams,
          fromJson: fromJson,
        );

        // If success, return immediately
        if (result.isSuccess) return result;

        // If unauthorized and we have a refresher, try refresh once and retry the request once immediately
        if (!result.isSuccess &&
            (result as Failure<T>).type == FailureType.unauthorized &&
            _tokenRefresher != null &&
            !attemptedRefresh) {
          attemptedRefresh = true;
          final refreshed = await _tokenRefresher!.call();
          if (refreshed) {
            // retry once immediately after refresh without increasing retry backoff
            final retryAfterRefresh = await _executeRequest<T>(
              method,
              endpoint,
              headers: headers,
              body: body,
              queryParams: queryParams,
              fromJson: fromJson,
            );
            if (retryAfterRefresh.isSuccess ||
                (retryAfterRefresh is Failure<T> &&
                    retryAfterRefresh.type != FailureType.unauthorized)) {
              return retryAfterRefresh;
            }
          }
        }

        // If non-retryable error, return
        if (!_shouldRetry(result)) return result;

        // Retry logic
        if (retryCount < _config.maxRetries) {
          retryCount++;
          _logRetry(method, endpoint, retryCount);
          await Future.delayed(_config.retryDelay);
        } else {
          return result;
        }
      } catch (e) {
        if (retryCount < _config.maxRetries) {
          retryCount++;
          _logRetry(method, endpoint, retryCount);
          await Future.delayed(_config.retryDelay);
        } else {
          return Failure<T>(
            'Request failed after ${_config.maxRetries} retries: $e',
            type: FailureType.network,
          );
        }
      }
    }

    return const Failure('Maximum retries exceeded', type: FailureType.network);
  }

  Future<Result<T>> _executeRequest<T>(
    String method,
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      final requestHeaders = _buildHeaders(headers);

      _logRequest(method, uri, requestHeaders, body);

      http.Request request = http.Request(method, uri);
      request.headers.addAll(requestHeaders);

      if (body != null && (method != 'GET' && method != 'DELETE')) {
        request.body = json.encode(body);
      }

      // Apply request interceptors
      for (final interceptor in _requestInterceptors) {
        request = await interceptor.onRequest(request);
      }

      final streamedResponse = await _client
          .send(request)
          .timeout(_config.timeout);

      http.Response response = await http.Response.fromStream(streamedResponse);

      // Apply response interceptors
      for (final interceptor in _responseInterceptors) {
        response = await interceptor.onResponse(response);
      }

      _logResponse(response);

      if (response.statusCode >= 200 && response.statusCode < 300) {
        final data = _parseResponse<T>(response, fromJson);
        return Success<T>(
          data,
          statusCode: response.statusCode,
          headers: response.headers,
        );
      } else {
        return _handleErrorResponse<T>(response);
      }
    } on SocketException catch (e) {
      _logError('Network error', e);
      return Failure<T>(
        'Network connection failed: ${e.message}',
        type: FailureType.network,
      );
    } on HttpException catch (e) {
      _logError('HTTP error', e);
      return Failure<T>('HTTP error: ${e.message}', type: FailureType.network);
    } on FormatException catch (e) {
      _logError('Format error', e);
      return Failure<T>(
        'Data format error: ${e.message}',
        type: FailureType.parsing,
      );
    } catch (e) {
      _logError('Unexpected error', e);
      return Failure<T>('Unexpected error: $e', type: FailureType.unknown);
    }
  }

  Uri _buildUri(String endpoint, Map<String, dynamic>? queryParams) {
    String url =
        endpoint.startsWith('http')
            ? endpoint
            : '${_config.baseUrl.replaceAll(RegExp(r'/$'), '')}/${endpoint.replaceAll(RegExp(r'^/'), '')}';

    final uri = Uri.parse(url);

    if (queryParams != null && queryParams.isNotEmpty) {
      final queryString = queryParams.entries
          .where((entry) => entry.value != null)
          .map(
            (entry) =>
                '${entry.key}=${Uri.encodeComponent(entry.value.toString())}',
          )
          .join('&');

      return Uri.parse('$url?$queryString');
    }

    return uri;
  }

  Map<String, String> _buildHeaders(Map<String, String>? additionalHeaders) {
    final headers = Map<String, String>.from(_config.defaultHeaders);

    headers.addAll(_authManager.getAuthHeaders());

    if (additionalHeaders != null) {
      headers.addAll(additionalHeaders);
    }

    return headers;
  }

  T _parseResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    if (response.body.isEmpty) {
      return null as T;
    }

    try {
      final jsonData = json.decode(response.body);

      if (fromJson != null && jsonData is Map<String, dynamic>) {
        return fromJson(jsonData);
      }

      return jsonData as T;
    } catch (e) {
      throw FormatException('Failed to parse response: $e');
    }
  }

  Result<T> _handleErrorResponse<T>(http.Response response) {
    String errorMessage = 'Request failed';
    FailureType failureType = FailureType.unknown;

    try {
      final errorData = json.decode(response.body);
      if (errorData is Map<String, dynamic>) {
        errorMessage =
            errorData['message'] ??
            errorData['error'] ??
            errorData['detail'] ??
            'Request failed';
      }
    } catch (_) {
      errorMessage =
          response.body.isNotEmpty ? response.body : 'Request failed';
    }

    switch (response.statusCode) {
      case 400:
        failureType = FailureType.unknown;
        break;
      case 401:
        failureType = FailureType.unauthorized;
        break;
      case 403:
        failureType = FailureType.forbidden;
        break;
      case 404:
        failureType = FailureType.notFound;
        break;
      case >= 500:
        failureType = FailureType.serverError;
        break;
      default:
        failureType = FailureType.unknown;
    }

    return Failure<T>(
      errorMessage,
      statusCode: response.statusCode,
      headers: response.headers,
      type: failureType,
    );
  }

  bool _shouldRetry<T>(Result<T> result) {
    if (result.isSuccess) return false;

    final failure = result as Failure<T>;
    return failure.type == FailureType.network ||
        failure.type == FailureType.timeout ||
        (failure.statusCode != null && failure.statusCode! >= 500);
  }

  // ----------------- Loggings -----------------
  void _logRequest(
    String method,
    Uri uri,
    Map<String, String> headers,
    Map<String, dynamic>? body,
  ) {
    if (!_config.enableLogging) return;

    debugPrint('''
🚀 REQUEST [$method]
📍 URL: $uri
📋 Headers: ${_sanitizeHeaders(headers)}
📦 Body: ${body != null ? json.encode(body) : 'No body'}
''');
  }

  void _logResponse(http.Response response) {
    if (!_config.enableLogging) return;

    final emoji =
        response.statusCode >= 200 && response.statusCode < 300 ? '✅' : '❌';

    debugPrint('''
$emoji RESPONSE [${response.statusCode}]
📋 Headers: ${_sanitizeHeaders(response.headers)}
📦 Body: ${response.body.length > 1000 ? '${response.body.substring(0, 1000)}...' : response.body}
''');
  }

  void _logError(String message, dynamic error) {
    if (!_config.enableLogging) return;
    debugPrint('❌ ERROR: $message - $error');
  }

  void _logRetry(String method, String endpoint, int retryCount) {
    if (!_config.enableLogging) return;
    debugPrint('🔄 RETRY $retryCount: $method $endpoint');
  }

  Map<String, String> _sanitizeHeaders(Map<String, String> headers) {
    if (_config.sanitizeLoggedHeaders == false) return headers;

    final sanitized = Map<String, String>.from(headers);

    sanitized.updateAll((key, value) {
      if (key.toLowerCase().contains('authorization') ||
          key.toLowerCase().contains('token') ||
          key.toLowerCase().contains('key')) {
        return '***';
      }
      return value;
    });

    return sanitized;
  }

  void dispose() {
    _client.close();
  }
}
