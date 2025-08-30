import 'package:milk_mix/data_source/api/client/custom_http_client.dart';
import 'package:milk_mix/data_source/api/client/result.dart';
import 'package:milk_mix/model/create_history.dart';
import 'package:milk_mix/model/get_milk_history_response.dart';
import 'package:milk_mix/model/milk_history_response.dart';
import '../provider/api_config.dart';

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

  Future<Result<List<GetMilkHistoryData>>> getMilkHistory() {
    return _httpClient.get(
      '${ApiConfig.milkHistory}/',
      fromJson: (json) => GetMilkHistoryData.listFromJson(json),
    );
  }

  Future<Result<List<GetMilkHistoryData>>> getMilkHistoryByUser(int id) {
    return _httpClient.get(
      '${ApiConfig.milkHistory}/user/$id/',
      fromJson: (json) => GetMilkHistoryData.listFromJson(json['data']),
    );
  }

  Future<Result<dynamic>> clearMilkHistory() {
    return _httpClient.delete(
      '${ApiConfig.milkHistory}/user/delete/',
      fromJson: (json) => json,
    );
  }
}
