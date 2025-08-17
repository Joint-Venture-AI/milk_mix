import 'package:flutter/material.dart';
import 'package:milk_mix/app.dart' show MilkMix;
import 'package:milk_mix/data_source/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiService();
  runApp(MilkMix());
}
