import 'dart:io';

import 'package:flutter/material.dart';
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

  Future<void> updateProfile({
    String? name,
    File? profilePicture,
    String? farmName,
  }) async {
    isLoading.value = true;
    final res = await _apiService.auth.updateProfile(
      name: name,
      profilePicture: profilePicture,
      farmName: farmName,
    );
    getProfile();
    if (res.isSuccess) {
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green[100],
        colorText: Colors.green[900],
      );
    } else {
      Get.snackbar(
        'Error',
        'Failed to update profile',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    }
  }
}
