class FarmMembersResponse {
  String? message;
  List<FarmMemberData>? data;

  FarmMembersResponse({this.message, this.data});

  factory FarmMembersResponse.fromJson(Map<String, dynamic> json) {
    return FarmMembersResponse(
      message: json['message'] as String?,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => FarmMemberData.fromJson(e as Map<String, dynamic>))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.map((e) => e.toJson()).toList()};
  }
}

class FarmMemberData {
  int? memberId;
  int? farmId;
  String? farmEmail;
  String? farmName;
  int? farmUserId;
  String? farmUserEmail;
  FarmUserProfile? farmUserProfile;
  String? createdAt;
  bool? isActive;

  FarmMemberData({
    this.memberId,
    this.farmId,
    this.farmEmail,
    this.farmName,
    this.farmUserId,
    this.farmUserEmail,
    this.farmUserProfile,
    this.createdAt,
    this.isActive,
  });

  factory FarmMemberData.fromJson(Map<String, dynamic> json) {
    return FarmMemberData(
      memberId: json['member_id'] as int?,
      farmId: json['farm_id'] as int?,
      farmEmail: json['farm_email'] as String?,
      farmName: json['farm_name'] as String?,
      farmUserId: json['farm_user_id'] as int?,
      farmUserEmail: json['farm_user_email'] as String?,
      farmUserProfile:
          json['farm_user_profile'] != null
              ? FarmUserProfile.fromJson(json['farm_user_profile'])
              : null,
      createdAt: json['created_at'] as String?,
      isActive: json['is_active'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'member_id': memberId,
      'farm_id': farmId,
      'farm_email': farmEmail,
      'farm_name': farmName,
      'farm_user_id': farmUserId,
      'farm_user_email': farmUserEmail,
      'farm_user_profile': farmUserProfile?.toJson(),
      'created_at': createdAt,
      'is_active': isActive,
    };
  }
}

class FarmUserProfile {
  String? name;
  String? phoneNumber;
  String? profilePicture;
  String? joinedDate;

  FarmUserProfile({
    this.name,
    this.phoneNumber,
    this.profilePicture,
    this.joinedDate,
  });

  factory FarmUserProfile.fromJson(Map<String, dynamic> json) {
    return FarmUserProfile(
      name: json['name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      profilePicture: json['profile_picture'] as String?,
      joinedDate: json['joined_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone_number': phoneNumber,
      'profile_picture': profilePicture,
      'joined_date': joinedDate,
    };
  }
}
