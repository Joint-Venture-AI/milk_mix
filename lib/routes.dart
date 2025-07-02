import 'package:get/get.dart';
import 'package:milk_mix/view/authentication/authentication_screen.dart';
import 'package:milk_mix/view/authentication/signin/signin_screen.dart';
import 'package:milk_mix/view/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash-screen";
  static String auth = "/authentication";
  static String signin = "/signin";

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: auth, page: () => const AuthenticationScreen()),
    GetPage(name: signin, page: () => SigninScreen()),
  ];
}
