import 'package:milk_mix/constants/app_constant.dart';

class ApiConfig {
  static const String baseUrl = AppConstant.baseUrl;
  static const Duration timeout = Duration(seconds: 30);

  // API Endpoints
  static const String auth = '/auth';
  static const String milkHistory = '/milk-history';
  static const String members = '/members';
  static const String consultants = '/consultants';
  static const String support = '/support';
  static const String advertisements = '/advertisements';
}