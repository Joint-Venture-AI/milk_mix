class HttpClientConfig {
  final String baseUrl;
  final Duration timeout;
  final Duration connectionTimeout;
  final Map<String, String> defaultHeaders;
  final bool enableLogging;
  final bool sanitizeLoggedHeaders;
  final int maxRetries;
  final Duration retryDelay;

  const HttpClientConfig({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
    this.connectionTimeout = const Duration(seconds: 10),
    this.defaultHeaders = const {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
    this.enableLogging = true,
    this.maxRetries = 3,
    this.retryDelay = const Duration(seconds: 1),
    this.sanitizeLoggedHeaders = true,
  });
}
