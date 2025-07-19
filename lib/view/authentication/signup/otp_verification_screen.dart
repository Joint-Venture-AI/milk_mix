import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:milk_mix/constants/color.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  String? _otp;
  bool isLoading = false;

  Future<void> verifyOtp() async {
    final email = Get.arguments?['email'] as String?;
    if (email == null || _otp == null || _otp!.length != 6) {
      Get.snackbar(
        "Error",
        "Please enter a valid 6-digit OTP",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      final url = Uri.parse(
        "https://lamprey-included-lion.ngrok-free.app/api/auth/otp/verify/",
      );
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"email": email, "otp": _otp}),
      );

      setState(() => isLoading = false);

      final resData = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "Success",
          "OTP verified successfully",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green.shade50,
        );
        Get.toNamed(AppRoutes.selectLanguage);
      } else {
        final message =
            resData['message'] ?? resData['error'] ?? "OTP verification failed";
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
                'verifyEmailSubTitle'.tr,
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
                    onPressed: () {
                      Get.snackbar(
                        "Info",
                        "Resend OTP functionality not implemented",
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    child: Text(
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
