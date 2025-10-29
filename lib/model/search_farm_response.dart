class SearchFarmResponse {
  final String? message;
  final List<Farm>? data;

  SearchFarmResponse({this.message, this.data});

  factory SearchFarmResponse.fromJson(Map<String, dynamic> json) {
    return SearchFarmResponse(
      message: json['message'],
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => Farm.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'message': message,
    'data': data?.map((e) => e.toJson()).toList(),
  };
}

class Farm {
  final int? id;
  final String? email;
  final Profile? profile;

  Farm({this.id, this.email, this.profile});

  factory Farm.fromJson(Map<String, dynamic> json) {
    return Farm(
      id: json['id'],
      email: json['email'],
      profile:
          json['profile'] != null ? Profile.fromJson(json['profile']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'profile': profile?.toJson(),
  };
}

class Profile {
  final String? name;
  final String? farmName;
  final String? phoneNumber;
  final String? profilePicture;
  final String? joinedDate;

  Profile({
    this.name,
    this.farmName,
    this.phoneNumber,
    this.profilePicture,
    this.joinedDate,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'],
      farmName: json['farm_name'],
      phoneNumber: json['phone_number'],
      profilePicture: json['profile_picture'],
      joinedDate: json['joined_date'],
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'farm_name': farmName,
    'phone_number': phoneNumber,
    'profile_picture': profilePicture,
    'joined_date': joinedDate,
  };
}
