import 'package:milk_mix/view/home/calculate/mesurement_units.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveMeasurementService {
  SaveMeasurementService();
  Future<void> saveMeasurementSystem(
    MeasurementSystem measurementSystem,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('measurement_system', measurementSystem.name);
  }

  Future<MeasurementSystem> loadMeasurementSystem() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSystem = prefs.getString('measurement_system');
    if (savedSystem != null) {
      return MeasurementSystem.values.firstWhere(
        (element) => element.name == savedSystem,
      );
    }
    return MeasurementSystem.imperial;
  }

  //
  Future<void> saveImperialUnit(ImperialUnit measurementUnit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('imperial_unit', measurementUnit.name);
  }

  Future<ImperialUnit> loadImperialUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSystem = prefs.getString('imperial_unit');
    if (savedSystem != null) {
      return ImperialUnit.values.firstWhere(
        (element) => element.name == savedSystem,
      );
    }
    return ImperialUnit.gallon;
  }

  //
  Future<void> saveMetricUnit(MetricUnit measurementUnit) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('metric_unit', measurementUnit.name);
  }

  Future<MetricUnit> loadMetricUnit() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSystem = prefs.getString('metric_unit');
    if (savedSystem != null) {
      return MetricUnit.values.firstWhere(
        (element) => element.name == savedSystem,
      );
    }
    return MetricUnit.liter;
  }
}
