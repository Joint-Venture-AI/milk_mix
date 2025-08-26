import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/home/calculate/mesurement_units.dart';
import 'package:milk_mix/view/home/calculate/save_measurement_service.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

//api-done:update measurement system
class EditMeasurementScreen extends StatefulWidget {
  const EditMeasurementScreen({super.key});

  @override
  _EditMeasurementScreenState createState() => _EditMeasurementScreenState();
}

class _EditMeasurementScreenState extends State<EditMeasurementScreen> {
  MeasurementSystem? _selectedSystem;

  @override
  void initState() {
    super.initState();
    _loadMeasurementSystem();
  }

  // Load saved measurement system from SharedPreferences
  Future<void> _loadMeasurementSystem() async {
    final service = SaveMeasurementService();
    final savedSystem = await service.loadMeasurementSystem();
    setState(() {
      _selectedSystem = savedSystem;
    });
  }

  // Save measurement system to SharedPreferences
  Future<void> _saveMeasurementSystem(MeasurementSystem system) async {
    final service = SaveMeasurementService();
    await service.saveMeasurementSystem(system);
  }

  // Update measurement system and save to SharedPreferences
  void _updateMeasurementSystem(MeasurementSystem system) {
    setState(() {
      _selectedSystem = system;
    });
    _saveMeasurementSystem(system);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBarWidget(),
              SizedBox(height: 12.h),
              Text(
                textAlign: TextAlign.start,
                'changeMeasurementSystem'.tr,
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 24.h),

              GestureDetector(
                onTap: () {
                  _updateMeasurementSystem(MeasurementSystem.imperial);
                },
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color:
                          _selectedSystem == MeasurementSystem.imperial
                              ? AppColors.primary
                              : AppColors.lightGrey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset('assets/flags/us.png', width: 26.w),
                          SizedBox(width: 14.w),
                          Text(
                            'English Standard',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color.fromARGB(255, 18, 37, 63),
                            ),
                          ),
                          Spacer(),
                          Icon(
                            _selectedSystem == MeasurementSystem.imperial
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color:
                                _selectedSystem == MeasurementSystem.imperial
                                    ? AppColors.primary
                                    : Colors.grey,
                            size: 24.w,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.only(left: 40.w),
                        child: Text(
                          'Imperial',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 12.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.shade,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weight',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.textGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Pounds (Lbs)',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 24.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 12.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.shade,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Volume',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  Text(
                                    'Gallons (gal)',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Common in: USA, UK (partial)',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              GestureDetector(
                onTap: () {
                  _updateMeasurementSystem(MeasurementSystem.metric);
                },
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color:
                          _selectedSystem == MeasurementSystem.metric
                              ? AppColors.primary
                              : AppColors.lightGrey,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            'assets/logos/earth.svg',
                            width: 26.w,
                          ),
                          SizedBox(width: 14.w),
                          Text(
                            'Metric System',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            _selectedSystem == MeasurementSystem.metric
                                ? Icons.check_circle
                                : Icons.radio_button_unchecked,
                            color:
                                _selectedSystem == MeasurementSystem.metric
                                    ? AppColors.primary
                                    : Colors.grey,
                            size: 24.w,
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Padding(
                        padding: EdgeInsets.only(left: 40.w),
                        child: Text(
                          'SI Units',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 12.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.shade,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Weight',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.textGrey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    'Kilogram (kg)',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 24.w),
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 8.h,
                                horizontal: 12.w,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.shade,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Volume',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textGrey,
                                    ),
                                  ),
                                  Text(
                                    'Liters (L)',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Common in: EU, Canada, Australia',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 120.h),
              Row(
                children: [
                  Expanded(
                    child: TextButtonWidgetLight(
                      text: 'Cancel',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: TextWidgetButton(
                      text: 'Update',
                      onPressed: () {
                        if (_selectedSystem != null) {
                          Get.snackbar(
                            'Success',
                            'Measurement system updated successfully',
                            backgroundColor: AppColors.primary,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                          Get.back();
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please select a measurement system',
                            backgroundColor: Colors.red,
                            colorText: Colors.white,
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
