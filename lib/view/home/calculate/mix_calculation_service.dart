// lib/services/mix_calculation_service.dart
import 'package:milk_mix/view/home/calculate/mesurement_units.dart';

class MixCalculationService {
  static CalculationResult calculateRecipe({
    required int numberOfBottles,
    required double hospitalMilk,
    required double bottleSize,
    required double hospitalMilkSolids,
    required double desiredSolids,
    required MeasurementSystem measurementSystem,
    required dynamic selectedUnit,
  }) {
    // Ensure non-negative inputs
    numberOfBottles = numberOfBottles < 0 ? 0 : numberOfBottles;
    hospitalMilk = hospitalMilk < 0 ? 0 : hospitalMilk;
    bottleSize = bottleSize < 0 ? 0 : bottleSize;
    hospitalMilkSolids = hospitalMilkSolids < 0 ? 0 : hospitalMilkSolids;
    desiredSolids = desiredSolids < 0 ? 0 : desiredSolids;

    double waterAmount = 0;
    double milkReplacerAmount = 0;
    double hospitalMilkAmount = 0;
    double totalVolume = 0;

    CalculationResult result = CalculationResult(
      waterAmount: 0,
      milkReplacerAmount: 0,
      hospitalMilkAmount: 0,
      totalVolume: 0,
    );

    if (measurementSystem == MeasurementSystem.imperial) {
      final unit = selectedUnit as ImperialUnit;

      if (unit == ImperialUnit.gallon) {
        result = calculateImperialGallons(
          numberOfBottles: numberOfBottles,
          bottleSizeQuarts: bottleSize,
          solidsHospitalMilk: hospitalMilkSolids,
          desiredSolid: desiredSolids,
          hospitalMilkGallons: hospitalMilk,
        );
      } else {
        result = calculateImperialPounds(
          numberOfBottles: numberOfBottles,
          bottleSizeQuarts: bottleSize,
          solidsHospitalMilk: hospitalMilkSolids,
          desiredSolid: desiredSolids,
          hospitalMilkPounds: hospitalMilk,
        );
      }
    } else {
      final unit = selectedUnit as MetricUnit;

      if (unit == MetricUnit.liter) {
        result = calculateMetricLiters(
          numberOfBottles: numberOfBottles,
          bottleSizeLiters: bottleSize,
          solidsHospitalMilk: hospitalMilkSolids,
          desiredSolid: desiredSolids,
          hospitalMilkLiters: hospitalMilk,
        );
      } else {
        result = calculateMetricKG(
          numberOfBottles: numberOfBottles,
          bottleSizeLiters: bottleSize,
          solidsHospitalMilk: hospitalMilkSolids,
          desiredSolid: desiredSolids,
          hospitalMilkKg: hospitalMilk,
        );
      }
    }

    //
    waterAmount = result.waterAmount;
    milkReplacerAmount = result.milkReplacerAmount;
    hospitalMilkAmount = result.hospitalMilkAmount;
    totalVolume = result.totalVolume;

    // Ensure non-negative results
    waterAmount = waterAmount < 0 ? 0 : waterAmount;
    milkReplacerAmount = milkReplacerAmount < 0 ? 0 : milkReplacerAmount;
    hospitalMilkAmount = hospitalMilkAmount < 0 ? 0 : hospitalMilkAmount;
    totalVolume = totalVolume < 0 ? 0 : totalVolume;

    return CalculationResult(
      waterAmount: waterAmount,
      milkReplacerAmount: milkReplacerAmount,
      hospitalMilkAmount: hospitalMilkAmount,
      totalVolume: totalVolume,
    );
  }

  static CalculationResult calculateMetricKG({
    required int numberOfBottles,
    required double bottleSizeLiters,
    required double solidsHospitalMilk,
    required double desiredSolid,
    required double hospitalMilkKg,
  }) {
    // Convert hospital milk to liters (1 kg = 1.032 liters for milk)
    final double hospitalMilkLiters = hospitalMilkKg / 1.032;

    // Total volume in liters
    final double totalVolumeLiters = numberOfBottles * bottleSizeLiters;

    // Approximate total weight
    final double totalWeightKg = totalVolumeLiters * 1.032;

    // Hospital milk solids in kg
    final double kgSolidsHospitalMilk =
        (hospitalMilkKg * solidsHospitalMilk) / 100;

    // Total desired solids in kg
    final double totalDesiredSolidsKg = (totalWeightKg * desiredSolid) / 100;

    // Liters of milk replacer mix needed
    final double litersMilkReplacerMixNeed =
        totalVolumeLiters - hospitalMilkLiters;

    // Total milk replacer solids needed in kg
    final double totalKgMilkReplacerSolidsNeed =
        totalDesiredSolidsKg - kgSolidsHospitalMilk;

    // Total kg of milk replacer mix
    final double totalKgMilkReplacerMixNeed = litersMilkReplacerMixNeed * 1.032;

    // Total water needed
    final double totalKgWaterNeed =
        totalKgMilkReplacerMixNeed - totalKgMilkReplacerSolidsNeed;

    return CalculationResult(
      waterAmount: totalKgWaterNeed,
      milkReplacerAmount: totalKgMilkReplacerSolidsNeed,
      hospitalMilkAmount: hospitalMilkKg,
      totalVolume:
          totalKgMilkReplacerSolidsNeed + totalKgWaterNeed + hospitalMilkKg,
    );
  }

