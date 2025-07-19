import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        "Weak Password",
        "Password must be at least 6 characters",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      setState(() => isLoading = true);

      final url = Uri.parse(
        "https://lamprey-included-lion.ngrok-free.app/api/auth/register/",
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "role": "consultant",
          "password": password,
        }),
      );

      setState(() => isLoading = false);

      final resData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "Account created. Please verify OTP.",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade50,
        );
        Get.toNamed(AppRoutes.otpVerification, arguments: {"email": email});
      } else {
        final message =
            resData['message'] ?? resData['error'] ?? "Something went wrong";
        Get.snackbar(
          "Signup Failed",
          message,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      setState(() => isLoading = false);
      Get.snackbar(
        "Error",
        "Unexpected error: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Widget buildLabel(String text) => Text(
    text,
    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
  );

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    required String icon,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textLightGrey,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: SvgPicture.asset(icon, width: 20.w, height: 20.h),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
      ),
      style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 40.h),
              Center(
                child: Row(
                  children: [
                    SizedBox(width: 115.w),
                    SvgPicture.asset('assets/logos/milkmix.svg', width: 80.w),
                    const Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                'createAccountTitle'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 24.h),

              buildLabel('name'.tr),
              buildTextField(
                controller: _nameController,
                hintText: 'enterYourName'.tr,
                icon: 'assets/logos/user.svg',
              ),
              SizedBox(height: 20.h),

              buildLabel('email'.tr),
              buildTextField(
                controller: _emailController,
                hintText: 'enterYourEmail'.tr,
                icon: 'assets/logos/mail.svg',
              ),
              SizedBox(height: 20.h),

              buildLabel('password'.tr),
              buildTextField(
                controller: _passwordController,
                hintText: 'enterPassword'.tr,
                icon: 'assets/logos/lock.svg',
                obscureText: true,
              ),
              SizedBox(height: 40.h),

              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : TextWidgetButton(
                    text: 'createAccount'.tr,
                    onPressed: registerUser,
                  ),

              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "alreadyHaveAnAccount".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () => Get.toNamed(AppRoutes.signin),
                    child: Text(
                      'login'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
