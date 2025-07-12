import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class ManageFarmScreen extends StatefulWidget {
  const ManageFarmScreen({super.key});

  @override
  State<ManageFarmScreen> createState() => _MembersPremiumScreenState();
}

class _MembersPremiumScreenState extends State<ManageFarmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Join Farm',
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
              SizedBox(height: 20.h),
              Container(
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

              SizedBox(height: 20.h),
              Container(
                height: 84.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.surfaceGrey, width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Opacity(
                          opacity: 0.5,
                          child: SvgPicture.asset(
                            'assets/logos/sample.svg',
                            width: 24.w,
                            height: 24.h,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Danial Dairy Farm',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary.withOpacity(.5),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Container(
                      padding: EdgeInsets.all(6.w),
                      decoration: BoxDecoration(
                        color: Color(0xFFFFEBC4),
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logos/history_h.svg',
                            width: 14.w,
                            color: AppColors.textPrimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Your request is pending',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 360.h),
              TextWidgetButton(
                text: '+  Add Farm (\$25/farm)',
                onPressed: () {
                  Get.toNamed(AppRoutes.addFarm);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