  static CalculationResult calculateMetricLiters({
    required int numberOfBottles,
    required double bottleSizeLiters,
    required double solidsHospitalMilk, // %
    required double desiredSolid, // %
    required double hospitalMilkLiters, // input is liters
  }) {
    const double density = 1.032; // 1 liter milk ≈ 1.032 kg

    // Hospital milk in kg
    final double hospitalMilkKg = hospitalMilkLiters * density;

    // Hospital milk solids in kg (L12)
    final double kgSolidsHospitalMilk =
        (hospitalMilkKg * solidsHospitalMilk) / 100;

    // Total volume in liters (L17)
    final double totalVolumeLiters = numberOfBottles * bottleSizeLiters;

    // Total weight in kg
    final double totalWeightKg = totalVolumeLiters * density;

    // Total desired solids in kg (L19)
    final double totalDesiredSolidsKg = (totalWeightKg * desiredSolid) / 100;

    // Liters of milk replacer mix needed (L22)
    final double litersMilkReplacerMixNeed =
        totalVolumeLiters - hospitalMilkLiters;

    // Total milk replacer solids needed in kg (L23)
    final double totalKgMilkReplacerSolidsNeed =
        totalDesiredSolidsKg - kgSolidsHospitalMilk;

    // Total kg of milk replacer mix (L25)
    final double totalKgMilkReplacerMixNeed =
        litersMilkReplacerMixNeed * density;

    // Total water needed (L26)
    final double totalKgWaterNeed =
        totalKgMilkReplacerMixNeed - totalKgMilkReplacerSolidsNeed;

    // return {
    //   "L12 Kg Solids Hospital Milk":
    //       "${kgSolidsHospitalMilk.toStringAsFixed(2)} Kg",
    //   "L17 Total Volume Liters":
    //       "${totalVolumeLiters.toStringAsFixed(2)} Liters",
    //   "L19 Total Desired Solids Kg":
    //       "${totalDesiredSolidsKg.toStringAsFixed(2)} Kg",
    //   "L22 Liters Milk Replacer Mix Needed":
    //       "${litersMilkReplacerMixNeed.toStringAsFixed(2)} Liters",
    //   "L23 Total Kg Milk Replacer Solids Needed":
    //       "${totalKgMilkReplacerSolidsNeed.toStringAsFixed(2)} Kg",
    //   "L25 Total Kg Milk Replacer Mix Needed":
    //       "${totalKgMilkReplacerMixNeed.toStringAsFixed(2)} Kg",
    //   "Water Kg/Litres":
    //       "${totalKgWaterNeed.toStringAsFixed(2)} Kg / ${(totalKgWaterNeed / density).toStringAsFixed(2)} Litres",
    //   "Milk Replacer Kg":
    //       "${totalKgMilkReplacerSolidsNeed.toStringAsFixed(2)} Kg",
    //   "Water + Milk Replacer Kg":
    //       (totalKgMilkReplacerSolidsNeed + totalKgWaterNeed).toStringAsFixed(2),
    //   "Hospital Milk Kg": "${hospitalMilkKg.toStringAsFixed(2)} Kg",
    // };

    return CalculationResult(
      waterAmount: totalKgWaterNeed,
      milkReplacerAmount: totalKgMilkReplacerSolidsNeed,
      hospitalMilkAmount: hospitalMilkKg,
      totalVolume:
          totalKgMilkReplacerSolidsNeed + totalKgWaterNeed + hospitalMilkKg,
    );
  }

