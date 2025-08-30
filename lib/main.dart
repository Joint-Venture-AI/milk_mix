import 'package:flutter/material.dart';
import 'package:milk_mix/app.dart' show MilkMix;
import 'package:milk_mix/data_source/api/provider/api_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiProvider();
  runApp(MilkMix());
}
