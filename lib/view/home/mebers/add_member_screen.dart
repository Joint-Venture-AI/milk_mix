import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

class AddMemberScreen extends StatelessWidget {
  const AddMemberScreen({super.key});

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
                'Add New Member',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                textAlign: TextAlign.center,
                'Your user will use this credentials and login to his account',
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
                      'Start Measuring',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '/\$10 USD',
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
                'Member Name',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Enter member name',
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
                'Add Email',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Add email',
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
                'Create Password',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TextField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Create password for member',
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
              Row(
                children: [
                  Expanded(
                    child: TextButtonWidgetLight(
                      text: 'Cancel',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: TextWidgetButton(
                      text: 'Add User -/\$10',
                      onPressed: () {
                        Get.toNamed(AppRoutes.home);
                      },
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
