import 'package:get/get.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/routes.dart';

class AuthController extends GetxController {
  final RxBool isLoading = false.obs;
  final ApiProvider apiService = ApiProvider();

  Future<void> login({required String email, required String password}) async {
    if (email.trim().isEmpty || password.trim().isEmpty) {
      Get.snackbar('Error', 'Email and password are required');
      return;
    }

    isLoading.value = true;

    final result = await apiService.auth.login(
      email: email.trim(),
      password: password.trim(),
    );

    if (result.isSuccess) {
      Get.offAllNamed(AppRoutes.splashScreen);
    } else {
      Get.snackbar(
        'Login Failed',
        'Try again',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }

  Future<bool> forgotPassword({required String email}) async {
    if (email.trim().isEmpty) {
      Get.snackbar('Error', 'Email is required');
      return false;
    }

    isLoading.value = true;
    final result = await apiService.auth.passwordResetRequest(
      email: email.trim(),
    );
    isLoading.value = false;

    if (result.isSuccess) {
      Get.snackbar(
        'Success',
        'OTP sent to your email',
        backgroundColor: Get.theme.primaryColor.withOpacity(0.1),
      );
      return true;
    } else {
      Get.snackbar(
        'Error',
        result.error ?? 'Failed to send OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }

  Future<bool> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
  }) async {
    if (otp.isEmpty || newPassword.isEmpty) {
      Get.snackbar('Error', 'OTP and New Password are required');
      return false;
    }

    isLoading.value = true;
    final result = await apiService.auth.passwordResetConfirm(
      email: email.trim(),
      otp: otp,
      newPassword: newPassword,
    );
    isLoading.value = false;

    if (result.isSuccess) {
      Get.snackbar(
        'Success',
        'Password reset successfully',
        backgroundColor: Get.theme.primaryColor.withOpacity(0.1),
      );
      Get.offAllNamed(AppRoutes.signin);
      return true;
    } else {
      Get.snackbar(
        'Error',
        result.error ?? 'Failed to reset password',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
  }
}
