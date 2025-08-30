import 'dart:io';

import 'package:get/get.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/model/profile_response.dart';

class ProfileFarmController extends GetxController {
  final _apiService = ApiProvider();
  var isLoading = false.obs;
  final Rx<User?> userProfile = Rx<User?>(null);

  @override
  void onInit() {
    super.onInit();
    getProfile();
  }

  Future<void> getProfile() async {
    isLoading.value = true;
    final result = await _apiService.auth.getProfile();
    if (result.isSuccess && result.data != null) {
      userProfile.value = result.data!;
    } else {
      userProfile.value = null;
    }
    isLoading.value = false;
  }

  Future<void> updateProfile({String? name, File? profilePicture}) async {
    isLoading.value = true;
    await _apiService.auth.updateProfile(
      name: name,
      profilePicture: profilePicture,
    );
    getProfile();
  }
}
