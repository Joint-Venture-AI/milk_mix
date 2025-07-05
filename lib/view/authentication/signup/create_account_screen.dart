import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

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
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 14.h),
              Text(
                textAlign: TextAlign.center,
                'Create Your Account',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Name',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your pasword',
                  hintStyle: TextStyle(
                    color: AppColors.textLightGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SvgPicture.asset(
                      'assets/logos/user.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),

                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40.w,
                    minHeight: 40.h,
                  ),
                ),
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                'Email',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your pasword',
                  hintStyle: TextStyle(
                    color: AppColors.textLightGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SvgPicture.asset(
                      'assets/logos/mail.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),

                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40.w,
                    minHeight: 40.h,
                  ),
                ),
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              ),
              SizedBox(height: 20.h),
              Text(
                'Password',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter your pasword',
                  hintStyle: TextStyle(
                    color: AppColors.textLightGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SvgPicture.asset(
                      'assets/logos/lock.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),

                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40.w,
                    minHeight: 40.h,
                  ),
                ),
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              ),
              SizedBox(height: 40.h),
              TextWidgetButton(
                text: 'Create Account',
                onPressed: () {
                  Get.toNamed(AppRoutes.otpVerification);
                },
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
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
                      Get.toNamed(AppRoutes.createAccount);
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 14,

                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: Divider(color: Colors.grey.shade200, thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    child: Text(
                      'or continue with',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Divider(color: Colors.grey.shade200, thickness: 1),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        backgroundColor: AppColors.shade,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logos/google.svg',
                            width: 18.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Google',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(double.infinity, 48.h),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),

                        backgroundColor: AppColors.shade,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logos/apple.svg',
                            width: 18.w,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Apple',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF1A1A1A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
