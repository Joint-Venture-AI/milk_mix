import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/model/search_farm_response.dart';

class AddFarmController extends GetxController {
  final TextEditingController controller = TextEditingController();
  var suggestions = <Farm>[].obs;
  var loading = false.obs;
  var selectedFarmId = RxnInt();
  var selectedFarmName = RxnString();

  Duration debounceDuration = const Duration(milliseconds: 400);
  DateTime? _lastSearchTime;
  Future<void>? _debounceFuture;
  String _lastQuery = '';

  void onChanged(String value) {
    _lastQuery = value;
    _lastSearchTime = DateTime.now();
    _debounceFuture ??= _debounceSearch();
  }

  Future<void> _debounceSearch() async {
    while (true) {
      final now = DateTime.now();
      final last = _lastSearchTime ?? now;
      final diff = now.difference(last);
      if (diff >= debounceDuration) {
        await searchFarms(_lastQuery);
        _debounceFuture = null;
        break;
      } else {
        await Future.delayed(debounceDuration - diff);
      }
    }
  }

  Future<void> searchFarms(String value) async {
    if (value.isEmpty) {
      suggestions.value = [];
      return;
    }
    loading.value = true;
    final result = await ApiProvider.instance.consultants.searchFarms(
      query: value,
    );
    loading.value = false;
    suggestions.value = result.data?.data ?? [];
  }

  Future<void> joinFarm(int? farmId, String farmName) async {
    final consultantId = await _getConsultantId();
    if (consultantId == null) {
      Get.snackbar('Error', 'Consultant ID not found');
      return;
    }
    if (farmId == null) {
      Get.snackbar('Error', 'Farm ID not found');
      return;
    }
    selectedFarmId.value = farmId;
    selectedFarmName.value = farmName;
    final result = await ApiProvider.instance.consultants.joinRequest(
      farmId: farmId,
      consultantId: consultantId,
    );
    if (result.isSuccess) {
      Get.snackbar('Success', 'Join request sent to $farmName');
    } else {
      Get.snackbar('Error', result.error?.toString() ?? 'Failed to join');
    }
  }

  Future<int?> _getConsultantId() async {
    final profileResult = await ApiProvider.instance.auth.getProfile();
    if (profileResult.isSuccess && profileResult.data != null) {
      final user = profileResult.data;
      if (user != null && user.id != null) {
        return user.id;
      }
    }
    return null;
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
