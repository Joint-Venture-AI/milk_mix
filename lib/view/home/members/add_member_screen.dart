import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/member_controller.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

import 'package:milk_mix/model/member_request.dart';

class AddMemberScreen extends StatefulWidget {
  const AddMemberScreen({super.key});

  @override
  State<AddMemberScreen> createState() => _AddMemberScreenState();
}

class _AddMemberScreenState extends State<AddMemberScreen> {
  final MemberController controller = Get.put(MemberController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _addMember() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Please fill all fields');
      return;
    }
    final request = MemberRequest(name: name, email: email, password: password);
    final result = await controller.addMember(memberRequest: request);

    if (result.isSuccess) {
      print('-------------------');
      Get.snackbar(
        'Success',
        'Member added successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      // Get.back();
    } else {
      Get.snackbar(
        'Error',
        result.error ?? 'Failed to add member',
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
          padding: EdgeInsets.all(20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBarWidget(),
              SvgPicture.asset('assets/logos/addmember.svg', height: 60.h),
              SizedBox(height: 20.h),
              Text(
                textAlign: TextAlign.center,
                'addNewMember'.tr,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                textAlign: TextAlign.center,
                'addNewMemberSub'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textLightGrey,
                ),
              ),
              SizedBox(height: 40.h),
              Container(
                height: 52.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/logos/card.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'memberCost'.tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '\$10 USD',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'memberName'.tr,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'memberNameField'.tr,
                  hintStyle: TextStyle(
                    color: AppColors.textLightGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SvgPicture.asset(
                      'assets/logos/user.svg',
                      width: 18.w,
                      height: 18.h,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(
                    minWidth: 40.w,
                    minHeight: 40.h,
                  ),
                ),
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              ),
              SizedBox(height: 24.h),
              Text(
                'addEmail'.tr,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'enterEmail'.tr,
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
                ),
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              ),
              SizedBox(height: 24.h),
              Text(
                'createPassword'.tr,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  hintText: 'enterPasswordMember'.tr,
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
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              Obx(
                () => Row(
                  children: [
                    Expanded(
                      child: TextButtonWidgetLight(
                        text: 'cancel'.tr,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Expanded(
                      child:
                          controller.addMemberIsLoading.value
                              ? Center(child: CircularProgressIndicator())
                              : TextWidgetButton(
                                text: 'addUser10'.tr,
                                onPressed: _addMember,
                              ),
                    ),
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
