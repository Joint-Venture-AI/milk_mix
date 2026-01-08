import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/auth_controller.dart';
import 'package:milk_mix/view/widget/custom_text_field.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ResetPasswordScreen extends StatefulWidget {
  final String email;
  const ResetPasswordScreen({required this.email, super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final AuthController _authController = Get.find<AuthController>();
  String _otp = '';

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _resetPassword() async {
    if (_otp.length != 6) {
      Get.snackbar('Error', 'Please enter a valid 6-digit OTP');
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      Get.snackbar('Error', 'Passwords do not match');
      return;
    }

    await _authController.resetPassword(
      email: widget.email,
      otp: _otp,
      newPassword: _newPasswordController.text,
    );
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
                    'Reset Password',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    'Enter the code sent to ${widget.email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(height: 40.h),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: PinCodeTextField(
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(12.r),
                        fieldHeight: 48.h,
                        fieldWidth: 48.w,
                        activeFillColor: AppColors.surface,
                        selectedFillColor: AppColors.surface,
                        inactiveFillColor: AppColors.surface,
                        activeColor: AppColors.primary,
                        selectedColor: AppColors.primary,
                        inactiveColor: const Color.fromARGB(255, 220, 220, 220),
                        borderWidth: 1,
                      ),
                      animationDuration: const Duration(milliseconds: 300),
                      enableActiveFill: true,
                      onChanged: (value) {
                        _otp = value;
                      },
                      appContext: context,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  Text('New Password', style: _labelStyle()),
                  SizedBox(height: 6.h),
                  CustomTextField(
                    controller: _newPasswordController,
                    hintText: 'Enter new password',
                    iconPath: 'assets/logos/lock.svg',
                    isPassword: true,
                  ),
                  SizedBox(height: 24.h),

                  Text('Confirm Password', style: _labelStyle()),
                  SizedBox(height: 6.h),
                  CustomTextField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm new password',
                    iconPath: 'assets/logos/lock.svg',
                    isPassword: true,
                  ),
                  SizedBox(height: 44.h),

                  Obx(
                    () => AbsorbPointer(
                      absorbing: _authController.isLoading.value,
                      child: Opacity(
                        opacity: _authController.isLoading.value ? 0.6 : 1,
                        child: TextWidgetButton(
                          text: 'Reset Password',
                          onPressed: _resetPassword,
                        ),
                      ),
                    ),
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
}
