import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/widget/light_text_input_widget.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  String selectedUnit = 'english';
  String selectedSubUnit = 'gallon';
  bool isDropdownExpanded = false;
  bool isSolidsExpanded = false; // New state for Solids section

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.lightGrey),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isDropdownExpanded = !isDropdownExpanded;
                        });
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(height: 48.h),
                          SvgPicture.asset(
                            'assets/logos/scale.svg',
                            height: 18.h,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Measurement Unit',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            isDropdownExpanded
                                ? 'assets/logos/down.svg'
                                : 'assets/logos/up.svg',
                            height: 24.h,
                          ),
                        ],
                      ),
                    ),
                    if (isDropdownExpanded) ...[
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          _mainUnitToggle('english', 'English'),
                          SizedBox(width: 8.w),
                          _mainUnitToggle('metric', 'Metric'),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children:
                            selectedUnit == 'english'
                                ? [
                                  _subUnitToggle('gallon', 'Gallon'),
                                  SizedBox(width: 8.w),
                                  _subUnitToggle('pounds', 'Pounds'),
                                ]
                                : [
                                  _subUnitToggle('liter', 'Liter'),
                                  SizedBox(width: 8.w),
                                  _subUnitToggle('kilo', 'Kilo'),
                                ],
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ],
                ),
              ),

              SizedBox(height: 20.h),

              buildAllUnitColumns(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _mainUnitToggle(String value, String label) {
    final isSelected = selectedUnit == value;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedUnit = value;
            selectedSubUnit = value == 'english' ? 'gallon' : 'liter';
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(5.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textGrey,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget _subUnitToggle(String value, String label) {
    final isSelected = selectedSubUnit == value;

    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => selectedSubUnit = value),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(5.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textGrey,
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAllUnitColumns() {
    switch (selectedSubUnit) {
      case 'gallon':
        return _unitColumn(
          title: 'Gallon',
          isExpanded: true,
          children: [
            Row(
              children: [
                SvgPicture.asset('assets/logos/calculate.svg', height: 20.h),
                SizedBox(width: 8.w),
                Text(
                  'Start Measuring',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                SvgPicture.asset('assets/logos/bottle.svg', height: 18.h),
                SizedBox(width: 8.w),
                Text(
                  'Number of Bottles',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.h),
            LightInputField(),
            SizedBox(height: 26.h),
            Row(
              children: [
                SvgPicture.asset('assets/logos/aid.svg', height: 18.h),
                SizedBox(width: 8.w),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Hospital Milk',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextSpan(
                        text: ' (GALLON)',
                        style: TextStyle(
                          color: Color(0xFFE53935),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 7.h),
            LightInputField(),
            SizedBox(height: 24.h),
            Divider(color: AppColors.lightGrey, thickness: 1.h, height: 1.h),
            SizedBox(height: 14.h),
            GestureDetector(
              onTap: () {
                setState(() {
                  isSolidsExpanded = !isSolidsExpanded;
                });
              },
              child: Row(
                children: [
                  Text(
                    'Solids',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    isSolidsExpanded
                        ? 'assets/logos/up.svg'
                        : 'assets/logos/down.svg',
                    height: 24.h,
                  ),
                ],
              ),
            ),
            if (isSolidsExpanded) ...[
              SizedBox(height: 10.h),

              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/logos/bottleGreen.svg',
                        height: 18.h,
                      ),
                      SizedBox(width: 8.w),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Bottle Size',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            TextSpan(
                              text: ' (GALLON)',
                              style: TextStyle(
                                color: Color(0xFF36C275),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  LightInputField(),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/logos/bottleMed.svg',
                        height: 20.h,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Solids in Hospital Milk (%)',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  LightInputField(),
                  SizedBox(height: 24.h),
                  Row(
                    children: [
                      SvgPicture.asset('assets/logos/drop.svg', height: 20.h),
                      SizedBox(width: 8.w),
                      Text(
                        'Desired Solid (11-16%)',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 7.h),
                  LightInputField(),
                ],
              ),
            ],
          ],
        );
      case 'pounds':
        return _unitColumn(title: 'Pounds', isExpanded: true, children: []);
      case 'liter':
        return _unitColumn(title: 'Liter', isExpanded: true, children: []);
      case 'kilo':
        return _unitColumn(title: 'Kilo', isExpanded: true, children: []);
      default:
        return SizedBox.shrink();
    }
  }

  Widget _unitColumn({
    required String title,
    required bool isExpanded,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
          ),
          if (isExpanded) ...[SizedBox(height: 10.h), ...children],
        ],
      ),
    );
  }
}
