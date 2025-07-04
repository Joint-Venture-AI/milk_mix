import 'package:get/get.dart';
import 'package:milk_mix/view/authentication/authentication_screen.dart';
import 'package:milk_mix/view/authentication/signin/signin_screen.dart';
import 'package:milk_mix/view/authentication/signup/create_account_screen.dart';
import 'package:milk_mix/view/authentication/signup/otp_verifiaction_screen.dart';
import 'package:milk_mix/view/authentication/signup/select_measurement_system.dart';
import 'package:milk_mix/view/authentication/signup/select_prefered_language_screen.dart';
import 'package:milk_mix/view/authentication/signup/welcome_screen.dart';
import 'package:milk_mix/view/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash-screen";
  static String auth = "/authentication";
  static String signin = "/signin";
  static String createaccount = "/createaccount";
  static String otpverification = "/otpverification";
  static String selectlanguage = "/selectlanguage";
  static String selectmeasurement = "/selectmeasurement";
  static String welcome = "/welcome";

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: auth, page: () => const AuthenticationScreen()),
    GetPage(name: signin, page: () => SigninScreen()),
    GetPage(name: createaccount, page: () => CreateAccountScreen()),
    GetPage(name: otpverification, page: () => OtpVerifiactionScreen()),
    GetPage(name: selectlanguage, page: () => SelectPreferedLanguageScreen()),
    GetPage(name: selectmeasurement, page: () => SelectMeasurementSystem()),
    GetPage(name: welcome, page: () => WelcomeScreen()),
  ];
}
