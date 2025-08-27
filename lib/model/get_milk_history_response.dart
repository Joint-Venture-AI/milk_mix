class GetMilkHistoryData {
  int? id;
  int? user;
  String? userEmail;
  int? farm;
  String? farmEmail;
  String? createdAt;
  //
  int? numberOfBottles;
  double? hospitalMilkVolume;
  //
  double? bottleSize;
  double? hospitalSolids;
  double? desiredSolidsContent;
  //
  double? poundsOfWater;
  double? poundsOfMilkReplacer;
  //
  // [Repurposed] to hold water + milk replacer
  double? solidsHospitalMilk;
  //
  double? hospitalMilkUsed;
  String? totalVolume;
  //
  String? unit;

  GetMilkHistoryData({
    this.id,
    this.user,
    this.userEmail,
    this.farm,
    this.farmEmail,
    this.createdAt,
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

  static List<GetMilkHistoryData> listFromJson(List<dynamic> json) {
    return json.map((value) {
      return GetMilkHistoryData.fromJson(value as Map<String, dynamic>);
    }).toList();
  }

  factory GetMilkHistoryData.fromJson(Map<String, dynamic> json) {
    return GetMilkHistoryData(
      id: json['id'] as int?,
      user: json['user'] as int?,
      userEmail: json['user_email'] as String?,
      farm: json['farm'] as int?,
      farmEmail: json['farm_email'] as String?,
      createdAt: json['created_at'] as String?,
      bottleSize:
          (json['bottle_size'] != null)
              ? double.tryParse(json['bottle_size'].toString())
              : null,
      numberOfBottles: json['number_of_bottles'] as int?,
      hospitalSolids:
          (json['hospital_solids'] != null)
              ? double.tryParse(json['hospital_solids'].toString())
              : null,
      hospitalMilkVolume:
          (json['hospital_milk_volume'] != null)
              ? double.tryParse(json['hospital_milk_volume'].toString())
              : null,
      desiredSolidsContent:
          (json['desired_solids_content'] != null)
              ? double.tryParse(json['desired_solids_content'].toString())
              : null,
      poundsOfWater:
          (json['pounds_of_water'] != null)
              ? double.tryParse(json['pounds_of_water'].toString())
              : null,
      poundsOfMilkReplacer:
          (json['pounds_of_milk_replacer'] != null)
              ? double.tryParse(json['pounds_of_milk_replacer'].toString())
              : null,
      solidsHospitalMilk:
          (json['solids_hospital_milk'] != null)
              ? double.tryParse(json['solids_hospital_milk'].toString())
              : null,
      hospitalMilkUsed:
          (json['hospital_milk_used'] != null)
              ? double.tryParse(json['hospital_milk_used'].toString())
              : null,
      totalVolume: json['total_volume']?.toString(),
      unit: json['unit']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'user_email': userEmail,
      'farm': farm,
      'farm_email': farmEmail,
      'created_at': createdAt,
      'bottle_size': bottleSize?.toStringAsFixed(2),
      'number_of_bottles': numberOfBottles,
      'hospital_solids': hospitalSolids?.toStringAsFixed(2),
      'hospital_milk_volume': hospitalMilkVolume?.toStringAsFixed(2),
      'desired_solids_content': desiredSolidsContent?.toStringAsFixed(2),
      'pounds_of_water': poundsOfWater?.toStringAsFixed(2),
      'pounds_of_milk_replacer': poundsOfMilkReplacer?.toStringAsFixed(2),
      'solids_hospital_milk': solidsHospitalMilk?.toStringAsFixed(2),
      'hospital_milk_used': hospitalMilkUsed?.toStringAsFixed(2),
      'total_volume': totalVolume,
      'unit': unit,
    };
  }
}
