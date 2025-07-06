import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/constants/color.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  String selectedUnit = 'english';
  String selectedSubUnit = 'gallon';
  bool isDropdownExpanded = false;

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

              // Ads container
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

              // Dropdown header
              GestureDetector(
                onTap: () {
                  setState(() {
                    isDropdownExpanded = !isDropdownExpanded;
                  });
                },
                child: Container(
                  height: 45.h,
                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                  decoration: BoxDecoration(
                    color: AppColors.shade,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Measurement Unit',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textGrey,
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            _getSelectedUnitLabel(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            isDropdownExpanded
                                ? Icons.arrow_drop_up
                                : Icons.arrow_drop_down,
                            color: AppColors.textGrey,
                            size: 24.sp,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              if (isDropdownExpanded) ...[
                SizedBox(height: 8.h),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.shade,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(color: AppColors.lightGrey),
                  ),
                  child: Column(
                    children: [
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
                  ),
                ),
              ],

              SizedBox(height: 20.h),

              // Only selected unit column shown
              buildAllUnitColumns(),
            ],
          ),
        ),
      ),
    );
  }

  // Label for dropdown
  String _getSelectedUnitLabel() {
    if (selectedUnit == 'english') {
      return selectedSubUnit == 'gallon'
          ? 'English - Gallon'
          : 'English - Pounds';
    } else {
      return selectedSubUnit == 'liter' ? 'Metric - Liter' : 'Metric - Kilo';
    }
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

  // Sub unit selector (gallon, pounds, liter, kilo)
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

  // Show only selected unit column
  Widget buildAllUnitColumns() {
    switch (selectedSubUnit) {
      case 'gallon':
        return _unitColumn(
          title: 'Gallon',

          isExpanded: true,
          children: [
            Text('Input for Gallon'),
            SizedBox(height: 8.h),
            TextField(
              decoration: InputDecoration(hintText: 'Enter gallon amount'),
            ),
          ],
        );
      case 'pounds':
        return _unitColumn(
          title: 'Pounds',

          isExpanded: true,
          children: [
            Text('Input for Pounds'),
            SizedBox(height: 8.h),
            TextField(decoration: InputDecoration(hintText: 'Enter pounds')),
          ],
        );
      case 'liter':
        return _unitColumn(
          title: 'Liter',

          isExpanded: true,
          children: [Text('Input for Liter')],
        );
      case 'kilo':
        return _unitColumn(
          title: 'Kilo',

          isExpanded: true,
          children: [
            Text('Input for Kilo'),
            SizedBox(height: 8.h),
            TextField(
              decoration: InputDecoration(hintText: 'Enter kilo weight'),
            ),
          ],
        );
      default:
        return SizedBox.shrink();
    }
  }

  // Unit block builder
  Widget _unitColumn({
    required String title,

    required bool isExpanded,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 14.h),
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.r)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
