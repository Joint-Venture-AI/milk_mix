import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> loginUser() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "Email and password are required",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
          "https://lamprey-included-lion.ngrok-free.app/api/auth/login/",
        ),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "password": password}),
      );

      final decoded = jsonDecode(response.body);

      if (decoded["success"] == true) {
        final data = decoded["data"];
        final role = data["role"];

        if (role == "consultant") {
          Get.offAllNamed(AppRoutes.homeConsult);
        } else if (role == "farm") {
          Get.offAllNamed(AppRoutes.farmMemberHome);
        } else {
          Get.snackbar(
            "Error",
            "Unknown role: $role",
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } else {
        Get.snackbar(
          "Login Failed",
          decoded["message"] ?? "Try again",
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
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
<<<<<<< HEAD
                'loginTile'.tr,
=======
                'loginToMilkMix'.tr,
>>>>>>> 7a24e9cd9c6b829c86e473dd5ff7f9585bee86e9
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 42.h),

              // EMAIL
              Text('email'.tr, style: labelStyle()),
              SizedBox(height: 6.h),
              buildTextField(
                _emailController,
                'enterYourEmail'.tr,
                'assets/logos/mail.svg',
              ),
              SizedBox(height: 24.h),

              Text('password'.tr, style: labelStyle()),
              SizedBox(height: 6.h),
              buildTextField(
                _passwordController,
                'enterPassword'.tr,
                'assets/logos/lock.svg',
                obscure: true,
              ),
              SizedBox(height: 6.h),

              Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {},
                  child: Text(
                    'forgotPassword'.tr,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 44.h),

              TextWidgetButton(text: 'login'.tr, onPressed: loginUser),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('dontHaveAnAccount'.tr, style: regularStyle()),
                  SizedBox(width: 8.w),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {
                      Get.toNamed(AppRoutes.createAccount);
                    },
                    child: Text(
                      'signUp'.tr,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
    TextEditingController controller,
    String hintText,
    String iconPath, {
    bool obscure = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: AppColors.textLightGrey, fontSize: 14.sp),
        prefixIcon: Padding(
          padding: EdgeInsets.all(12.w),
          child: SvgPicture.asset(
            iconPath,
            width: 20.w,
            height: 20.h,
            color: AppColors.textPrimary,
          ),
        ),
        prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
      ),
      style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
    );
  }

  TextStyle labelStyle() =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);

  TextStyle regularStyle() => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
