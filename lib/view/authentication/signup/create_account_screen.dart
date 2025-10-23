import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/custom_text_field.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController();
  final _farmNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late final ApiProvider _apiService = ApiProvider();

  bool isLoading = false;

  String _selectedRole = 'farm';
  final List<String> _roles = ['consultant', 'farm'];
  final Map<String, String> roleLabels = {
    'consultant': 'Consultant',
    'farm': 'Individual',
  };

  @override
  void dispose() {
    _nameController.dispose();
    _farmNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> registerUser() async {
    final name = _nameController.text.trim();
    final farmName = _farmNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Error",
        "All fields are required",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "Invalid Email",
        "Please enter a valid email address",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    if (password.length < 6) {
      Get.snackbar(
        "Weak Password",
        "Password must be at least 6 characters",
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    setState(() => isLoading = true);

    final result = await _apiService.auth.register(
      email: email,
      password: password,
      name: name,
      farmName: farmName,
      role: _selectedRole,
    );

    setState(() => isLoading = false);

    if (result.isSuccess) {
      Get.snackbar(
        "Success",
        "Account created. Please verify OTP.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.shade50,
      );
      Get.toNamed(AppRoutes.otpVerification, arguments: {"email": email});
    } else {
      Get.snackbar(
        "Error",
        result.error ?? "Failed to create account",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.shade50,
      );
    }
  }

  Widget buildLabel(String text) => Text(
    text,
    style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
  );

  // Widget buildTextField({
  //   required TextEditingController controller,
  //   required String hintText,
  //   required String icon,
  //   bool obscureText = false,
  // }) {
  //   return TextField(
  //     controller: controller,
  //     obscureText: obscureText,
  //     decoration: InputDecoration(
  //       hintText: hintText,
  //       hintStyle: TextStyle(
  //         color: AppColors.textLightGrey,
  //         fontSize: 14.sp,
  //         fontWeight: FontWeight.w400,
  //       ),
  //       prefixIcon: Padding(
  //         padding: EdgeInsets.all(12.w),
  //         child: SvgPicture.asset(icon, width: 20.w, height: 20.h),
  //       ),
  //       prefixIconConstraints: BoxConstraints(minWidth: 40.w, minHeight: 40.h),
  //     ),
  //     style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
  //   );
  // }

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
                'createAccountTitle'.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 24.h),

              buildLabel('name'.tr),
              CustomTextField(
                controller: _nameController,
                hintText: 'enterYourName'.tr,
                iconPath: 'assets/logos/user.svg',
              ),
              SizedBox(height: 20.h),
              buildLabel('Farm Name'),
              CustomTextField(
                controller: _farmNameController,
                hintText: 'Enter Your Farm Name',
                iconPath: 'assets/logos/user.svg',
              ),
              SizedBox(height: 20.h),

              buildLabel('email'.tr),
              CustomTextField(
                controller: _emailController,
                hintText: 'enterYourEmail'.tr,
                iconPath: 'assets/logos/mail.svg',
              ),
              SizedBox(height: 20.h),

              buildLabel('password'.tr),
              CustomTextField(
                controller: _passwordController,
                hintText: 'enterPassword'.tr,
                iconPath: 'assets/logos/lock.svg',
                // obscureText: true,
                isPassword: true,
              ),
              SizedBox(height: 20.h),

              buildLabel('Role'),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                items:
                    _roles.map((String role) {
                      return DropdownMenuItem<String>(
                        value: role,
                        child: Text(
                          roleLabels[role]!,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value!;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select Role',
                  hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 14.h,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.grey.shade400,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: Colors.blueAccent,
                      width: 1.5,
                    ),
                  ),
                ),
                icon: Icon(
                  Icons.arrow_drop_down_rounded,
                  color: Colors.blueAccent,
                ),
                dropdownColor: Colors.white,
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
              ),
              SizedBox(height: 40.h),

              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : TextWidgetButton(
                    text: 'createAccount'.tr,
                    onPressed: registerUser,
                  ),
              SizedBox(height: 20.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "alreadyHaveAnAccount".tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(width: 2.w),
                  TextButton(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero),
                    onPressed: () => Get.toNamed(AppRoutes.signin),
                    child: Text(
                      'login'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
