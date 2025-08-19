import 'package:get/get.dart';
import 'package:milk_mix/data_source/api_service.dart';
import 'package:milk_mix/model/farm_members_response.dart';
import 'package:milk_mix/model/member_request.dart';

class MemberController extends GetxController {
  final apiService = ApiService();
  var fetchMemberIsLoading = false.obs;
  var addMemberIsLoading = false.obs;
  RxList<FarmMemberData> members = RxList<FarmMemberData>(
    [],
  ); // RxList<FarmMemberData>
  void fetchMembers() async {
    fetchMemberIsLoading.value = true;
    final resultP = await apiService.auth.getProfile();
    if (!resultP.isSuccess) return;
    final farmId = resultP.data?.id;
    if (farmId == null) return;
    final result = await apiService.farmMembers.getAllMembers(farmId: farmId);
    if (result.isSuccess && result.data != null) {
      members.value = result.data!.data ?? [];
    }
    fetchMemberIsLoading.value = false;
  }

  void addMember({required MemberRequest memberRequest}) async {
    addMemberIsLoading.value = true;
    final result = await apiService.auth.getProfile();
    if (!result.isSuccess) return;
    final farmId = result.data?.id;
    memberRequest.farm = farmId;
    if (farmId == null) return;
    await apiService.farmMembers.addMember(memberRequest: memberRequest);
    addMemberIsLoading.value = false;
    fetchMembers();
  }
}
