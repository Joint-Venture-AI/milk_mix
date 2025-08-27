// lib/view/widget/start_mixing_widget.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/home/calculate/mesurement_units.dart';
import 'package:milk_mix/view/widget/light_text_input_widget.dart';

class StartMixingWidget extends StatefulWidget {
  final TextEditingController numBottlesController;
  final TextEditingController hospitalMilkController;
  final TextEditingController bottleSizeController;
  final TextEditingController hospitalMilkSolidsController;
  final TextEditingController desiredSolidsController;
  final MeasurementSystem measurementSystem;
  final dynamic selectedUnit;
  final VoidCallback onCalculate;

  const StartMixingWidget({
    super.key,
    required this.numBottlesController,
    required this.hospitalMilkController,
    required this.bottleSizeController,
    required this.hospitalMilkSolidsController,
    required this.desiredSolidsController,
    required this.measurementSystem,
    required this.selectedUnit,
    required this.onCalculate,
  });

  @override
  State<StartMixingWidget> createState() => _StartMixingWidgetState();
}

class _StartMixingWidgetState extends State<StartMixingWidget> {
  bool isSolidsExpanded = false;

  // Validation state for each field
  String? numBottlesError;
  String? hospitalMilkError;
  String? bottleSizeError;
  String? hospitalMilkSolidsError;
  String? desiredSolidsError;

  @override
  void initState() {
    super.initState();
    // Add listeners to controllers for real-time validation
    // widget.numBottlesController.addListener(_validateNumBottles);
    // widget.hospitalMilkController.addListener(_validateHospitalMilk);
    // widget.bottleSizeController.addListener(_validateBottleSize);
    // widget.hospitalMilkSolidsController.addListener(
    //   _validateHospitalMilkSolids,
    // );
    widget.desiredSolidsController.addListener(_validateDesiredSolids);
  }

  @override
  void dispose() {
    // Remove listeners
    // widget.numBottlesController.removeListener(_validateNumBottles);
    // widget.hospitalMilkController.removeListener(_validateHospitalMilk);
    // widget.bottleSizeController.removeListener(_validateBottleSize);
    // widget.hospitalMilkSolidsController.removeListener(
    //   _validateHospitalMilkSolids,
    // );
    widget.desiredSolidsController.removeListener(_validateDesiredSolids);
    super.dispose();
  }

  // Validation methods
  void _validateNumBottles() {
    setState(() {
      final value = widget.numBottlesController.text;
      if (value.isEmpty) {
        numBottlesError = null; // Allow empty for optional fields
      } else {
        final numValue = int.tryParse(value);
        if (numValue == null) {
          numBottlesError = 'Please enter a valid number';
        } else if (numValue <= 0) {
          numBottlesError = 'Number of bottles must be greater than 0';
        } else if (numValue > 1000) {
          numBottlesError = 'Number seems too high (max 1000)';
        } else {
          numBottlesError = null;
        }
      }
    });
  }

  void _validateHospitalMilk() {
    setState(() {
      final value = widget.hospitalMilkController.text;
      if (value.isEmpty) {
        hospitalMilkError = null;
      } else {
        final numValue = double.tryParse(value);
        if (numValue == null) {
          hospitalMilkError = 'Please enter a valid number';
        } else if (numValue <= 0) {
          hospitalMilkError = 'Hospital milk amount must be greater than 0';
        } else if (numValue > 10000) {
          hospitalMilkError = 'Amount seems too high';
        } else {
          hospitalMilkError = null;
        }
      }
    });
  }

  void _validateBottleSize() {
    setState(() {
      final value = widget.bottleSizeController.text;
      if (value.isEmpty) {
        bottleSizeError = null;
      } else {
        final numValue = double.tryParse(value);
        if (numValue == null) {
          bottleSizeError = 'Please enter a valid number';
        } else if (numValue <= 0) {
          bottleSizeError = 'Bottle size must be greater than 0';
        } else if (numValue > 100) {
          bottleSizeError = 'Bottle size seems too large';
        } else {
          bottleSizeError = null;
        }
      }
    });
  }

  void _validateHospitalMilkSolids() {
    setState(() {
      final value = widget.hospitalMilkSolidsController.text;
      if (value.isEmpty) {
        hospitalMilkSolidsError = null;
      } else {
        final numValue = double.tryParse(value);
        if (numValue == null) {
          hospitalMilkSolidsError = 'Please enter a valid percentage';
        } else if (numValue < 0) {
          hospitalMilkSolidsError = 'Percentage cannot be negative';
        } else if (numValue > 100) {
          hospitalMilkSolidsError = 'Percentage cannot exceed 100%';
        } else {
          hospitalMilkSolidsError = null;
        }
      }
    });
  }

  void _validateDesiredSolids() {
    setState(() {
      final value = widget.desiredSolidsController.text;
      if (value.isEmpty) {
        desiredSolidsError = null;
      } else {
        final numValue = double.tryParse(value);
        if (numValue == null) {
          desiredSolidsError = 'Please enter a valid percentage';
        } else if (numValue == 0) {
          desiredSolidsError = null;
        } else if (numValue < 11) {
          desiredSolidsError = 'Percentage cannot be less than 11%';
        } else if (numValue > 16) {
          desiredSolidsError = 'Percentage cannot exceed 16%';
        } else {
          desiredSolidsError = null;
        }
      }
    });
  }

