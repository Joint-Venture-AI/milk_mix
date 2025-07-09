import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milk_mix/constants/color.dart';

class PaymentHistoryTile extends StatelessWidget {
  final String price;
  final String date;
  final bool isPaid;
  final bool isLast; // New flag

  const PaymentHistoryTile({
    super.key,
    required this.price,
    required this.date,
    this.isPaid = true,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left icon
              Container(
                height: 44.h,
                width: 44.h,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(6.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/logos/history2.svg', // Replace with your payment icon path
                    height: 44.h,
                    width: 44.h,
                  ),
                ),
              ),
              SizedBox(width: 12.w),

              // Middle column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),

              if (isPaid)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  child: Text(
                    'Paid',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
        ),

        if (!isLast)
          Container(
            height: 1.h,
            width: double.infinity,
            color: AppColors.lightGrey,
          ),
      ],
    );
  }
}
