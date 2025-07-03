import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  String selectedType = 'individual';
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _usernameController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 54.h),
              Text(
                'Select Login Type',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Select how you want to sign in to your account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textGrey,
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                height: 45.h,
                decoration: BoxDecoration(
                  color: AppColors.shade,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      ToggleButton('individual', 'Individual User'),
                      ToggleButton('farm', 'Farm User'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 42.h),

              if (selectedType == 'individual') ...[
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      color: AppColors.textLightGrey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(
                      color: AppColors.textLightGrey,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                  ),
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
                    child: const Text(
                      'Forgot password',
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 44.h),
                TextWidgetButton(text: 'Login as Individual', onPressed: () {}),
                SizedBox(height: 56.h),
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
                  ],
                ),
                SizedBox(height: 20.h),
              ] else ...[
                Text(
                  'Farm Username',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: _usernameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Enter your username',
                    hintStyle: TextStyle(
                      color: AppColors.textLightGrey,
                      fontSize: 14.sp,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(
                      color: AppColors.textLightGrey,
                      fontSize: 14.sp,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
                SizedBox(height: 24.h),
                Text(
                  'Password',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 6.h),
                TextField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(
                      color: AppColors.textLightGrey,
                      fontSize: 14.sp,
                    ),
                  ),
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14.sp,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget ToggleButton(String value, String text) {
    final isSelected = selectedType == value;
    return Expanded(
      child: SizedBox(
        height: 33.h,

        child: GestureDetector(
          onTap: () => setState(() => selectedType = value),
          child: Container(
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(5.r),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: isSelected ? Colors.white : AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
