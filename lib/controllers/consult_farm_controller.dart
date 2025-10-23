import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';

class ConsultFarmController extends GetxController {
  final int farmId;

  ConsultFarmController(this.farmId);

  var members = <dynamic>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchMembers();
  }

  Future<void> fetchMembers() async {
    try {
      isLoading.value = true;
      final response = await ApiProvider().farmMembers.getAllMembers(farmId: farmId);
      members.value = response.data?.data ?? [];
    } catch (e) {
      Get.snackbar('Error', 'Failed to load members');
    } finally {
      isLoading.value = false;
    }
  }

  String formatDate(String? utcString) {
    if (utcString == null || utcString.isEmpty) return '';
    try {
      final utcDateTime = DateTime.parse(utcString);
      final localDateTime = utcDateTime.toLocal();
      return DateFormat("MMM dd, yyyy").format(localDateTime);
    } catch (e) {
      return '';
    }
  }

  Future<void> deleteMember(int? memberId) async {
    if (memberId == null) return;

    Get.defaultDialog(
      title: "Confirm Delete",
      middleText: "Are you sure you want to delete this member?",
      textCancel: "Cancel",
      textConfirm: "Delete",
      confirmTextColor: Get.theme.colorScheme.onPrimary,
      onConfirm: () async {
        Get.back();

        try {
          // final result = await ApiProvider().farmMembers.deleteMember(memberId: memberId);
          // if (result.isSuccess) {
          //   Get.snackbar('Success', 'Member deleted successfully');
          //   fetchMembers();
          // } else {
          //   Get.snackbar('Error', 'Failed to delete member');
          // }
          Get.snackbar('Info', 'Simulated delete for now'); // temporary
        } catch (e) {
          Get.snackbar('Error', 'Failed to delete member');
        }
      },
    );
  }
}
