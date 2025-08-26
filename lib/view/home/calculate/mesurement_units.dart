// lib/enums/measurement_units.dart
enum MeasurementSystem { imperial, metric }

enum ImperialUnit { gallon, pounds }

enum MetricUnit { liter, kilo }

extension MeasurementSystemExtension on MeasurementSystem {
  String get displayName {
    switch (this) {
      case MeasurementSystem.imperial:
        return 'English';
      case MeasurementSystem.metric:
        return 'Metric';
    }
  }
}

extension ImperialUnitExtension on ImperialUnit {
  String get displayName {
    switch (this) {
      case ImperialUnit.gallon:
        return 'Gallon';
      case ImperialUnit.pounds:
        return 'Pounds';
    }
  }

  String get abbreviation {
    switch (this) {
      case ImperialUnit.gallon:
        return 'gal';
      case ImperialUnit.pounds:
        return 'lbs';
    }
  }
}

extension MetricUnitExtension on MetricUnit {
  String get displayName {
    switch (this) {
      case MetricUnit.liter:
        return 'Liter';
      case MetricUnit.kilo:
        return 'Kilo';
    }
  }

  String get abbreviation {
    switch (this) {
      case MetricUnit.liter:
        return 'L';
      case MetricUnit.kilo:
        return 'kg';
    }
  }
}
