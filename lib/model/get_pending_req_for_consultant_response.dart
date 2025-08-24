class GetPendingReqForConsultantResponse {
  final String? message;
  final List<ConsultantRequest>? data;

  GetPendingReqForConsultantResponse({this.message, this.data});

  factory GetPendingReqForConsultantResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return GetPendingReqForConsultantResponse(
      message: json['message'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => ConsultantRequest.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class ConsultantRequest {
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
  final String? createdAt;
  final String? updatedAt;

  ConsultantRequest({
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

  factory ConsultantRequest.fromJson(Map<String, dynamic> json) {
    return ConsultantRequest(
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
      createdAt: json['created_at'] as String?,
      updatedAt: json['updated_at'] as String?,
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
