import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

class ConsultFarmList extends StatelessWidget {
  const ConsultFarmList({super.key});

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Joined Farm',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Manage member and histories',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset('assets/logos/i.svg', width: 20.w),
                ],
              ),
              SizedBox(height: 34.h),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.consultFarm);
                },
                child: Container(
                  height: 52.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.surfaceGrey, width: 1),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/logos/sample.svg',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Danial Dairy Farm',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              GestureDetector(
                onTap: () {
                  Get.toNamed(AppRoutes.consultFarm);
                },
                child: Container(
                  height: 52.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.surfaceGrey, width: 1),
                  ),
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        'assets/logos/sample.svg',
                        width: 24.w,
                        height: 24.h,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Danial Dairy Farm',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 430.h),

              TextButtonWidgetLight(
                text: '+ Add Farm(\$25/farm)',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
