import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/presentation/widget/text_button_widget.dart';
import 'package:milk_mix/presentation/widget/text_widget_button_white.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 509.h,
                width: double.infinity,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: SvgPicture.asset(
                        'assets/backgrounds/Frame.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 150.h),
                          Row(
                            children: [
                              SizedBox(width: 110.w),
                              SvgPicture.asset(
                                'assets/logos/milkmix.svg',
                                width: 124.w,
                              ),
                              const Spacer(),
                            ],
                          ),
                          SizedBox(height: 28.h),
                          Text(
                            'Welcome to MilkMix',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 24.sp,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Text(
                              'Sign in to continue mixing with your saved values and settings.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    TextWidgetButton(
                      text: 'Create New Account',
                      onPressed: () {},
                    ),
                    SizedBox(height: 12.h),
                    TextWidgetButtonWhite(
                      text: 'Sign in to Existing Account',
                      onPressed: () {},
                    ),
                    SizedBox(height: 20.h),

                    /// Divider
                    Row(
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.shade200,
                            thickness: 1,
                          ),
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
                          child: Divider(
                            color: Colors.grey.shade200,
                            thickness: 1,
                          ),
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
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              backgroundColor: Color(0xFFF4F6F8),
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
                                borderRadius: BorderRadius.circular(8.r),
                              ),

                              backgroundColor: Color(0xFFF4F6F8),
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
                      ],
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
