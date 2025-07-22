class calculationModel {
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

  calculationModel({
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

  calculationModel.fromJson(Map<String, dynamic> json) {
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bottle_size'] = this.bottleSize;
    data['number_of_bottles'] = this.numberOfBottles;
    data['hospital_solids'] = this.hospitalSolids;
    data['hospital_milk_volume'] = this.hospitalMilkVolume;
    data['desired_solids_content'] = this.desiredSolidsContent;
    data['pounds_of_water'] = this.poundsOfWater;
    data['pounds_of_milk_replacer'] = this.poundsOfMilkReplacer;
    data['solids_hospital_milk'] = this.solidsHospitalMilk;
    data['hospital_milk_used'] = this.hospitalMilkUsed;
    data['total_volume'] = this.totalVolume;
    return data;
  }
}
