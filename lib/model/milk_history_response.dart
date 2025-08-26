import 'package:milk_mix/model/get_milk_history_response.dart';

class MilkHistoryResponse {
  String? message;
  GetMilkHistoryData? data;

  MilkHistoryResponse({this.message, this.data});

  factory MilkHistoryResponse.fromJson(Map<String, dynamic> json) {
    return MilkHistoryResponse(
      message: json['message'] as String?,
      data:
          json['data'] != null
              ? GetMilkHistoryData.fromJson(json['data'])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'data': data?.toJson()};
  }
}
