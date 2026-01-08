// lib/view/widget/recipe_summary_widget.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/home/calculate/mesurement_units.dart';
import 'package:milk_mix/view/home/calculate/mix_calculation_service.dart';

class RecipeSummaryWidget extends StatelessWidget {
  final CalculationResult calculationResult;
  final MeasurementSystem measurementSystem;
  final dynamic selectedUnit;
  final VoidCallback? onSave;

  const RecipeSummaryWidget({
    super.key,
    required this.calculationResult,
    required this.measurementSystem,
    required this.selectedUnit,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1.r),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          _buildHeader(),
          SizedBox(height: 18.h),
          _buildWaterRow(),
          SizedBox(height: 18.h),
          _buildMilkPowderRow(),
          SizedBox(height: 18.h),
          _buildWaterMilkRow(),
          SizedBox(height: 18.h),
          _buildHospitalMilkUsedRow(),
          SizedBox(height: 10.h),
          Divider(color: AppColors.lightGrey, thickness: 1.h, height: 6.h),
          SizedBox(height: 10.h),
          _buildTotalVolumeRow(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        SvgPicture.asset('assets/logos/clip.svg', height: 20.h),
        SizedBox(width: 8.w),
        Text(
          'recipeSummary'.tr,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Spacer(),

        // SvgPicture.asset('assets/logos/copy.svg', height: 20.h),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade100,
            foregroundColor: Colors.grey.shade900,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 0.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.r),
            ),
            elevation: 0,
          ),
          onPressed: onSave,
          child: Text(
            'Save',
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
          ),
        ),
        // InkWell(
        //   borderRadius: BorderRadius.circular(20.r),
        //   onTap: () {
        //     // Implement save functionality here
        //   },
        //   child: Container(
        //     // height: 30.h,
        //     padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        //     decoration: BoxDecoration(
        //       color: Colors.grey.shade100,
        //       borderRadius: BorderRadius.circular(20.r),
        //     ),
        //     child: Text(
        //       'Save',
        //       style: TextStyle(
        //         fontSize: 14.sp,
        //         fontWeight: FontWeight.w500,
        //         color: Colors.grey.shade900,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _buildWaterRow() {
    return Container(
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F7Fd),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/logos/water.svg'),
          SizedBox(width: 8.w),
          Text(
            'water'.tr,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Spacer(),
          Text(
            '= ${calculationResult.waterAmount.toStringAsFixed(0)} '
            '(${measurementSystem == MeasurementSystem.imperial ? 'lbs' : 'kg'})',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMilkPowderRow() {
    return Container(
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: AppColors.shade,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/logos/bag.svg'),
          SizedBox(width: 8.w),
          Text(
            'milkPowder'.tr,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Spacer(),
          Text(
            '= ${calculationResult.milkReplacerAmount.toStringAsFixed(0)} '
            '(${measurementSystem == MeasurementSystem.imperial ? 'lbs' : 'kg'})',
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterMilkRow() {
    return Container(
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: const Color(0xFFfffae9),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/logos/water.svg'),
          const Text('+'),
          SvgPicture.asset('assets/logos/bag.svg'),
          SizedBox(width: 8.w),
          Text(
            'waterMilk'.tr,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Spacer(),
          Text(
            '= ${(calculationResult.waterAmount + calculationResult.milkReplacerAmount).toStringAsFixed(0)} '
            '(${measurementSystem == MeasurementSystem.imperial ? 'lbs' : 'kg'})',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHospitalMilkUsedRow() {
    final unitAbbreviation =
        measurementSystem == MeasurementSystem.imperial ? 'lbs' : 'kg';

    return Container(
      padding: EdgeInsets.all(13.w),
      decoration: BoxDecoration(
        color: const Color(0xFFffe9e9),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          SvgPicture.asset('assets/logos/aid.svg'),
          SizedBox(width: 8.w),
          Text(
            'hospitalMilkUsed'.tr,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          Spacer(),
          Text(
            '= ${calculationResult.hospitalMilkAmount.toStringAsFixed(0)} ($unitAbbreviation)',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalVolumeRow() {
    return Row(
      children: [
        Text(
          'totalVolume'.tr,
          style: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        Spacer(),
        Text(
          '= ${calculationResult.totalVolume.toStringAsFixed(0)} '
          '(${measurementSystem == MeasurementSystem.imperial ? 'lbs' : 'kg'})',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
