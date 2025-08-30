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
      final auth = result.data!;
      final role = auth.role;

      if (role == 'consultant') {
        Get.offAllNamed(AppRoutes.homeConsult);
      } else if (role == 'farm') {
        Get.offAllNamed(AppRoutes.farmMemberHome);
      } else if (role == 'farm_user') {
        Get.offAllNamed(AppRoutes.memberHome);
      } else {
        Get.snackbar(
          'Error',
          'Unknown role: $role',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } else {
      Get.snackbar(
        'Login Failed',
        'Try again',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    isLoading.value = false;
  }
}
