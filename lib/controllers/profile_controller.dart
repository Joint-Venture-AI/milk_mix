import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';

class ProfileController extends GetxController {
  final ApiProvider _apiService = ApiProvider();

  final RxBool isLoading = false.obs;
  final RxBool isImageLoading = false.obs;
  final Rx<File?> selectedImage = Rx<File?>(null);
  final RxString profileImageUrl = ''.obs;
  final RxString name = ''.obs;
  final RxString farmName = ''.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController masterUsernameController =
      TextEditingController();

  @override
  void onInit() {
    super.onInit();
    // Load current profile data
    loadProfile();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    masterUsernameController.dispose();
    super.onClose();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final result = await _apiService.auth.getProfile();

      if (result.isSuccess && result.data != null) {
        final user = result.data!;
        nameController.text = user.userProfile?.name ?? '';
        emailController.text = user.email ?? '';
        masterUsernameController.text =
            user.userProfile?.name ?? ''; // Using name as username for now
        if (user.userProfile?.profilePicture != null) {
          profileImageUrl.value = user.userProfile!.profilePicture!;
        }
        name.value = user.userProfile?.name ?? '';
        farmName.value = user.userProfile?.farmName ?? '';

        // Get.snackbar(
        //   'Success',
        //   'Profile loaded successfully',
        //   snackPosition: SnackPosition.BOTTOM,
        //   backgroundColor: Colors.green[100],
        //   colorText: Colors.green[900],
        // );
      } else {
        Get.snackbar(
          'Warning',
          'Failed to load profile data',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange[100],
          colorText: Colors.orange[900],
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Future<void> pickImage() async {
  //   try {
  //     isImageLoading.value = true;

  //     final imageBytes = await custom_image_picker.pickSingleImage(
  //       context: Get.context!,
  //       source: ImageSource.gallery,
  //       compress: true,
  //       crop: true,
  //     );

  //     if (imageBytes != null) {
  //       // Convert bytes to temporary file
  //       final tempDir = await Directory.systemTemp.createTemp('profile_image');
  //       final tempFile = File('${tempDir.path}/profile_image.jpg');
  //       await tempFile.writeAsBytes(imageBytes);

  //       selectedImage.value = tempFile;
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to pick image: ${e.toString()}',
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //   } finally {
  //     isImageLoading.value = false;
  //   }
  // }

  // void showImagePickerOptions() {
  //   custom_image_picker.showImagePickerOptions(
  //     Get.context!,
  //     (ImageSource source) => pickImageFromSource(source),
  //   );
  // }

  // Future<void> pickImageFromSource(ImageSource source) async {
  //   try {
  //     isImageLoading.value = true;

  //     final imageBytes = await custom_image_picker.pickSingleImage(
  //       context: Get.context!,
  //       source: source,
  //       compress: true,
  //       crop: true,
  //     );

  //     if (imageBytes != null) {
  //       // Convert bytes to temporary file
  //       final tempDir = await Directory.systemTemp.createTemp('profile_image');
  //       final tempFile = File('${tempDir.path}/profile_image.jpg');
  //       await tempFile.writeAsBytes(imageBytes);

  //       selectedImage.value = tempFile;

  //       Get.snackbar(
  //         'Success',
  //         'Image selected successfully',
  //         snackPosition: SnackPosition.BOTTOM,
  //         backgroundColor: Colors.green[100],
  //         colorText: Colors.green[900],
  //       );
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       'Error',
  //       'Failed to pick image: ${e.toString()}',
  //       snackPosition: SnackPosition.BOTTOM,
  //       backgroundColor: Colors.red[100],
  //       colorText: Colors.red[900],
  //     );
  //   } finally {
  //     isImageLoading.value = false;
  //   }
  // }

  Future<void> updateProfile() async {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Name is required',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }

    if (selectedImage.value == null) {
      Get.snackbar(
        'Info',
        'Please select a new profile picture to update',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue[100],
        colorText: Colors.blue[900],
      );
      return;
    }

    try {
      isLoading.value = true;

      final result = await _apiService.auth.updateProfile(
        name: nameController.text.trim(),
        profilePicture: selectedImage.value!,
      );

      if (result.isSuccess) {
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green[100],
          colorText: Colors.green[900],
        );
        // Reload profile to get updated data
        await loadProfile();
        // Clear the selected image after successful update
        selectedImage.value = null;
      } else {
        Get.snackbar(
          'Error',
          'Failed to update profile: ${result.error}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red[100],
          colorText: Colors.red[900],
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
    } finally {
      isLoading.value = false;
    }
  }

  void resetForm() {
    nameController.clear();
    selectedImage.value = null;
  }

  void removeSelectedImage() {
    selectedImage.value = null;
  }

  String get currentProfileImageUrl {
    if (selectedImage.value != null) {
      return selectedImage.value!.path;
    }
    return profileImageUrl.value;
  }

  bool get hasProfileImage {
    return selectedImage.value != null || profileImageUrl.value.isNotEmpty;
  }
}
