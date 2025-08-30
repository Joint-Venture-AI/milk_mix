import 'package:milk_mix/data_source/api/client/custom_http_client.dart';
import 'package:milk_mix/data_source/api/client/result.dart';
import '../provider/api_config.dart';

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
