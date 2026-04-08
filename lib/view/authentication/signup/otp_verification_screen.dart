import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/controllers/auth_controller.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:milk_mix/constants/color.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String? email;
  const OtpVerificationScreen({this.email, super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String? _otp;
  bool isLoading = false;
  bool _resendLoading = false;

  AuthController get _authController => Get.isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  String? get _email =>
      Get.arguments?['email'] as String? ?? widget.email?.trim();

  Future<void> resendOtp() async {
    final email = _email;
    if (email == null || email.isEmpty) {
      Get.snackbar(
        'Error',
        'Email is required to resend OTP',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    setState(() => _resendLoading = true);
    try {
      await _authController.resendOtp(email: email);
    } finally {
      if (mounted) setState(() => _resendLoading = false);
    }
  }

  Future<void> verifyOtp() async {
    final email = _email;
    if (email == null || email.isEmpty || _otp == null || _otp!.length != 6) {
      Get.snackbar(
        "Error",
        "Please enter a valid 6-digit OTP",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    setState(() => isLoading = true);
    try {
      final result = await ApiProvider.instance.auth.verifyOtp(
        otp: _otp!,
        email: email,
      );

      setState(() => isLoading = false);

      if (result.isSuccess) {
        Get.snackbar(
          "Success",
          "OTP verified successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade50,
        );
        Get.toNamed(AppRoutes.welcome);
      } else {
        final message = "OTP verification failed";
        Get.snackbar("Failed", message, snackPosition: SnackPosition.BOTTOM);
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
                'verifyEmailTitle'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 6.h),

              Text(
                '${'verifyEmailSubTitle'.tr} ${widget.email}',
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

              SizedBox(height: 12.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'dontGetVerificationCode'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textGrey,
                    ),
                  ),
                  SizedBox(width: 4.w),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: _resendLoading ? null : resendOtp,
                    child: _resendLoading
                        ? SizedBox(
                            width: 14.w,
                            height: 14.h,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.primary,
                            ),
                          )
                        : Text(
                            'sendAgain'.tr,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ],
              ),

              SizedBox(height: 290.h),

              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : TextWidgetButton(
                    text: 'verifyOtp'.tr,
                    onPressed: verifyOtp,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
