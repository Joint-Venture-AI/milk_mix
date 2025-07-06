import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milk_mix/constants/color.dart';

class HistoryTile extends StatelessWidget {
  final String number;
  final String volume;
  final String date;
  final String time;

  const HistoryTile({
    super.key,
    required this.number,
    required this.volume,
    required this.date,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
          leading: Container(
            height: 44.h,
            width: 44.h,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(6.r),
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
          ),
          title: Text(
            'Total Volume: $volume',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          subtitle: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Row(
              children: [
                SvgPicture.asset('assets/logos/date.svg', height: 13.h),
                SizedBox(width: 4.w),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 4.w),
                SvgPicture.asset('assets/logos/time.svg', height: 14.h),
                SizedBox(width: 2.w),
                Text(
                  time,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          trailing: SvgPicture.asset(
            'assets/logos/notification.svg',
            height: 18.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          tileColor: Colors.white,
        ),
        Container(
          height: 1.h,
          width: double.infinity,
          color: AppColors.lightGrey,
        ),
      ],
    );
  }
}
