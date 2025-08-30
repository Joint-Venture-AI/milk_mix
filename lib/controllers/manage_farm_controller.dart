import 'package:get/get.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/model/accepted_farm_response.dart';
import 'package:milk_mix/model/get_pending_req_for_consultant_response.dart';

class ManageFarmController extends GetxController {
  RxList<AcceptedFarm> acceptedFarms = <AcceptedFarm>[].obs;
  RxList<ConsultantRequest> pendingRequests = <ConsultantRequest>[].obs;
  var isLoadingAccepted = false.obs;
  var isLoadingPending = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAcceptedFarms();
    fetchPendingRequests();
  }

  Future<void> fetchAcceptedFarms() async {
    isLoadingAccepted.value = true;
    final result = await ApiProvider().consultants.getAcceptedFarms();
    acceptedFarms.value = result.data?.data ?? [];
    isLoadingAccepted.value = false;
  }

  Future<void> fetchPendingRequests() async {
    isLoadingPending.value = true;
    final result =
        await ApiProvider().consultants.getPendingRequestsForConsultant();
    pendingRequests.value = result.data?.data ?? [];
    isLoadingPending.value = false;
  }
}
