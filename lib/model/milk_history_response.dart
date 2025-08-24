class MilkHistoryResponse {
  String? message;
  MilkHistoryData? data;

  MilkHistoryResponse({this.message, this.data});

  factory MilkHistoryResponse.fromJson(Map<String, dynamic> json) {
    return MilkHistoryResponse(
      message: json['message'] as String?,
      data:
          json['data'] != null ? MilkHistoryData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}

class MilkHistoryData {
  int? id;
  int? user;
  String? userEmail;
  int? farm;
  String? farmEmail;
  String? createdAt;
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

  MilkHistoryData({
    this.id,
    this.user,
    this.userEmail,
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
    this.farm,
    this.farmEmail,
  });

  factory MilkHistoryData.fromJson(Map<String, dynamic> json) {
    return MilkHistoryData(
      id: json['id'] as int?,
      user: json['user'] as int?,
      userEmail: json['user_email'] as String?,
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
      farm: json['farm'] as int?,
      farmEmail: json['farm_email'] as String?,
    );
  }

  static List<MilkHistoryData> fromJsonList(List<dynamic> json) {
    return json.map((e) => MilkHistoryData.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'user_email': userEmail,
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
      'farm': farm,
      'farm_email': farmEmail,
    };
  }
}
