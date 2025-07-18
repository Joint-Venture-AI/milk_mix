import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
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
  bool isSolidsExpanded = false;

  // Controllers for input fields
  final TextEditingController _numBottlesController = TextEditingController();
  final TextEditingController _hospitalMilkController = TextEditingController();
  final TextEditingController _bottleSizeController = TextEditingController();
  final TextEditingController _hospitalMilkSolidsController =
      TextEditingController();
  final TextEditingController _desiredSolidsController =
      TextEditingController();

  // Recipe summary variables
  double waterAmount = 0;
  double milkReplacerAmount = 0;
  double hospitalMilkAmount = 0;
  double totalVolume = 0;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with 0
    _numBottlesController.text = '0';
    _hospitalMilkController.text = '0';
    _bottleSizeController.text = '0';
    _hospitalMilkSolidsController.text = '0';
    _desiredSolidsController.text = '0';

    // Add listeners to recalculate on input changes
    _numBottlesController.addListener(_calculateRecipe);
    _hospitalMilkController.addListener(_calculateRecipe);
    _bottleSizeController.addListener(_calculateRecipe);
    _hospitalMilkSolidsController.addListener(_calculateRecipe);
    _desiredSolidsController.addListener(_calculateRecipe);

    // Perform initial calculation
    _calculateRecipe();
  }

  @override
  void dispose() {
    _numBottlesController.dispose();
    _hospitalMilkController.dispose();
    _bottleSizeController.dispose();
    _hospitalMilkSolidsController.dispose();
    _desiredSolidsController.dispose();
    super.dispose();
  }

  void _calculateRecipe() {
    setState(() {
      // Parse input values with fallback to 0
      double numBottles = double.tryParse(_numBottlesController.text) ?? 0;
      double hospitalMilk = double.tryParse(_hospitalMilkController.text) ?? 0;
      double bottleSize = double.tryParse(_bottleSizeController.text) ?? 0;
      double hospitalMilkSolids =
          double.tryParse(_hospitalMilkSolidsController.text) ?? 0;
      double desiredSolids =
          double.tryParse(_desiredSolidsController.text) ?? 0;

      // Convert percentages to decimals
      hospitalMilkSolids /= 100;
      desiredSolids /= 100;

      // Ensure non-negative inputs
      numBottles = numBottles < 0 ? 0 : numBottles;
      hospitalMilk = hospitalMilk < 0 ? 0 : hospitalMilk;
      bottleSize = bottleSize < 0 ? 0 : bottleSize;
      hospitalMilkSolids = hospitalMilkSolids < 0 ? 0 : hospitalMilkSolids;
      desiredSolids = desiredSolids < 0 ? 0 : desiredSolids;

      if (selectedUnit == 'english') {
        // Imperial calculations (based on CSV Option 2, Gallons/Pounds)
        if (selectedSubUnit == 'gallon') {
          // Total volume = number of bottles * bottle size (gallons)
          totalVolume = numBottles * bottleSize;
          hospitalMilkAmount = hospitalMilk; // Gallons
          // Total desired solids (lbs) = total volume * desired solids % * density (8.6 lbs/gallon)
          double totalDesiredSolids = totalVolume * desiredSolids * 8.6;
          // Solids from hospital milk (lbs) = hospital milk * hospital milk solids % * density
          double hospitalMilkSolidsLbs =
              hospitalMilk * hospitalMilkSolids * 8.6;
          // Milk replacer solids needed (lbs) = total desired solids - hospital milk solids
          milkReplacerAmount = totalDesiredSolids - hospitalMilkSolidsLbs;
          // Water (lbs) = total volume * density - hospital milk solids - milk replacer solids
          waterAmount =
              totalVolume * 8.6 - hospitalMilkSolidsLbs - milkReplacerAmount;
        } else {
          // Pounds (using quarts for bottle size, hospital milk)
          totalVolume =
              numBottles * bottleSize / 4; // Convert quarts to gallons
          hospitalMilkAmount = hospitalMilk / 4; // Convert quarts to gallons
          double totalDesiredSolids = totalVolume * desiredSolids * 8.6;
          double hospitalMilkSolidsLbs =
              hospitalMilkAmount * hospitalMilkSolids * 8.6;
          milkReplacerAmount = totalDesiredSolids - hospitalMilkSolidsLbs;
          waterAmount =
              totalVolume * 8.6 - hospitalMilkSolidsLbs - milkReplacerAmount;
          // Convert outputs to pounds
          totalVolume *= 8.6;
          hospitalMilkAmount *= 8.6;
        }
      } else {
        // Metric calculations (based on CSV Option 2, Liters/Kg)
        if (selectedSubUnit == 'liter') {
          totalVolume = numBottles * bottleSize; // Liters
          hospitalMilkAmount = hospitalMilk; // Liters
          double totalDesiredSolids =
              totalVolume * desiredSolids * 1.03; // Density ~1.03 kg/L
          double hospitalMilkSolidsKg =
              hospitalMilk * hospitalMilkSolids * 1.03;
          milkReplacerAmount = totalDesiredSolids - hospitalMilkSolidsKg;
          waterAmount =
              totalVolume * 1.03 - hospitalMilkSolidsKg - milkReplacerAmount;
        } else {
          // Kilo (using liters for bottle size, hospital milk)
          totalVolume = numBottles * bottleSize; // Liters
          hospitalMilkAmount = hospitalMilk; // Liters
          double totalDesiredSolids = totalVolume * desiredSolids * 1.03;
          double hospitalMilkSolidsKg =
              hospitalMilkAmount * hospitalMilkSolids * 1.03;
          milkReplacerAmount = totalDesiredSolids - hospitalMilkSolidsKg;
          waterAmount =
              totalVolume * 1.03 - hospitalMilkSolidsKg - milkReplacerAmount;
          // Convert outputs to kg
          totalVolume *= 1.03;
          hospitalMilkAmount *= 1.03;
        }
      }

      // Ensure non-negative results
      waterAmount = waterAmount < 0 ? 0 : waterAmount;
      milkReplacerAmount = milkReplacerAmount < 0 ? 0 : milkReplacerAmount;
      hospitalMilkAmount = hospitalMilkAmount < 0 ? 0 : hospitalMilkAmount;
      totalVolume = totalVolume < 0 ? 0 : totalVolume;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceGrey,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
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
                            'measurementUnits'.tr,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            isDropdownExpanded
                                ? 'assets/logos/up.svg'
                                : 'assets/logos/down.svg',
                            height: 24.h,
                          ),
                        ],
                      ),
                    ),
                    if (isDropdownExpanded) ...[
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.all(5.h),
                        decoration: BoxDecoration(
                          color: AppColors.shade,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
                          children: [
                            _mainUnitToggle('english', 'English'),
                            SizedBox(width: 8.w),
                            _mainUnitToggle('metric', 'Metric'),
                          ],
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        padding: EdgeInsets.all(5.h),
                        decoration: BoxDecoration(
                          color: AppColors.shade,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Row(
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
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              buildAllUnitColumns(),
              //--------------summary section----------------
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.lightGrey, width: 1.r),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  children: [
                    Row(
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
                        SvgPicture.asset('assets/logos/copy.svg', height: 20.h),
                      ],
                    ),
                    SizedBox(height: 18.h),
                    Container(
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
                            '= ${waterAmount.toStringAsFixed(2)} (${selectedUnit == 'english' ? 'lbs' : 'kg'})',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Container(
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
                            '= ${milkReplacerAmount.toStringAsFixed(2)} (${selectedUnit == 'english' ? 'lbs' : 'kg'})',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Container(
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
                            '= ${(waterAmount + milkReplacerAmount).toStringAsFixed(2)} (${selectedUnit == 'english' ? 'lbs' : 'kg'})',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 18.h),
                    Container(
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
                            '= ${hospitalMilkAmount.toStringAsFixed(2)} (${selectedUnit == 'english'
                                ? selectedSubUnit == 'gallon'
                                    ? 'gal'
                                    : 'lbs'
                                : selectedSubUnit == 'liter'
                                ? 'L'
                                : 'kg'})',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Divider(
                      color: AppColors.lightGrey,
                      thickness: 1.h,
                      height: 6.h,
                    ),
                    SizedBox(height: 10.h),
                    Row(
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
                          '= ${totalVolume.toStringAsFixed(2)} (${selectedUnit == 'english'
                              ? selectedSubUnit == 'gallon'
                                  ? 'gal'
                                  : 'lbs'
                              : selectedSubUnit == 'liter'
                              ? 'L'
                              : 'kg'})',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
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
            _calculateRecipe();
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(5.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textGrey,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
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
        onTap: () {
          setState(() {
            selectedSubUnit = value;
            _calculateRecipe();
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.surface : Colors.transparent,
            borderRadius: BorderRadius.circular(5.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.primary : AppColors.textGrey,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildAllUnitColumns() {
    String hospitalMilkUnit =
        selectedUnit == 'english'
            ? (selectedSubUnit == 'gallon' ? '(Gallon)' : '(Quarts)')
            : (selectedSubUnit == 'liter' ? '(Liter)' : '(Liters)');
    String bottleSizeUnit =
        selectedUnit == 'english'
            ? (selectedSubUnit == 'gallon' ? '(Gallon)' : '(Quarts)')
            : '(Liters)';

    return _unitColumn(
      isExpanded: true,
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
        LightInputField(controller: _numBottlesController),
        SizedBox(height: 26.h),
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
        LightInputField(controller: _hospitalMilkController),
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
              LightInputField(controller: _bottleSizeController),
              SizedBox(height: 24.h),
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
              LightInputField(controller: _hospitalMilkSolidsController),
              SizedBox(height: 24.h),
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
              LightInputField(controller: _desiredSolidsController),
            ],
          ),
        ],
      ],
    );
  }

  Widget _unitColumn({
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
          if (isExpanded) ...[SizedBox(height: 10.h), ...children],
        ],
      ),
    );
  }
}
