import 'dart:convert';

import 'package:milk_mix/data_source/api/provider/api_config.dart';
import 'package:milk_mix/model/profile_response.dart';
import 'package:http/http.dart' as http;

Future<User> getUser() {
  return http
      .get(Uri.parse('${ApiConfig.baseUrl}/auth/profile/'))
      .then((response) => User.fromJson(jsonDecode(response.body)));
}

class StateController {}
