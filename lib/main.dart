import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:milk_mix/app.dart' show MilkMix;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await GetStorage.init();
  } catch (e) {
    print('GetStorage initialization failed: $e');
  }
  runApp(MilkMix());
}
