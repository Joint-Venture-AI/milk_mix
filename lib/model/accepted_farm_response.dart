class AcceptedFarmResponse {
  final List<AcceptedFarm>? data;
  final String? message;

  AcceptedFarmResponse({this.data, this.message});

  factory AcceptedFarmResponse.fromJson(Map<String, dynamic> json) {
    return AcceptedFarmResponse(
      data:
          (json['data'] as List)
              .map(
                (item) => AcceptedFarm.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((farm) => farm.toJson()).toList(),
      'message': message,
    };
  }
}

class AcceptedFarm {
  final int? id;
  final int? farm;
  final String? farmEmail;
  final String? farmName;
  final String? farmProfilePicture;
  final int? consultant;
  final String? consultantEmail;
  final String? consultantName;
  final String? consultantProfilePicture;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  AcceptedFarm({
    this.id,
    this.farm,
    this.farmEmail,
    this.farmName,
    this.farmProfilePicture,
    this.consultant,
    this.consultantEmail,
    this.consultantName,
    this.consultantProfilePicture,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory AcceptedFarm.fromJson(Map<String, dynamic> json) {
    return AcceptedFarm(
      id: json['id'] as int?,
      farm: json['farm'] as int?,
      farmEmail: json['farm_email'] as String?,
      farmName: json['farm_name'] as String?,
      farmProfilePicture: json['farm_profile_picture'] as String?,
      consultant: json['consultant'] as int?,
      consultantEmail: json['consultant_email'] as String?,
      consultantName: json['consultant_name'] as String?,
      consultantProfilePicture: json['consultant_profile_picture'] as String?,
      status: json['status'] as String?,
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at'])
              : null,
      updatedAt:
          json['updated_at'] != null
              ? DateTime.tryParse(json['updated_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'farm': farm,
      'farm_email': farmEmail,
      'farm_name': farmName,
      'farm_profile_picture': farmProfilePicture,
      'consultant': consultant,
      'consultant_email': consultantEmail,
      'consultant_name': consultantName,
      'consultant_profile_picture': consultantProfilePicture,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
