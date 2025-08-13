class CalculationModel {
  double? bottleSize;
  int? numberOfBottles;
  double? hospitalSolids;
  int? hospitalMilkVolume;
  int? desiredSolidsContent;
  int? poundsOfWater;
  int? poundsOfMilkReplacer;
  double? solidsHospitalMilk;
  int? hospitalMilkUsed;
  String? totalVolume;

  CalculationModel({
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
  });

  CalculationModel.fromJson(Map<String, dynamic> json) {
    bottleSize = json['bottle_size'];
    numberOfBottles = json['number_of_bottles'];
    hospitalSolids = json['hospital_solids'];
    hospitalMilkVolume = json['hospital_milk_volume'];
    desiredSolidsContent = json['desired_solids_content'];
    poundsOfWater = json['pounds_of_water'];
    poundsOfMilkReplacer = json['pounds_of_milk_replacer'];
    solidsHospitalMilk = json['solids_hospital_milk'];
    hospitalMilkUsed = json['hospital_milk_used'];
    totalVolume = json['total_volume'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bottle_size'] = bottleSize;
    data['number_of_bottles'] = numberOfBottles;
    data['hospital_solids'] = hospitalSolids;
    data['hospital_milk_volume'] = hospitalMilkVolume;
    data['desired_solids_content'] = desiredSolidsContent;
    data['pounds_of_water'] = poundsOfWater;
    data['pounds_of_milk_replacer'] = poundsOfMilkReplacer;
    data['solids_hospital_milk'] = solidsHospitalMilk;
    data['hospital_milk_used'] = hospitalMilkUsed;
    data['total_volume'] = totalVolume;
    return data;
  }
}
