class AuthResponse {
  String? accessToken;
  String? refreshToken;
  String? role;
  bool? isVerified;
  Profile? profile;

  AuthResponse({
    this.accessToken,
    this.refreshToken,
    this.role,
    this.isVerified,
    this.profile,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      role: json['role'] as String?,
      isVerified: json['is_verified'] as bool?,
      profile:
          json['profile'] != null
              ? Profile.fromJson(json['profile'] as Map<String, dynamic>)
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'role': role,
      'is_verified': isVerified,
      'profile': profile?.toJson(),
    };
  }
}

class Profile {
  int? id;
  int? user;
  String? name;
  String? profilePicture;
  String? phoneNumber;
  String? joinedDate;

  Profile({
    this.id,
    this.user,
    this.name,
    this.profilePicture,
    this.phoneNumber,
    this.joinedDate,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json['id'] as int?,
      user: json['user'] as int?,
      name: json['name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      phoneNumber: json['phone_number'] as String?,
      joinedDate: json['joined_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'name': name,
      'profile_picture': profilePicture,
      'phone_number': phoneNumber,
      'joined_date': joinedDate,
    };
  }
}
