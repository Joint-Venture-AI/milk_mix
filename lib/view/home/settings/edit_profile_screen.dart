import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/profile_farm_controller.dart';
import 'package:milk_mix/data_source/api/provider/api_config.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

//api-done:edit profile
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _farmNameController = TextEditingController();
  final TextEditingController _masterUsernameController =
      TextEditingController();
  final controller = Get.put(ProfileFarmController());

  @override
  void initState() {
    super.initState();
    _nameController.text =
        controller.userProfile.value?.userProfile?.name ?? '';
    _farmNameController.text =
        controller.userProfile.value?.userProfile?.farmName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: SvgPicture.asset(
                            'assets/logos/back.svg',
                            height: 30.w,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        'updateProfile'.tr,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28.h),
              Obx(() {
                return Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.textLightGrey,
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child:
                        controller
                                    .userProfile
                                    .value
                                    ?.userProfile
                                    ?.profilePicture ==
                                null
                            ? SvgPicture.asset(
                              'assets/logos/camera.svg',
                              width: 30.w,
                              height: 30.h,
                            )
                            : ClipRRect(
                              borderRadius: BorderRadius.circular(50.r),
                              child: Image.network(
                                ApiConfig.baseUrl +
                                    controller
                                        .userProfile
                                        .value!
                                        .userProfile!
                                        .profilePicture!,
                                width: 100.w,
                                height: 100.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                  ),
                );
              }),
              SizedBox(height: 20.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ElevatedButton(
                  onPressed: () async {
                    final pickedFile = await ImagePicker().pickImage(
                      source: ImageSource.gallery,
                    );

                    if (pickedFile != null) {
                      final imageFile = File(pickedFile.path);
                      await controller.updateProfile(profilePicture: imageFile);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 48.h),
                    backgroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      side: BorderSide(color: AppColors.primary, width: 1.w),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/logos/upload.svg', height: 16.h),
                      SizedBox(width: 8.w),
                      Text(
                        'uploadPhoto'.tr,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                textAlign: TextAlign.center,
                'photoPixels'.tr,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textLightGrey,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'changeName'.tr,
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                keyboardType: TextInputType.name,
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'changeName'.tr,
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
                ),
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              ),
              SizedBox(height: 16.h),
              Text(
                'Change Farm Name',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                keyboardType: TextInputType.name,
                controller: _farmNameController,
                decoration: InputDecoration(
                  hintText: 'Your Farm Name',
                  hintStyle: TextStyle(
                    color: AppColors.textLightGrey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(12.w),
                    child: SvgPicture.asset(
                      'assets/logos/milkmix.svg',
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                ),
                style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              ),
              // SizedBox(height: 24.h),
              // Text(
              //   'changeEmail'.tr,
              //   style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              // ),
              // SizedBox(height: 6.h),
              // TextField(
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecoration(
              //     hintText: 'changeEmail'.tr,
              //     hintStyle: TextStyle(
              //       color: AppColors.textLightGrey,
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w400,
              //     ),
              //     prefixIcon: Padding(
              //       padding: EdgeInsets.all(12.w),
              //       child: SvgPicture.asset(
              //         'assets/logos/mail.svg',
              //         width: 20.w,
              //         height: 20.h,
              //       ),
              //     ),
              //   ),
              //   style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              // ),
              // SizedBox(height: 24.h),
              // Text.rich(
              //   TextSpan(
              //     children: [
              //       TextSpan(
              //         text: '${'change'.tr} ',
              //         style: TextStyle(
              //           fontSize: 14.sp,
              //           fontWeight: FontWeight.w600,
              //           color: Colors.black,
              //         ),
              //       ),
              //       TextSpan(
              //         text: 'Master Username',
              //         style: TextStyle(
              //           fontSize: 14.sp,
              //           fontWeight: FontWeight.w600,
              //           color: AppColors.primary,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // SizedBox(height: 6.h),
              // TextField(
              //   keyboardType: TextInputType.emailAddress,
              //   decoration: InputDecoration(
              //     hintText: 'changeMasterUsername'.tr,
              //     hintStyle: TextStyle(
              //       color: AppColors.textLightGrey,
              //       fontSize: 14.sp,
              //       fontWeight: FontWeight.w400,
              //     ),
              //     prefixIcon: Padding(
              //       padding: EdgeInsets.all(12.w),
              //       child: SvgPicture.asset(
              //         'assets/logos/at.svg',
              //         width: 20.w,
              //         height: 20.h,
              //       ),
              //     ),
              //   ),
              //   style: TextStyle(color: AppColors.textPrimary, fontSize: 14.sp),
              // ),
              SizedBox(height: 60.h),
              Row(
                children: [
                  // Expanded(
                  //   child: TextButtonWidgetLight(
                  //     text: 'reset'.tr,
                  //     onPressed: () {},
                  //   ),
                  // ),
                  // SizedBox(width: 15.w),
                  Obx(() {
                    return Expanded(
                      child: TextWidgetButton(
                        text: controller.isLoading.value ? '...' : 'update'.tr,
                        onPressed:
                            controller.isLoading.value
                                ? null
                                : () async {
                                  if (_nameController.text.isEmpty) {
                                    Get.snackbar(
                                      'Name',
                                      'Name is required',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red[100],
                                      colorText: Colors.red[900],
                                    );
                                    return;
                                  }
                                  await controller.updateProfile(
                                    name: _nameController.text.trim(),
                                    farmName: _farmNameController.text.trim(),
                                  );
                                },
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
