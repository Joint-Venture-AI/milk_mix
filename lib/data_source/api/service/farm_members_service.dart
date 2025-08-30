import 'package:milk_mix/data_source/api/client/custom_http_client.dart';
import 'package:milk_mix/data_source/api/client/result.dart';
import 'package:milk_mix/model/add_member_response.dart';
import 'package:milk_mix/model/farm_members_response.dart';
import 'package:milk_mix/model/member_request.dart';
import '../provider/api_config.dart';

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
