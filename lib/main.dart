import 'dart:io';
import 'package:flutter/material.dart';
import 'package:milk_mix/app.dart' show MilkMix;
import 'package:milk_mix/constants/app_constant.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/store_config.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() async {
  if (Platform.isIOS || Platform.isMacOS) {
    StoreConfig(store: Store.appStore, apiKey: AppConstant.appleApiKey);
  } else if (Platform.isAndroid) {
    StoreConfig(store: Store.playStore, apiKey: AppConstant.googleApiKey);
  }

  WidgetsFlutterBinding.ensureInitialized();

  ApiProvider();
  runApp(MilkMix());
}
