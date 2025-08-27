class LatestAdResponse {
  final int? id;
  final String? title;
  final String? externalLink;
  final String? image;
  final String? targetUser;
  final String? status;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? createdAt;

  LatestAdResponse({
    this.id,
    this.title,
    this.externalLink,
    this.image,
    this.targetUser,
    this.status,
    this.startDate,
    this.endDate,
    this.createdAt,
  });

  factory LatestAdResponse.fromJson(Map<String, dynamic> json) {
    return LatestAdResponse(
      id: json['id'] as int?,
      title: json['title'] as String?,
      externalLink: json['external_link'] as String?,
      image: json['image'] as String?,
      targetUser: json['target_user'] as String?,
      status: json['status'] as String?,
      startDate:
          json['start_date'] != null
              ? DateTime.tryParse(json['start_date'])
              : null,
      endDate:
          json['end_date'] != null ? DateTime.tryParse(json['end_date']) : null,
      createdAt:
          json['created_at'] != null
              ? DateTime.tryParse(json['created_at'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'external_link': externalLink,
      'image': image,
      'target_user': targetUser,
      'status': status,
      'start_date': startDate?.toIso8601String(),
      'end_date': endDate?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
    };
  }
}
