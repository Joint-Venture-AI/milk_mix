import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/constants/color.dart';

class UnitSelectorWidget extends StatefulWidget {
  const UnitSelectorWidget({super.key});

  @override
  State<UnitSelectorWidget> createState() => _UnitSelectorWidgetState();
}

class _UnitSelectorWidgetState extends State<UnitSelectorWidget> {
  String selectedSystem = 'metric';
  String selectedUnit = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.lightGrey, width: 1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              _buildSystemButton('metric', 'Metric'),
              SizedBox(width: 10.w),
              _buildSystemButton('english', 'English'),
            ],
          ),

          SizedBox(height: 16.h),

          if (selectedSystem == 'metric')
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUnitButton('kg', 'Kilogram'),
                _buildUnitButton('litre', 'Litre'),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildUnitButton('lb', 'Pounds'),
                _buildUnitButton('gallon', 'Gallons'),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildSystemButton(String system, String label) {
    final isSelected = selectedSystem == system;

    return Expanded(
      child: GestureDetector(
        onTap:
            () => setState(() {
              selectedSystem = system;
              selectedUnit = '';
            }),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,

            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.primary,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUnitButton(String unitKey, String label) {
    final isSelected = selectedUnit == unitKey;

    return GestureDetector(
      onTap: () => setState(() => selectedUnit = unitKey),
      child: Container(
        width: 130.w,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : AppColors.lightGrey,
          borderRadius: BorderRadius.circular(8.r),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
