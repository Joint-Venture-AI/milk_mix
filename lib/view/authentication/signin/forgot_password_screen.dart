import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/auth_controller.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/custom_text_field.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    final email = _emailController.text;
    final success = await _authController.forgotPassword(email: email);
    if (success) {
      Get.toNamed(AppRoutes.resetPassword, arguments: {'email': email});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 40.h),
                  Center(
                    child: Row(
                      children: [
                        SizedBox(width: 115.w),
                        SvgPicture.asset(
                          'assets/logos/milkmix.svg',
                          width: 80.w,
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    'Forgot Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 42.h),

                  Text('Email', style: _labelStyle()),
                  SizedBox(height: 6.h),
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'Enter your email',
                    iconPath: 'assets/logos/mail.svg',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 44.h),

                  Obx(
                    () => AbsorbPointer(
                      absorbing: _authController.isLoading.value,
                      child: Opacity(
                        opacity: _authController.isLoading.value ? 0.6 : 1,
                        child: TextWidgetButton(
                          text: 'Send OTP',
                          onPressed: _sendOtp,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Remember password?', style: _regularStyle()),
                      SizedBox(width: 8.w),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: Size.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w700,
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Obx(
              () =>
                  _authController.isLoading.value
                      ? Container(
                        color: Colors.black.withOpacity(0.2),
                        child: Center(
                          child: Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: const CircularProgressIndicator(),
                          ),
                        ),
                      )
                      : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  TextStyle _labelStyle() =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);

  TextStyle _regularStyle() => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
