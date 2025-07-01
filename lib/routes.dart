import 'package:get/get.dart';
import 'package:milk_mix/presentation/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash-screen";

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
  ];
}