  static CalculationResult calculateImperialGallons({
    required int numberOfBottles,
    required double bottleSizeQuarts,
    required double solidsHospitalMilk, // %
    required double desiredSolid, // %
    required double hospitalMilkGallons, // input is gallons
  }) {
    const double density = 8.6; // 1 liter milk ≈ 1.032 kg

    // Hospital milk in kg
    final double hospitalMilkKg = hospitalMilkGallons * density;

    // Hospital milk solids in kg (L12)
    final double kgSolidsHospitalMilk =
        (hospitalMilkKg * solidsHospitalMilk) / 100;

    // Total volume in liters (L17)
    final double totalVolumeLiters = numberOfBottles * (bottleSizeQuarts / 4);

    // Total weight in kg
    final double totalWeightKg = totalVolumeLiters * density;

    // Total desired solids in kg (L19)
    final double totalDesiredSolidsKg = (totalWeightKg * desiredSolid) / 100;

    // Liters of milk replacer mix needed (L22)
    final double litersMilkReplacerMixNeed =
        totalVolumeLiters - hospitalMilkGallons;

    // Total milk replacer solids needed in kg (L23)
    final double totalKgMilkReplacerSolidsNeed =
        totalDesiredSolidsKg - kgSolidsHospitalMilk;

    // Total kg of milk replacer mix (L25)
    final double totalKgMilkReplacerMixNeed =
        litersMilkReplacerMixNeed * density;

    // Total water needed (L26)
    final double totalKgWaterNeed =
        totalKgMilkReplacerMixNeed - totalKgMilkReplacerSolidsNeed;

    // return {
    //   "L12 Kg Solids Hospital Milk":
    //       "${kgSolidsHospitalMilk.toStringAsFixed(2)} Kg",
    //   "L17 Total Volume Liters":
    //       "${totalVolumeLiters.toStringAsFixed(2)} Liters",
    //   "L19 Total Desired Solids Kg":
    //       "${totalDesiredSolidsKg.toStringAsFixed(2)} Kg",
    //   "L22 Liters Milk Replacer Mix Needed":
    //       "${litersMilkReplacerMixNeed.toStringAsFixed(2)} Liters",
    //   "L23 Total Kg Milk Replacer Solids Needed":
    //       "${totalKgMilkReplacerSolidsNeed.toStringAsFixed(2)} Kg",
    //   "L25 Total Kg Milk Replacer Mix Needed":
    //       "${totalKgMilkReplacerMixNeed.toStringAsFixed(2)} Kg",
    //   "Water Kg/Litres":
    //       "${totalKgWaterNeed.toStringAsFixed(2)} Kg / ${(totalKgWaterNeed / density).toStringAsFixed(2)} Litres",
    //   "Milk Replacer Kg":
    //       "${totalKgMilkReplacerSolidsNeed.toStringAsFixed(2)} Kg",
    //   "Water + Milk Replacer Kg":
    //       (totalKgMilkReplacerSolidsNeed + totalKgWaterNeed).toStringAsFixed(2),
    //   "Hospital Milk Kg": "${hospitalMilkKg.toStringAsFixed(2)} Kg",
    // };

    return CalculationResult(
      waterAmount: totalKgWaterNeed,
      milkReplacerAmount: totalKgMilkReplacerSolidsNeed,
      hospitalMilkAmount: hospitalMilkKg,
      totalVolume:
          totalKgMilkReplacerSolidsNeed + totalKgWaterNeed + hospitalMilkKg,
    );
  }

  static CalculationResult calculateImperialPounds({
    required int numberOfBottles,
    required double bottleSizeQuarts,
    required double solidsHospitalMilk, // %
    required double desiredSolid, // %
    required double hospitalMilkPounds, // input is pounds
  }) {
    final double density = 8.6; // 1 liter milk ≈ 1.032 kg
    // Convert hospital milk to liters (1 kg = 1.032 liters for milk)
    final double hospitalMilkLiters = hospitalMilkPounds / density;

    // Total volume in liters
    final double totalVolumeLiters = numberOfBottles * (bottleSizeQuarts / 4);

    // Approximate total weight
    final double totalWeightKg = totalVolumeLiters * density;

    // Hospital milk solids in kg
    final double kgSolidsHospitalMilk =
        (hospitalMilkPounds * solidsHospitalMilk) / 100;

    // Total desired solids in kg
    final double totalDesiredSolidsKg = (totalWeightKg * desiredSolid) / 100;

    // Liters of milk replacer mix needed
    final double litersMilkReplacerMixNeed =
        totalVolumeLiters - hospitalMilkLiters;

    // Total milk replacer solids needed in kg
    final double totalKgMilkReplacerSolidsNeed =
        totalDesiredSolidsKg - kgSolidsHospitalMilk;

    // Total kg of milk replacer mix
    final double totalKgMilkReplacerMixNeed =
        litersMilkReplacerMixNeed * density;

    // Total water needed
    final double totalKgWaterNeed =
        totalKgMilkReplacerMixNeed - totalKgMilkReplacerSolidsNeed;

    return CalculationResult(
      waterAmount: totalKgWaterNeed,
      milkReplacerAmount: totalKgMilkReplacerSolidsNeed,
      hospitalMilkAmount: hospitalMilkPounds,
      totalVolume:
          totalKgMilkReplacerSolidsNeed + totalKgWaterNeed + hospitalMilkPounds,
    );
  }
}

class CalculationResult {
  final double waterAmount;
  final double milkReplacerAmount;
  final double hospitalMilkAmount;
  final double totalVolume;

  CalculationResult({
    required this.waterAmount,
    required this.milkReplacerAmount,
    required this.hospitalMilkAmount,
    required this.totalVolume,
  });
}
