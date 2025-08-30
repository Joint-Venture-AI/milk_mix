import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart' as path;
import 'result.dart';
import 'http_client_config.dart';
import 'authentication_manager.dart';
import 'interceptors.dart';

// File model for multipart uploads
class MultipartFile {
  final String fieldName;
  final String? filename;
  final String? contentType;
  final dynamic data; // Can be File, Uint8List, or String path

  MultipartFile({
    required this.fieldName,
    this.filename,
    this.contentType,
    required this.data,
  });

  // Create from File object
  factory MultipartFile.fromFile(
    String fieldName,
    File file, {
    String? filename,
    String? contentType,
  }) {
    return MultipartFile(
      fieldName: fieldName,
      filename: filename ?? path.basename(file.path),
      contentType: contentType ?? lookupMimeType(file.path),
      data: file,
    );
  }

  // Create from bytes
  factory MultipartFile.fromBytes(
    String fieldName,
    Uint8List bytes, {
    required String filename,
    String? contentType,
  }) {
    return MultipartFile(
      fieldName: fieldName,
      filename: filename,
      contentType: contentType ?? lookupMimeType(filename),
      data: bytes,
    );
  }

  // Create from file path
  factory MultipartFile.fromPath(
    String fieldName,
    String filePath, {
    String? filename,
    String? contentType,
  }) {
    return MultipartFile(
      fieldName: fieldName,
      filename: filename ?? path.basename(filePath),
      contentType: contentType ?? lookupMimeType(filePath),
      data: filePath,
    );
  }
}

// Form data model
class FormData {
  final Map<String, String> fields;
  final List<MultipartFile> files;

  FormData({Map<String, String>? fields, List<MultipartFile>? files})
    : fields = fields ?? {},
      files = files ?? [];

  void addField(String key, String value) {
    fields[key] = value;
  }

  void addFile(MultipartFile file) {
    files.add(file);
  }

  void addFiles(List<MultipartFile> files) {
    this.files.addAll(files);
  }

  bool get hasFiles => files.isNotEmpty;
  bool get hasFields => fields.isNotEmpty;
  bool get isEmpty => !hasFiles && !hasFields;
}

// Upload progress callback
typedef UploadProgressCallback =
    void Function(int sent, int total, double progress);

class CustomHttpClient {
  final HttpClientConfig _config;
  final http.Client _client;
  final AuthenticationManager _authManager;
  final List<RequestInterceptor> _requestInterceptors = [];
  final List<ResponseInterceptor> _responseInterceptors = [];

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
  // bool get isAuthenticated => _authManager.hasValidToken;

  // Interceptor management
  void addRequestInterceptor(RequestInterceptor interceptor) {
    _requestInterceptors.add(interceptor);
  }

  void addResponseInterceptor(ResponseInterceptor interceptor) {
    _responseInterceptors.add(interceptor);
  }

