import 'package:get/get.dart';
import 'package:milk_mix/view/authentication/authentication_screen.dart';
import 'package:milk_mix/view/authentication/signin/signin_screen.dart';
import 'package:milk_mix/view/authentication/signup/create_account_screen.dart';
import 'package:milk_mix/view/authentication/signup/otp_verification_screen.dart';
import 'package:milk_mix/view/authentication/signup/select_measurement_system.dart';
import 'package:milk_mix/view/authentication/signup/select_preferred_language_screen.dart';
import 'package:milk_mix/view/authentication/signup/welcome_screen.dart';
import 'package:milk_mix/view/home/home_bottom_nav_screen.dart';
import 'package:milk_mix/view/home/mebers/add_member_screen.dart';
import 'package:milk_mix/view/home/mebers/members_premium_screen.dart';
import 'package:milk_mix/view/splash_screen.dart';
import 'package:milk_mix/view/subscription/congratulation_screen.dart';
import 'package:milk_mix/view/subscription/upgrade_premium_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash-screen";
  static String auth = "/authentication";
  static String signin = "/signin";
  static String createAccount = "/create-account";
  static String otpVerification = "/otp-verification";
  static String selectLanguage = "/select-language";
  static String selectMeasurement = "/select-measurement";
  static String welcome = "/welcome";
  static String premium = "/premium";
  static String congratulation = "/congratulation";
  static String home = "/home";
  static String memberPremium = "/member-premium";
  static String addmMember = "/add-member";

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: auth, page: () => const AuthenticationScreen()),
    GetPage(name: signin, page: () => SigninScreen()),
    GetPage(name: createAccount, page: () => CreateAccountScreen()),
    GetPage(name: otpVerification, page: () => OtpVerificationScreen()),
    GetPage(name: selectLanguage, page: () => SelectPreferredLanguageScreen()),
    GetPage(name: selectMeasurement, page: () => SelectMeasurementSystem()),
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(name: premium, page: () => UpgradePremium()),
    GetPage(name: congratulation, page: () => CongratulationScreen()),
    GetPage(name: home, page: () => HomeBottomNavScreen()),
    GetPage(name: memberPremium, page: () => MembersPremiumScreen()),
    GetPage(name: addmMember, page: () => AddMemberScreen()),
  ];
}
