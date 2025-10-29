import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/custom_text_field.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/controllers/auth_controller.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final AuthController _authController;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _authController = Get.put(AuthController());
  }

  Future<void> loginUser() async {
    await _authController.login(
      email: _emailController.text,
      password: _passwordController.text,
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
                    'loginTile'.tr,
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
                  CustomTextField(
                    controller: _emailController,
                    hintText: 'enterYourEmail'.tr,
                    iconPath: 'assets/logos/mail.svg',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 24.h),

                  Text('password'.tr, style: labelStyle()),
                  SizedBox(height: 6.h),
                  CustomTextField(
                    controller: _passwordController,
                    hintText: 'enterPassword'.tr,
                    iconPath: 'assets/logos/lock.svg',
                    isPassword: true,
                  ),
                  SizedBox(height: 6.h),

                  // Align(
                  //   alignment: Alignment.bottomRight,
                  //   child: TextButton(
                  //     style: TextButton.styleFrom(
                  //       padding: EdgeInsets.zero,
                  //       minimumSize: Size.zero,
                  //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  //     ),
                  //     onPressed: () {},
                  //     child: Text(
                  //       'forgotPassword'.tr,
                  //       style: TextStyle(
                  //         color: AppColors.primary,
                  //         fontWeight: FontWeight.bold,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 44.h),

                  Obx(
                    () => AbsorbPointer(
                      absorbing: _authController.isLoading.value,
                      child: Opacity(
                        opacity: _authController.isLoading.value ? 0.6 : 1,
                        child: TextWidgetButton(
                          text: 'login'.tr,
                          onPressed: loginUser,
                        ),
                      ),
                    ),
                  ),
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
                  SizedBox(height: 20.h),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: Divider(
                  //         color: Colors.grey.shade200,
                  //         thickness: 1,
                  //       ),
                  //     ),
                  //     Padding(
                  //       padding: EdgeInsets.symmetric(horizontal: 8.w),
                  //       child: Text(
                  //         'or continue with',
                  //         style: TextStyle(
                  //           fontSize: 12.sp,
                  //           color: Colors.grey.shade600,
                  //         ),
                  //       ),
                  //     ),
                  //     Expanded(
                  //       child: Divider(
                  //         color: Colors.grey.shade200,
                  //         thickness: 1,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 20.h),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () {},
                  //         style: ElevatedButton.styleFrom(
                  //           minimumSize: Size(double.infinity, 48.h),
                  //           elevation: 0,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10.r),
                  //           ),
                  //           backgroundColor: AppColors.shade,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             SvgPicture.asset(
                  //               'assets/logos/google.svg',
                  //               width: 18.w,
                  //             ),
                  //             SizedBox(width: 8.w),
                  //             Text(
                  //               'Google',
                  //               style: TextStyle(
                  //                 fontSize: 16.sp,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Color(0xFF1A1A1A),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //     SizedBox(width: 14.w),
                  //     Expanded(
                  //       child: ElevatedButton(
                  //         onPressed: () {},
                  //         style: ElevatedButton.styleFrom(
                  //           minimumSize: Size(double.infinity, 48.h),
                  //           elevation: 0,
                  //           shape: RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.circular(10.r),
                  //           ),

                  //           backgroundColor: AppColors.shade,
                  //         ),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           children: [
                  //             SvgPicture.asset(
                  //               'assets/logos/apple.svg',
                  //               width: 18.w,
                  //             ),
                  //             SizedBox(width: 8.w),
                  //             Text(
                  //               'Apple',
                  //               style: TextStyle(
                  //                 fontSize: 14.sp,
                  //                 fontWeight: FontWeight.w600,
                  //                 color: Color(0xFF1A1A1A),
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
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

  // Widget buildTextField(
  //   TextEditingController controller,
  //   String hintText,
  //   String iconPath, {
  //   bool obscure = false,
  // }) {
  //   return TextField(
  //     controller: controller,
  //     obscureText: obscure,
  //     decoration: InputDecoration(
  //       hintText: hintText,
  //       hintStyle: TextStyle(color: AppColors.textLightGrey, fontSize: 14.sp),
  //       prefixIcon: Padding(
  //         padding: EdgeInsets.all(12.w),
  //         child: SvgPicture.asset(
  //           iconPath,
  //           width: 20.w,
  //           height: 20.h,
  //           color: AppColors.textPrimary,
  //         ),
  //       ),
  //       prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
  //     ),
  //     style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
  //   );
  // }

  TextStyle labelStyle() =>
      TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);

  TextStyle regularStyle() => TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
}
