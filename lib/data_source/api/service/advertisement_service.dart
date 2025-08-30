import 'package:milk_mix/data_source/api/client/custom_http_client.dart';
import 'package:milk_mix/data_source/api/client/result.dart';
import 'package:milk_mix/model/latest_ad_response.dart';
import '../provider/api_config.dart';

class AdvertisementService {
  final CustomHttpClient _httpClient;

  AdvertisementService(this._httpClient);

  Future<Result<LatestAdResponse>> getLatestAd() {
    return _httpClient.get(
      '${ApiConfig.advertisements}/latest/',
      fromJson: (json) => LatestAdResponse.fromJson(json),
    );
  }
}
