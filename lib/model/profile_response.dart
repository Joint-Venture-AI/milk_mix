class User {
  int? id;
  String? email;
  String? role;
  bool? isVerified;
  UserProfile? userProfile;

  User({this.id, this.email, this.role, this.isVerified, this.userProfile});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      email: json['email'] as String?,
      role: json['role'] as String?,
      isVerified: json['is_verified'] as bool?,
      userProfile:
          json['user_profile'] != null
              ? UserProfile.fromJson(json['user_profile'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'role': role,
      'is_verified': isVerified,
      'user_profile': userProfile?.toJson(),
    };
  }
}

class UserProfile {
  int? id;
  int? user;
  String? name;
  String? farmName;
  String? profilePicture;
  String? phoneNumber;
  String? joinedDate;

  UserProfile({
    this.id,
    this.user,
    this.name,
    this.farmName,
    this.profilePicture,
    this.phoneNumber,
    this.joinedDate,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] as int?,
      user: json['user'] as int?,
      name: json['name'] as String?,
      farmName: json['farm_name'] as String?,
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
      'farm_name': farmName,
      'profile_picture': profilePicture,
      'phone_number': phoneNumber,
      'joined_date': joinedDate,
    };
  }
}
