import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:milk_mix/app.dart' show MilkMix;
import 'package:milk_mix/data_source/api_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => ApiService());
  try {
    await GetStorage.init();
  } catch (e) {
    print('GetStorage initialization failed: $e');
  }
  // Initialize ApiService (restore tokens and register refresher)
  await ApiService.instance.initialize();
  runApp(MilkMix());
}
