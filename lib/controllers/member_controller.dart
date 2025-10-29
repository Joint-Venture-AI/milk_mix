import 'package:get/get.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/data_source/api/client/result.dart';
import 'package:milk_mix/model/add_member_response.dart' hide FarmMemberData;
import 'package:milk_mix/model/consultant_of_farm_response.dart';
import 'package:milk_mix/model/farm_members_response.dart';
import 'package:milk_mix/model/member_request.dart';
import 'package:milk_mix/model/pending_consultant_request_response.dart';

class MemberController extends GetxController {
  final apiService = ApiProvider();
  //
  var fetchMemberIsLoading = false.obs;
  var fetchConsultantIsLoading = false.obs;
  //
  var addMemberIsLoading = false.obs;
  var getPendingRequestIsLoading = false.obs;
  var acceptConsultantRequestIsLoading = false.obs;
  //
  RxList<FarmMemberData> members = RxList<FarmMemberData>([]);
  RxList<ConsultantOfFarmResponse> consultants =
      RxList<ConsultantOfFarmResponse>([]);
  RxList<PendingConsultantRequest> pendingRequests =
      RxList<PendingConsultantRequest>([]);

  //
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

  void fetchConsultants() async {
    fetchConsultantIsLoading.value = true;
    final result = await apiService.consultants.getAllConsultantsOfFarm();
    if (result.isSuccess && result.data != null) {
      consultants.value = result.data ?? [];
    }
    fetchConsultantIsLoading.value = false;
  }

  Future<Result<AddMemberResponse>> addMember({
    required MemberRequest memberRequest,
  }) async {
    addMemberIsLoading.value = true;
    final result = await apiService.auth.getProfile();
    if (!result.isSuccess) return Failure('Failed to get profile');
    final farmId = result.data?.id;
    memberRequest.farm = farmId;
    if (farmId == null) return Failure('Farm ID is null');
    final resultP = await apiService.farmMembers.addMember(
      memberRequest: memberRequest,
    );
    addMemberIsLoading.value = false;
    fetchMembers();
    return resultP;
  }

  void getPendingRequests() async {
    getPendingRequestIsLoading.value = true;
    final result = await apiService.consultants.getPendingRequests();
    final requests = result.data?.data ?? [];
    if (result.isSuccess) {
      pendingRequests(requests);
    }
    getPendingRequestIsLoading.value = false;
  }

  Future<void> acceptConsultantRequest(int requestId) async {
    acceptConsultantRequestIsLoading.value = true;
    final result = await apiService.consultants.acceptRequest(
      requestId: requestId,
    );
    if (result.isSuccess) {
      Get.snackbar(
        'Success',
        'Consultant request accepted successfully.',
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to accept consultant request.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    getPendingRequests();
    fetchConsultants();
    acceptConsultantRequestIsLoading.value = false;
  }
}
