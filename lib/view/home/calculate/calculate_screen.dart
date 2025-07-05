import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/widget/unit_selector_widget.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              SizedBox(
                height: 100.h,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGrey, width: 1.r),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Ads Only',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              const UnitSelectorWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
