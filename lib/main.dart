import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:milk_mix/app.dart' show MilkMix;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(MilkMix());
}
