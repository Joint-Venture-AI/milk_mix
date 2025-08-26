// lib/view/screen/calculate_screen.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/data_source/api_service.dart';
import 'package:milk_mix/model/create_history.dart';
import 'package:milk_mix/view/home/calculate/mesurement_unit_widget.dart';
import 'package:milk_mix/view/home/calculate/mesurement_units.dart';
import 'package:milk_mix/view/home/calculate/mix_calculation_service.dart';
import 'package:milk_mix/view/home/calculate/recipe_summery_widget.dart';
import 'package:milk_mix/view/home/calculate/save_measurement_service.dart';
import 'package:milk_mix/view/home/calculate/start_mixing_widget.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  Timer? _debounce;
  final ApiService apiService = ApiService();

  MeasurementSystem measurementSystem = MeasurementSystem.imperial;
  dynamic selectedUnit = ImperialUnit.gallon;

  // Controllers for input fields
  final TextEditingController _numBottlesController = TextEditingController();
  final TextEditingController _hospitalMilkController = TextEditingController();
  final TextEditingController _bottleSizeController = TextEditingController();
  final TextEditingController _hospitalMilkSolidsController =
      TextEditingController();
  final TextEditingController _desiredSolidsController =
      TextEditingController();

  // Recipe summary variables
  CalculationResult calculationResult = CalculationResult(
    waterAmount: 0,
    milkReplacerAmount: 0,
    hospitalMilkAmount: 0,
    totalVolume: 0,
  );

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

    _loadMeasurementPreference();
  }

  void _loadMeasurementPreference() async {
    final SaveMeasurementService saveMeasurementService =
        SaveMeasurementService();

    measurementSystem = await saveMeasurementService.loadMeasurementSystem();
    final ImperialUnit imperialUnit =
        await saveMeasurementService.loadImperialUnit();
    final MetricUnit metricUnit = await saveMeasurementService.loadMetricUnit();

    if (measurementSystem == MeasurementSystem.imperial) {
      selectedUnit = imperialUnit;
    } else if (measurementSystem == MeasurementSystem.metric) {
      selectedUnit = metricUnit;
    }
    setState(() {});
    _calculateRecipe();
  }

  void _saveMeasurementSystem(String system) async {
    final SaveMeasurementService saveMeasurementService =
        SaveMeasurementService();
    if (system == MeasurementSystem.imperial.name) {
      await saveMeasurementService.saveImperialUnit(selectedUnit);
    } else if (system == MeasurementSystem.metric.name) {
      await saveMeasurementService.saveMetricUnit(selectedUnit);
    }
    await saveMeasurementService.saveMeasurementSystem(measurementSystem);
  }

  @override
  void dispose() {
    _debounce?.cancel();
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

      calculationResult = MixCalculationService.calculateRecipe(
        numberOfBottles: numBottles.toInt(),
        hospitalMilk: hospitalMilk,
        bottleSize: bottleSize,
        hospitalMilkSolids: hospitalMilkSolids,
        desiredSolids: desiredSolids,
        measurementSystem: measurementSystem,
        selectedUnit: selectedUnit,
      );
    });

    // Cancel previous timer if still running
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new debounce timer
    _debounce = Timer(const Duration(milliseconds: 1600), () {
      _postCalculationResults();
    });
  }

  Future<void> _postCalculationResults() async {
    if (calculationResult.totalVolume == 0) return;

    final result = await apiService.milkHistory.createMilkHistory(
      createHistory: CreateHistory(
        numberOfBottles: int.tryParse(_numBottlesController.text),
        hospitalMilkVolume: double.tryParse(_hospitalMilkController.text),
        //
        bottleSize: double.tryParse(_bottleSizeController.text),
        hospitalSolids: double.tryParse(_hospitalMilkSolidsController.text),
        desiredSolidsContent: double.tryParse(_desiredSolidsController.text),
        //
        poundsOfWater: calculationResult.waterAmount,
        poundsOfMilkReplacer: calculationResult.milkReplacerAmount,
        //
        solidsHospitalMilk:
            calculationResult.waterAmount +
            calculationResult.milkReplacerAmount,
        //
        hospitalMilkUsed: calculationResult.hospitalMilkAmount,
        totalVolume:
            calculationResult.totalVolume.toStringAsFixed(0) +
            (measurementSystem == MeasurementSystem.imperial ? ' lbs' : ' kg'),
      ),
    );

    if (result.isSuccess) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Calculation successful!')));
    }
  }

  void _handleUnitChange(MeasurementSystem newSystem, dynamic newUnit) {
    setState(() {
      measurementSystem = newSystem;
      selectedUnit = newUnit;
      _saveMeasurementSystem(measurementSystem.name);
      _calculateRecipe();
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
              _buildAdPlaceholder(),
              SizedBox(height: 14.h),
              StartMixingWidget(
                numBottlesController: _numBottlesController,
                hospitalMilkController: _hospitalMilkController,
                bottleSizeController: _bottleSizeController,
                hospitalMilkSolidsController: _hospitalMilkSolidsController,
                desiredSolidsController: _desiredSolidsController,
                measurementSystem: measurementSystem,
                selectedUnit: selectedUnit,
                onCalculate: _calculateRecipe,
              ),
              SizedBox(height: 14.h),
              RecipeSummaryWidget(
                calculationResult: calculationResult,
                measurementSystem: measurementSystem,
                selectedUnit: selectedUnit,
              ),
              SizedBox(height: 14.h),
              MeasurementUnitWidget(
                measurementSystem: measurementSystem,
                selectedUnit: selectedUnit,
                onUnitChanged: _handleUnitChange,
              ),
              SizedBox(height: 12.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAdPlaceholder() {
    return SizedBox(
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
    );
  }
}
