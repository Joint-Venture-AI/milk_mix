import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/profile_controller.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

class EditProfileFarmScreen extends StatelessWidget {
  const EditProfileFarmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Obx(
          () =>
              controller.isLoading.value
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Loading profile...',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  )
                  : SingleChildScrollView(
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
                        // Profile Image Section
                        Obx(
                          () => Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
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
                                child: GestureDetector(
                                  onTap: () {},
                                  // () => controller.showImagePickerOptions(),
                                  child:
                                      controller.selectedImage.value != null
                                          ? ClipOval(
                                            child: Image.file(
                                              controller.selectedImage.value!,
                                              width: 100.w,
                                              height: 100.w,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                          : controller
                                              .profileImageUrl
                                              .value
                                              .isNotEmpty
                                          ? ClipOval(
                                            child: Image.network(
                                              controller.profileImageUrl.value,
                                              width: 100.w,
                                              height: 100.w,
                                              fit: BoxFit.cover,
                                              errorBuilder: (
                                                context,
                                                error,
                                                stackTrace,
                                              ) {
                                                return Center(
                                                  child: SvgPicture.asset(
                                                    'assets/logos/camera.svg',
                                                    width: 30.w,
                                                    height: 30.h,
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                          : Center(
                                            child: SvgPicture.asset(
                                              'assets/logos/camera.svg',
                                              width: 30.w,
                                              height: 30.h,
                                            ),
                                          ),
                                ),
                              ),
                              if (controller.selectedImage.value != null)
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: GestureDetector(
                                    onTap:
                                        () => controller.removeSelectedImage(),
                                    child: Container(
                                      width: 24.w,
                                      height: 24.w,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 16.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              if (controller.isImageLoading.value)
                                Positioned.fill(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2.w,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Colors.white,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: ElevatedButton(
                            onPressed:
                                controller.isImageLoading.value
                                    ? null
                                    : () {
                                      print('pressed');
                                      // controller.showImagePickerOptions();
                                    },
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(double.infinity, 48.h),
                              backgroundColor:
                                  controller.isImageLoading.value
                                      ? Colors.grey[300]
                                      : Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                side: BorderSide(
                                  color:
                                      controller.isImageLoading.value
                                          ? Colors.grey[400]!
                                          : AppColors.primary,
                                  width: 1.w,
                                ),
                              ),
                            ),
                            child: Obx(
                              () =>
                                  controller.isImageLoading.value
                                      ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 20.w,
                                            height: 20.h,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.w,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                    AppColors.primary,
                                                  ),
                                            ),
                                          ),
                                          SizedBox(width: 8.w),
                                          Text(
                                            'Processing...',
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        ],
                                      )
                                      : Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SvgPicture.asset(
                                            'assets/logos/camera.svg',
                                            height: 16.h,
                                          ),
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
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        TextField(
                          controller: controller.nameController,
                          keyboardType: TextInputType.text,
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
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text(
                          'changeEmail'.tr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        TextField(
                          controller: controller.emailController,
                          keyboardType: TextInputType.emailAddress,
                          enabled: false, // Email cannot be changed
                          decoration: InputDecoration(
                            hintText: 'changeEmail'.tr,
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
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 24.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${'change'.tr} ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: 'Master Username',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 6.h),
                        TextField(
                          controller: controller.masterUsernameController,
                          keyboardType: TextInputType.text,
                          enabled: false, // Username cannot be changed
                          decoration: InputDecoration(
                            hintText: 'changeMasterUsername'.tr,
                            hintStyle: TextStyle(
                              color: AppColors.textLightGrey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(12.w),
                              child: SvgPicture.asset(
                                'assets/logos/at.svg',
                                width: 20.w,
                                height: 20.h,
                              ),
                            ),
                          ),
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 60.h),
                        Row(
                          children: [
                            Expanded(
                              child: TextButtonWidgetLight(
                                text: 'reset'.tr,
                                onPressed: () => controller.resetForm(),
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Obx(
                                () => TextWidgetButton(
                                  text:
                                      controller.isLoading.value
                                          ? 'Updating...'
                                          : 'update'.tr,
                                  onPressed:
                                      controller.isLoading.value
                                          ? null
                                          : () => controller.updateProfile(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
        ),
      ),
    );
  }
}
