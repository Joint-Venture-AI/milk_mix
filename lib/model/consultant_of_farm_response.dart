import 'dart:convert';

class ConsultantOfFarmResponse {
  final int? id;
  final int? farm;
  final String? farmEmail;
  final String? farmName;
  final String? farmProfilePicture;
  final int? consultant;
  final String? consultantEmail;
  final String? consultantName;
  final dynamic consultantProfilePicture;
  final DateTime? createdAt;

  ConsultantOfFarmResponse({
    this.id,
    this.farm,
    this.farmEmail,
    this.farmName,
    this.farmProfilePicture,
    this.consultant,
    this.consultantEmail,
    this.consultantName,
    this.consultantProfilePicture,
    this.createdAt,
  });

  factory ConsultantOfFarmResponse.fromRawJson(String str) =>
      ConsultantOfFarmResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ConsultantOfFarmResponse.fromJson(Map<String, dynamic> json) =>
      ConsultantOfFarmResponse(
        id: json["id"],
        farm: json["farm"],
        farmEmail: json["farm_email"],
        farmName: json["farm_name"],
        farmProfilePicture: json["farm_profile_picture"],
        consultant: json["consultant"],
        consultantEmail: json["consultant_email"],
        consultantName: json["consultant_name"],
        consultantProfilePicture: json["consultant_profile_picture"],
        createdAt:
            json["created_at"] == null
                ? null
                : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "farm": farm,
    "farm_email": farmEmail,
    "farm_name": farmName,
    "farm_profile_picture": farmProfilePicture,
    "consultant": consultant,
    "consultant_email": consultantEmail,
    "consultant_name": consultantName,
    "consultant_profile_picture": consultantProfilePicture,
    "created_at": createdAt?.toIso8601String(),
  };
}