  // Helper method to get input formatters for numeric fields
  List<TextInputFormatter> _getNumericFormatters({
    bool allowDecimals = true,
    int? maxLength,
  }) {
    List<TextInputFormatter> formatters = [];

    if (allowDecimals) {
      formatters.add(FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')));
    } else {
      formatters.add(FilteringTextInputFormatter.digitsOnly);
    }

    if (maxLength != null) {
      formatters.add(LengthLimitingTextInputFormatter(maxLength));
    }

    return formatters;
  }

  @override
  Widget build(BuildContext context) {
    final hospitalMilkUnit =
        widget.measurementSystem == MeasurementSystem.imperial
            ? (widget.selectedUnit == ImperialUnit.gallon
                ? '(Gallon)'
                : '(Pounds)')
            : (widget.selectedUnit == MetricUnit.liter ? '(Liter)' : '(Kilo)');

    final bottleSizeUnit =
        widget.measurementSystem == MeasurementSystem.imperial
            ? '(Quarts)'
            : '(Liters)';

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/logos/calculate.svg', height: 20.h),
              SizedBox(width: 8.w),
              Text(
                'startMixing'.tr,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          _buildNumberBottlesInput(),
          SizedBox(height: 26.h),
          _buildHospitalMilkInput(hospitalMilkUnit),
          SizedBox(height: 24.h),
          Divider(color: AppColors.lightGrey, thickness: 1.h, height: 1.h),
          SizedBox(height: 14.h),
          _buildSolidsSection(bottleSizeUnit),
        ],
      ),
    );
  }

  Widget _buildNumberBottlesInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/logos/bottle.svg', height: 18.h),
            SizedBox(width: 8.w),
            Text(
              'numberOfBottles'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 7.h),
        LightInputField(
          controller: widget.numBottlesController,
          keyboardType: TextInputType.number,
          // inputFormatters: _getNumericFormatters(allowDecimals: false, maxLength: 4),
          onChanged: (_) => widget.onCalculate(),
          // errorText: numBottlesError,
        ),
        if (numBottlesError != null) ...[
          SizedBox(height: 4.h),
          Text(
            numBottlesError!,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHospitalMilkInput(String hospitalMilkUnit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/logos/aid.svg', height: 18.h),
            SizedBox(width: 8.w),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'hospitalMilk'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextSpan(
                    text: ' $hospitalMilkUnit',
                    style: TextStyle(
                      color: const Color(0xFFE53935),
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
        LightInputField(
          controller: widget.hospitalMilkController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          // inputFormatters: _getNumericFormatters(allowDecimals: true, maxLength: 8),
          onChanged: (_) => widget.onCalculate(),
          // errorText: hospitalMilkError,
        ),
        if (hospitalMilkError != null) ...[
          SizedBox(height: 4.h),
          Text(
            hospitalMilkError!,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildSolidsSection(String bottleSizeUnit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isSolidsExpanded = !isSolidsExpanded;
            });
          },
          child: Row(
            children: [
              Text(
                'solids'.tr,
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
          _buildBottleSizeInput(bottleSizeUnit),
          SizedBox(height: 24.h),
          _buildHospitalMilkSolidsInput(),
          SizedBox(height: 24.h),
          _buildDesiredSolidsInput(),
        ],
      ],
    );
  }

  Widget _buildBottleSizeInput(String bottleSizeUnit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/logos/bottleGreen.svg', height: 18.h),
            SizedBox(width: 8.w),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'bottleSize'.tr,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  TextSpan(
                    text: ' $bottleSizeUnit',
                    style: TextStyle(
                      color: const Color(0xFF36C275),
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
        LightInputField(
          controller: widget.bottleSizeController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          // inputFormatters: _getNumericFormatters(allowDecimals: true, maxLength: 6),
          onChanged: (_) => widget.onCalculate(),
          // errorText: bottleSizeError,
        ),
        if (bottleSizeError != null) ...[
          SizedBox(height: 4.h),
          Text(
            bottleSizeError!,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildHospitalMilkSolidsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/logos/bottleMed.svg', height: 20.h),
            SizedBox(width: 8.w),
            Text(
              'solidsInHospitalMilk'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 7.h),
        LightInputField(
          controller: widget.hospitalMilkSolidsController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          // inputFormatters: _getNumericFormatters(allowDecimals: true, maxLength: 5),
          onChanged: (_) => widget.onCalculate(),
          // errorText: hospitalMilkSolidsError,
          // suffixText: '%',
        ),
        if (hospitalMilkSolidsError != null) ...[
          SizedBox(height: 4.h),
          Text(
            hospitalMilkSolidsError!,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildDesiredSolidsInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/logos/drop.svg', height: 20.h),
            SizedBox(width: 8.w),
            Text(
              'desiredSolid'.tr,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
        SizedBox(height: 7.h),
        LightInputField(
          controller: widget.desiredSolidsController,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          // inputFormatters: _getNumericFormatters(allowDecimals: true, maxLength: 5),
          onChanged: (_) => widget.onCalculate(),
          // errorText: desiredSolidsError,
          // suffixText: '%',
        ),
        if (desiredSolidsError != null) ...[
          SizedBox(height: 4.h),
          Text(
            desiredSolidsError!,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ],
    );
  }
}
