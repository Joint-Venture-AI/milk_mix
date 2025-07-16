import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/settings_tile.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16.h),
              Text(
                'settings'.tr,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary, width: 2),
                    ),
                    child: Icon(
                      Icons.person,
                      color: AppColors.primary,
                      size: 24.h,
                    ),
                  ),
                  SizedBox(width: 14.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'John Deo',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        'sample@gmail.com',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textLightGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SettingTile(
                iconPath: 'assets/logos/group.svg',
                title: 'editProfile'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.editProfile);
                },
              ),
              SettingTile(
                iconPath: 'assets/logos/subs.svg',
                title: 'subscriptionAndPlan'.tr,

                onTap: () {
                  Get.toNamed(AppRoutes.subscription);
                },
              ),
              SettingTile(
                iconPath: 'assets/logos/language copy.svg',
                title: 'language'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.editLanguage);
                },
              ),
              SettingTile(
                iconPath: 'assets/logos/scale copy.svg',
                title: 'changeMeasurements'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.editMeasurement);
                },
              ),
              SettingTile(
                iconPath: 'assets/logos/lock copy.svg',
                title: 'changePassword'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.changePassword);
                },
              ),
              SettingTile(
                iconPath: 'assets/logos/question.svg',
                title: 'helpAndSupport'.tr,
                onTap: () {
                  Get.toNamed(AppRoutes.helpAndSupport);
                },
              ),
              SettingTile(
                iconPath: 'assets/logos/logout.svg',
                title: 'logout'.tr,

                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
