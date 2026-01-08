import 'package:milk_mix/data_source/api/client/custom_http_client.dart';
import 'package:milk_mix/data_source/api/client/result.dart';
import 'package:milk_mix/model/accepted_farm_response.dart';
import 'package:milk_mix/model/consultant_of_farm_response.dart';
import 'package:milk_mix/model/get_pending_req_for_consultant_response.dart';
import 'package:milk_mix/model/pending_consultant_request_response.dart';
import 'package:milk_mix/model/search_farm_response.dart';
import '../provider/api_config.dart';

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

  Future<Result<List<ConsultantOfFarmResponse>>> getAllConsultantsOfFarm() {
    return _httpClient.get(
      '/get${ApiConfig.consultants}/farm/',
      fromJson: (json) {
        return (json as List).map((e) {
          return ConsultantOfFarmResponse.fromJson(e as Map<String, dynamic>);
        }).toList();
      },
    );
  }

  Future<Result<dynamic>> deleteConsultantFromFarm({
    required int consultantId,
  }) {
    return _httpClient.delete(
      '/delete${ApiConfig.consultants}/$consultantId/farm/',
      fromJson: (json) => json,
    );
  }
}
