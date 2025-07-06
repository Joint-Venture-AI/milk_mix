import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/widget/history_wigets.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'History',
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '8 Calculations',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    height: 36.h,
                    width: 90.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD96346), width: 1),
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/logos/trash.svg'),
                        SizedBox(width: 9.w),
                        Text(
                          'Clear',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFD96346),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),
              HistoryTile(
                number: '01',
                volume: '1500',
                date: '06-7-25',
                time: '10:30 AM',
              ),
              HistoryTile(
                number: '01',
                volume: '1500',
                date: '06-7-25',
                time: '10:30 AM',
              ),
              HistoryTile(
                number: '01',
                volume: '1500',
                date: '06-7-25',
                time: '10:30 AM',
              ),
              HistoryTile(
                number: '01',
                volume: '1500',
                date: '06-7-25',
                time: '10:30 AM',
              ),
              HistoryTile(
                number: '01',
                volume: '1500',
                date: '06-7-25',
                time: '10:30 AM',
              ),
              HistoryTile(
                number: '01',
                volume: '1500',
                date: '06-7-25',
                time: '10:30 AM',
              ),
              HistoryTile(
                number: '01',
                volume: '1500',
                date: '06-7-25',
                time: '10:30 AM',
              ),
              HistoryTile(
                number: '01',
                volume: '1500',
                date: '06-7-25',
                time: '10:30 AM',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
