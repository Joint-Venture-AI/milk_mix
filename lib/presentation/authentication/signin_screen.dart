import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milk_mix/presentation/widget/text_button_widget.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Upper background and logo section
            SizedBox(
              height: 509.h,
              width: double.infinity,
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: SvgPicture.asset(
                      'assets/backgrounds/Frame.svg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  // Logo and welcome message
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 185.h),
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

            // Bottom button section
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  TextWidgetButton(
                    text: 'Create New',
                    onPressed: () {
                      // Add navigation or logic here
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
