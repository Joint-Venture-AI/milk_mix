// lib/view/screen/calculate_screen.dart
import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/constants/app_constant.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/model/create_history.dart';
import 'package:milk_mix/view/home/calculate/mesurement_unit_widget.dart';
import 'package:milk_mix/view/home/calculate/mesurement_units.dart';
import 'package:milk_mix/view/home/calculate/mix_calculation_service.dart';
import 'package:milk_mix/view/home/calculate/recipe_summery_widget.dart';
import 'package:milk_mix/view/home/calculate/save_measurement_service.dart';
import 'package:milk_mix/view/home/calculate/start_mixing_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class CalculateScreen extends StatefulWidget {
  const CalculateScreen({super.key});

  @override
  State<CalculateScreen> createState() => _CalculateScreenState();
}

class _CalculateScreenState extends State<CalculateScreen> {
  // Timer? _debounce;
  final ApiProvider apiService = ApiProvider();

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
    // _debounce?.cancel();
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
    // if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new debounce timer
    // // TODO remove auto save
    // _debounce = Timer(const Duration(milliseconds: 1600), () {
    //   _postCalculationResults();
    // });
  }

  Future<void> _postCalculationResults() async {
    if (calculationResult.totalVolume == 0) return;
    String? unit;
    if (selectedUnit is ImperialUnit) {
      unit = (selectedUnit as ImperialUnit).name;
    } else if (selectedUnit is MetricUnit) {
      unit = (selectedUnit as MetricUnit).name;
    }
    final result = await apiService.milkHistory.createMilkHistory(
      createHistory: CreateHistory(
        numberOfBottles: int.tryParse(_numBottlesController.text),
        hospitalMilkVolume: double.tryParse(_hospitalMilkController.text),
        //
        bottleSize: double.tryParse(_bottleSizeController.text),
        hospitalSolids: double.tryParse(_hospitalMilkSolidsController.text),
        desiredSolidsContent: double.tryParse(_desiredSolidsController.text),
        //
        poundsOfWater: double.parse(
          calculationResult.waterAmount.toStringAsFixed(2),
        ),
        poundsOfMilkReplacer: double.parse(
          calculationResult.milkReplacerAmount.toStringAsFixed(2),
        ),
        //
        solidsHospitalMilk: double.parse(
          (calculationResult.waterAmount + calculationResult.milkReplacerAmount)
              .toStringAsFixed(2),
        ),
        //
        hospitalMilkUsed: double.parse(
          calculationResult.hospitalMilkAmount.toStringAsFixed(2),
        ),
        totalVolume:
            calculationResult.totalVolume.toStringAsFixed(0) +
            (measurementSystem == MeasurementSystem.imperial ? ' lbs' : ' kg'),
        unit: unit,
      ),
    );

    if (result.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Calculation saved successfully!')),
      );
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
              // _buildAdPlaceholder(),
              const AutoScrollAdBanner(),
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
                // onSaveCalculation: _postCalculationResults,
              ),
              SizedBox(height: 14.h),
              RecipeSummaryWidget(
                calculationResult: calculationResult,
                measurementSystem: measurementSystem,
                selectedUnit: selectedUnit,
                onSave: () {
                  _postCalculationResults();
                  _saveFieldsToPrefs();
                },
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

  Future<void> _saveFieldsToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('num_bottles', _numBottlesController.text);
    await prefs.setString('hospital_milk', _hospitalMilkController.text);
    await prefs.setString('bottle_size', _bottleSizeController.text);
    await prefs.setString(
      'hospital_milk_solids',
      _hospitalMilkSolidsController.text,
    );
    await prefs.setString('desired_solids', _desiredSolidsController.text);
  }
}

class AutoScrollAdBanner extends StatefulWidget {
  const AutoScrollAdBanner({super.key});

  @override
  State<AutoScrollAdBanner> createState() => _AutoScrollAdBannerState();
}

class _AutoScrollAdBannerState extends State<AutoScrollAdBanner> {
  static const _loopCount = 10000;
  final PageController _pageController = PageController();
  Timer? _timer;
  bool _initialized = false;

  void _startAutoScroll(int itemCount) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 10), (_) {
      if (!mounted) return;
      final nextPage = _pageController.page!.toInt() + 1;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      // Reset near the end, silently
      if (nextPage > _loopCount - 2000) {
        final middle = _loopCount ~/ 2;
        _pageController.jumpToPage(middle);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiProvider.instance.advertisements.getAllAds(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SizedBox.shrink();

        final ads = (snapshot.data?.data ?? []).reversed.toList();
        if (ads.isEmpty) return const SizedBox.shrink();

        if (!_initialized) {
          _initialized = true;

          final randomStart =
              (_loopCount ~/ 2) +
              Random().nextInt(ads.length); // random circular point

          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (!mounted) return;
            _pageController.jumpToPage(randomStart);
            _startAutoScroll(ads.length);
          });
        }

        return SizedBox(
          height: 150.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _loopCount,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final actualIndex = index % ads.length;
              final ad = ads[actualIndex];
              return GestureDetector(
                onTap: () {
                  if (ad.externalLink != null && ad.externalLink!.isNotEmpty) {
                    launchUrl(Uri.parse(ad.externalLink!));
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGrey, width: 1.r),
                    borderRadius: BorderRadius.circular(10.r),
                    image: DecorationImage(
                      image: NetworkImage(
                        AppConstant.baseUrl + (ad.image ?? ''),
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
