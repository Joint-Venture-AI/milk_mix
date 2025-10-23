import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/home/calculate/mesurement_units.dart';
import 'package:milk_mix/view/widget/light_text_input_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StartMixingWidget extends StatefulWidget {
  final TextEditingController numBottlesController;
  final TextEditingController hospitalMilkController;
  final TextEditingController bottleSizeController;
  final TextEditingController hospitalMilkSolidsController;
  final TextEditingController desiredSolidsController;
  final MeasurementSystem measurementSystem;
  final dynamic selectedUnit;
  final VoidCallback onCalculate;
  // final VoidCallback onSaveCalculation;
  // final fieldsSaver;

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
    // required this.onSaveCalculation,
    // this.fieldsSaver,
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
    widget.desiredSolidsController.addListener(_validateDesiredSolids);
    _loadSavedFields();
    //  onPressed: () async {
    // await _saveFieldsToPrefs();
    // widget.onSaveCalculation();
    // },
  }

  Future<void> _loadSavedFields() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      widget.numBottlesController.text =
          prefs.getString('num_bottles') ?? widget.numBottlesController.text;
      widget.hospitalMilkController.text =
          prefs.getString('hospital_milk') ??
          widget.hospitalMilkController.text;
      widget.bottleSizeController.text =
          prefs.getString('bottle_size') ?? widget.bottleSizeController.text;
      widget.hospitalMilkSolidsController.text =
          prefs.getString('hospital_milk_solids') ??
          widget.hospitalMilkSolidsController.text;
      widget.desiredSolidsController.text =
          prefs.getString('desired_solids') ??
          widget.desiredSolidsController.text;
      isSolidsExpanded = prefs.getBool('solid_expand') ?? false;
    });
  }

  Future<void> _saveFieldsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('num_bottles', widget.numBottlesController.text);
    await prefs.setString('hospital_milk', widget.hospitalMilkController.text);
    await prefs.setString('bottle_size', widget.bottleSizeController.text);
    await prefs.setString(
      'hospital_milk_solids',
      widget.hospitalMilkSolidsController.text,
    );
    await prefs.setString(
      'desired_solids',
      widget.desiredSolidsController.text,
    );
  }

  @override
  void dispose() {
    widget.desiredSolidsController.removeListener(_validateDesiredSolids);
    super.dispose();
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
          // SizedBox(height: 12.h),
          // ElevatedButton(
          //   onPressed: () async {
          //     await _saveFieldsToPrefs();
          //     widget.onSaveCalculation();
          //   },
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: AppColors.primary,
          //     elevation: 0,
          //     shape: RoundedRectangleBorder(
          //       borderRadius: BorderRadius.circular(8.r),
          //     ),
          //     padding: EdgeInsets.symmetric(vertical: 10.h),
          //   ),
          //   child: Text(
          //     'Save Calculation',
          //     style: TextStyle(
          //       color: Colors.white,
          //       fontSize: 15.sp,
          //       fontWeight: FontWeight.w600,
          //     ),
          //   ),
          // ),
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
          onChanged: (_) => widget.onCalculate(),
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
          onChanged: (_) => widget.onCalculate(),
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
          onTap: () async {
            setState(() {
              isSolidsExpanded = !isSolidsExpanded;
            });
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('solid_expand', isSolidsExpanded);
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
          SizedBox(height: 12.h),
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
          onChanged: (_) => widget.onCalculate(),
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
          onChanged: (_) => widget.onCalculate(),
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
          onChanged: (_) => widget.onCalculate(),
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