  // Regular HTTP Methods
  Future<Result<T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
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
    T Function(dynamic)? fromJson,
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
    T Function(dynamic)? fromJson,
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
    T Function(dynamic)? fromJson,
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
    T Function(dynamic)? fromJson,
  }) async {
    return _performRequest<T>(
      'DELETE',
      endpoint,
      headers: headers,
      queryParams: queryParams,
      fromJson: fromJson,
    );
  }

  // Multipart Form Data Methods
  Future<Result<T>> postMultipart<T>(
    String endpoint, {
    Map<String, String>? headers,
    FormData? formData,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
    UploadProgressCallback? onProgress,
  }) async {
    return _performMultipartRequest<T>(
      'POST',
      endpoint,
      headers: headers,
      formData: formData,
      queryParams: queryParams,
      fromJson: fromJson,
      onProgress: onProgress,
    );
  }

  Future<Result<T>> putMultipart<T>(
    String endpoint, {
    Map<String, String>? headers,
    FormData? formData,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
    UploadProgressCallback? onProgress,
  }) async {
    return _performMultipartRequest<T>(
      'PUT',
      endpoint,
      headers: headers,
      formData: formData,
      queryParams: queryParams,
      fromJson: fromJson,
      onProgress: onProgress,
    );
  }

  Future<Result<T>> patchMultipart<T>(
    String endpoint, {
    Map<String, String>? headers,
    FormData? formData,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
    UploadProgressCallback? onProgress,
  }) async {
    return _performMultipartRequest<T>(
      'PATCH',
      endpoint,
      headers: headers,
      formData: formData,
      queryParams: queryParams,
      fromJson: fromJson,
      onProgress: onProgress,
    );
  }

  // Convenience methods for file uploads
  Future<Result<T>> uploadFile<T>(
    String endpoint,
    String fieldName,
    File file, {
    Map<String, String>? headers,
    Map<String, String>? additionalFields,
    String? filename,
    String? contentType,
    T Function(dynamic)? fromJson,
    UploadProgressCallback? onProgress,
  }) async {
    final formData = FormData();

    if (additionalFields != null) {
      formData.fields.addAll(additionalFields);
    }

    formData.addFile(
      MultipartFile.fromFile(
        fieldName,
        file,
        filename: filename,
        contentType: contentType,
      ),
    );

    return postMultipart<T>(
      endpoint,
      headers: headers,
      formData: formData,
      fromJson: fromJson,
      onProgress: onProgress,
    );
  }

  Future<Result<T>> uploadFiles<T>(
    String endpoint,
    String fieldName,
    List<File> files, {
    Map<String, String>? headers,
    Map<String, String>? additionalFields,
    T Function(dynamic)? fromJson,
    UploadProgressCallback? onProgress,
  }) async {
    final formData = FormData();

    if (additionalFields != null) {
      formData.fields.addAll(additionalFields);
    }

    for (final file in files) {
      formData.addFile(MultipartFile.fromFile(fieldName, file));
    }

    return postMultipart<T>(
      endpoint,
      headers: headers,
      formData: formData,
      fromJson: fromJson,
      onProgress: onProgress,
    );
  }

  Future<Result<T>> uploadBytes<T>(
    String endpoint,
    String fieldName,
    Uint8List bytes, {
    required String filename,
    Map<String, String>? headers,
    Map<String, String>? additionalFields,
    String? contentType,
    T Function(dynamic)? fromJson,
    UploadProgressCallback? onProgress,
  }) async {
    final formData = FormData();

    if (additionalFields != null) {
      formData.fields.addAll(additionalFields);
    }

    formData.addFile(
      MultipartFile.fromBytes(
        fieldName,
        bytes,
        filename: filename,
        contentType: contentType,
      ),
    );

    return postMultipart<T>(
      endpoint,
      headers: headers,
      formData: formData,
      fromJson: fromJson,
      onProgress: onProgress,
    );
  }

  // Core multipart request method
  Future<Result<T>> _performMultipartRequest<T>(
    String method,
    String endpoint, {
    Map<String, String>? headers,
    FormData? formData,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
    UploadProgressCallback? onProgress,
  }) async {
    int retryCount = 0;

    while (retryCount <= _config.maxRetries) {
      try {
        final result = await _executeMultipartRequest<T>(
          method,
          endpoint,
          headers: headers,
          formData: formData,
          queryParams: queryParams,
          fromJson: fromJson,
          onProgress: onProgress,
        );

        if (result.isSuccess || !_shouldRetry(result)) {
          return result;
        }

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
            'Multipart request failed after ${_config.maxRetries} retries: $e',
            type: FailureType.network,
          );
        }
      }
    }

    return const Failure('Maximum retries exceeded', type: FailureType.network);
  }

  // Execute multipart request
  Future<Result<T>> _executeMultipartRequest<T>(
    String method,
    String endpoint, {
    Map<String, String>? headers,
    FormData? formData,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
    UploadProgressCallback? onProgress,
  }) async {
    try {
      final uri = _buildUri(endpoint, queryParams);
      final requestHeaders = _buildHeaders(headers);

      // Remove content-type header if present, as it will be set by multipart
      requestHeaders.remove('content-type');
      requestHeaders.remove('Content-Type');

      _logMultipartRequest(method, uri, requestHeaders, formData);

      final request = http.MultipartRequest(method, uri);
      request.headers.addAll(requestHeaders);

      // Add form fields
      if (formData != null) {
        if (formData.hasFields) {
          request.fields.addAll(formData.fields);
        }

        // Add files
        if (formData.hasFiles) {
          for (final multipartFile in formData.files) {
            final httpMultipartFile = await _createHttpMultipartFile(
              multipartFile,
            );
            request.files.add(httpMultipartFile);
          }
        }
      }

      // Apply request interceptors (Note: This might need adaptation for MultipartRequest)
      // for (final interceptor in _requestInterceptors) {
      //   request = await interceptor.onRequest(request);
      // }

      http.StreamedResponse streamedResponse;

      if (onProgress != null) {
        streamedResponse = await _sendWithProgress(request, onProgress);
      } else {
        streamedResponse = await _client.send(request).timeout(_config.timeout);
      }

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

  // Create HTTP multipart file from our MultipartFile
  Future<http.MultipartFile> _createHttpMultipartFile(
    MultipartFile multipartFile,
  ) async {
    final contentType = multipartFile.contentType;
    final filename = multipartFile.filename;

    if (multipartFile.data is File) {
      final file = multipartFile.data as File;
      return http.MultipartFile(
        multipartFile.fieldName,
        file.openRead(),
        await file.length(),
        filename: filename,
        contentType: contentType != null ? MediaType.parse(contentType) : null,
      );
    } else if (multipartFile.data is Uint8List) {
      final bytes = multipartFile.data as Uint8List;
      return http.MultipartFile.fromBytes(
        multipartFile.fieldName,
        bytes,
        filename: filename,
        contentType: contentType != null ? MediaType.parse(contentType) : null,
      );
    } else if (multipartFile.data is String) {
      final filePath = multipartFile.data as String;
      final file = File(filePath);
      return http.MultipartFile(
        multipartFile.fieldName,
        file.openRead(),
        await file.length(),
        filename: filename,
        contentType: contentType != null ? MediaType.parse(contentType) : null,
      );
    } else {
      throw ArgumentError(
        'Unsupported data type for MultipartFile: ${multipartFile.data.runtimeType}',
      );
    }
  }

  // Send request with progress tracking
  Future<http.StreamedResponse> _sendWithProgress(
    http.MultipartRequest request,
    UploadProgressCallback onProgress,
  ) async {
    final completer = Completer<http.StreamedResponse>();

    try {
      final streamedRequest = request.finalize();
      final contentLength = request.contentLength;

      int bytesSent = 0;

      final progressStream = streamedRequest.transform(
        StreamTransformer<List<int>, List<int>>.fromHandlers(
          handleData: (data, sink) {
            bytesSent += data.length;
            if (contentLength > 0) {
              final progress = bytesSent / contentLength;
              onProgress(bytesSent, contentLength, progress);
            }
            sink.add(data);
          },
        ),
      );

      final httpRequest = http.StreamedRequest(request.method, request.url);
      httpRequest.headers.addAll(request.headers);
      httpRequest.contentLength = contentLength;

      progressStream.listen(
        httpRequest.sink.add,
        onDone: () async {
          httpRequest.sink.close();
          try {
            final response = await _client
                .send(httpRequest)
                .timeout(_config.timeout);
            completer.complete(response);
          } catch (e) {
            completer.completeError(e);
          }
        },
        onError: completer.completeError,
      );
    } catch (e) {
      completer.completeError(e);
    }

    return completer.future;
  }

  // Regular request methods (unchanged)
  Future<Result<T>> _performRequest<T>(
    String method,
    String endpoint, {
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParams,
    T Function(dynamic)? fromJson,
  }) async {
    int retryCount = 0;

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

        if (result.isSuccess || !_shouldRetry(result)) {
          return result;
        }

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
    T Function(dynamic)? fromJson,
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

  // Helper methods (unchanged)
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

  T _parseResponse<T>(http.Response response, T Function(dynamic)? fromJson) {
    if (response.body.isEmpty) {
      return null as T;
    }

    try {
      final jsonData = json.decode(response.body);

      if (fromJson != null &&
          (jsonData is Map<String, dynamic> || jsonData is List)) {
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

  // Logging methods
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

  void _logMultipartRequest(
    String method,
    Uri uri,
    Map<String, String> headers,
    FormData? formData,
  ) {
    if (!_config.enableLogging) return;

    debugPrint('''
🚀 MULTIPART REQUEST [$method]
📍 URL: $uri
📋 Headers: ${_sanitizeHeaders(headers)}
📦 Form Fields: ${formData?.fields.keys.join(', ') ?? 'None'}
📎 Files: ${formData?.files.map((f) => '${f.fieldName}:${f.filename}').join(', ') ?? 'None'}
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
