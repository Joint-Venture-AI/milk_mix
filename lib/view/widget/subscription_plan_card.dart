import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/constants/color.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String price;
  final String duration;
  final VoidCallback onTap;

  const SubscriptionPlanCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.price,
    required this.duration,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 66.h,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: AppColors.lightGrey, width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14.sp, color: Colors.black),
                children: [
                  TextSpan(
                    text: '$title ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: subtitle,
                    style: const TextStyle(fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            SizedBox(height: 7.h),
            RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 18.sp),
                children: [
                  TextSpan(
                    text: price,
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(
                    text: duration,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
