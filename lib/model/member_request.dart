class MemberRequest {
  int? farm;
  String? email;
  String? password;
  String? name;

  MemberRequest({this.farm, this.email, this.password, this.name});

  factory MemberRequest.fromJson(Map<String, dynamic> json) {
    return MemberRequest(
      farm: json['farm'] as int?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'farm': farm, 'email': email, 'password': password, 'name': name};
  }
}
