class CreateHistory {
  double? bottleSize;
  int? numberOfBottles;
  double? hospitalSolids;
  double? hospitalMilkVolume;
  double? desiredSolidsContent;
  double? poundsOfWater;
  double? poundsOfMilkReplacer;
  double? solidsHospitalMilk;
  double? hospitalMilkUsed;
  String? totalVolume;
  String? unit;

  CreateHistory({
    this.bottleSize,
    this.numberOfBottles,
    this.hospitalSolids,
    this.hospitalMilkVolume,
    this.desiredSolidsContent,
    this.poundsOfWater,
    this.poundsOfMilkReplacer,
    this.solidsHospitalMilk,
    this.hospitalMilkUsed,
    this.totalVolume,
    this.unit,
  });

  // Optional: fromJson factory for parsing
  factory CreateHistory.fromJson(Map<String, dynamic> json) {
    return CreateHistory(
      bottleSize: (json['bottle_size'] as num?)?.toDouble(),
      numberOfBottles: json['number_of_bottles'] as int?,
      hospitalSolids: (json['hospital_solids'] as num?)?.toDouble(),
      hospitalMilkVolume: (json['hospital_milk_volume'] as num?)?.toDouble(),
      desiredSolidsContent:
          (json['desired_solids_content'] as num?)?.toDouble(),
      poundsOfWater: (json['pounds_of_water'] as num?)?.toDouble(),
      poundsOfMilkReplacer:
          (json['pounds_of_milk_replacer'] as num?)?.toDouble(),
      solidsHospitalMilk: (json['solids_hospital_milk'] as num?)?.toDouble(),
      hospitalMilkUsed: (json['hospital_milk_used'] as num?)?.toDouble(),
      totalVolume: json['total_volume']?.toString(),
      unit: json['unit']?.toString(),
    );
  }

  // Optional: toJson method
  Map<String, dynamic> toJson() {
    return {
      'bottle_size': bottleSize,
      'number_of_bottles': numberOfBottles,
      'hospital_solids': hospitalSolids,
      'hospital_milk_volume': hospitalMilkVolume,
      'desired_solids_content': desiredSolidsContent,
      'pounds_of_water': poundsOfWater,
      'pounds_of_milk_replacer': poundsOfMilkReplacer,
      'solids_hospital_milk': solidsHospitalMilk,
      'hospital_milk_used': hospitalMilkUsed,
      'total_volume': totalVolume,
      'unit': unit,
    };
  }
}
