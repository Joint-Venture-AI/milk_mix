import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';

class RecipeSummaryDialog extends StatelessWidget {
  const RecipeSummaryDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: AppColors.surface,
      child: Padding(
        padding: EdgeInsets.all(20.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/logos/clip.svg',
                  height: 20.h,
                  width: 20.h,
                ),
                SizedBox(width: 8.w),
                Text(
                  'Recipe Summary',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),

            _buildRow('assets/logos/drop.svg', 'Pounds of Water', ' = 4500'),
            _buildRow(
              'assets/logos/bottle.svg',
              'Pounds of Milk Replacer',
              ' = 4500',
            ),
            _buildRow(
              'assets/logos/bottleMed.svg',
              'Solids Hospital Milk',
              ' = 4500',
            ),
            _buildRow(
              'assets/logos/bottleMed.svg',
              'Hospital Milk Used',
              ' = 4500',
            ),
            Divider(color: Colors.grey.shade300, thickness: 1, height: 15.h),
            _buildRow(null, 'Total Volume', '18000 lbs', bold: true),
            SizedBox(height: 15.h),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFAEFE4),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logos/close.svg',
                            height: 20.h,
                            width: 20.h,
                            color: AppColors.textPrimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Close',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 15.w),

                Expanded(
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE4EDFA),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/logos/copy.svg',
                            height: 16.h,
                            width: 16.h,
                            color: AppColors.textPrimary,
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            'Copy',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
    String? iconPath,
    String label,
    String value, {
    bool bold = false,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          if (iconPath != null)
            SvgPicture.asset(iconPath, height: 20.h, width: 20.h),
          if (iconPath != null) SizedBox(width: 8.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
