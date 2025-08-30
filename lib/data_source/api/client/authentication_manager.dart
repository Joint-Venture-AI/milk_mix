class AuthenticationManager {
  String? _accessToken;
  String? _refreshToken;

  void setTokens({required String accessToken, String? refreshToken}) {
    _accessToken = accessToken;
    _refreshToken = refreshToken;
  }

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
  }

  Map<String, String> getAuthHeaders() {
    if (_accessToken != null) {
      return {'Authorization': 'Bearer $_accessToken'};
    }
    return {};
  }
}
