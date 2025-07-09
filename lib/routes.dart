import 'package:get/get.dart';
import 'package:milk_mix/homeFarm/farm_home_bottom_nav_bar.dart';
import 'package:milk_mix/view/authentication/authentication_screen.dart';
import 'package:milk_mix/view/authentication/signin/signin_screen.dart';
import 'package:milk_mix/view/authentication/signup/create_account_screen.dart';
import 'package:milk_mix/view/authentication/signup/otp_verification_screen.dart';
import 'package:milk_mix/view/authentication/signup/select_measurement_system.dart';
import 'package:milk_mix/view/authentication/signup/select_preferred_language_screen.dart';
import 'package:milk_mix/view/authentication/signup/welcome_screen.dart';
import 'package:milk_mix/view/home/home_bottom_nav_screen.dart';
import 'package:milk_mix/view/home/mebers/add_member_screen.dart';
import 'package:milk_mix/view/home/mebers/member_details_screen.dart';
import 'package:milk_mix/view/home/mebers/members_premium_screen.dart';
import 'package:milk_mix/view/home/settings/change_password_screen.dart';
import 'package:milk_mix/view/home/settings/edit_language_screen.dart';
import 'package:milk_mix/view/home/settings/edit_measurement_screen.dart';
import 'package:milk_mix/view/home/settings/edit_profile_screen.dart';
import 'package:milk_mix/view/home/settings/help_and_support_screen.dart';
import 'package:milk_mix/view/home/settings/subscription_screen.dart';
import 'package:milk_mix/view/homeConsult/home_consult_bottom_nav_screen.dart';
import 'package:milk_mix/view/homeConsult/manageFarm/add_farm_screen.dart';
import 'package:milk_mix/view/homeConsult/manageFarm/consult_farm_list.dart';
import 'package:milk_mix/view/homeConsult/manageFarm/consult_farm_screen.dart';
import 'package:milk_mix/view/onboarding/onboarding_screen.dart'
    show OnboardingScreen;
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
  static String addMember = "/add-member";
  static String onBoarding = "/on-boarding";
  static String memberDetails = "/member-details";
  static String homeConsult = "/home-consult";
  static String homeFarm = "/home-farm";
  static String addFarm = "/add-farm";
  static String consultFarm = "/consult-farm";
  static String consultFarmList = "/consult-farm-list";
  static String editProfile = "/edit-profile";
  static String editLanguage = "/edit-language";
  static String editMeasurement = "/edit-measurement";
  static String changePassword = "/change-password";
  static String helpAndSupport = "/help-and-support";
  static String subscription = "/subscription";

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
    GetPage(name: addMember, page: () => AddMemberScreen()),
    GetPage(name: onBoarding, page: () => OnboardingScreen()),
    GetPage(name: memberDetails, page: () => MemberDetailsScreen()),
    GetPage(name: homeConsult, page: () => HomeConsultBottomNavScreen()),
    GetPage(name: homeFarm, page: () => FarmHomeBottomNavBar()),
    GetPage(name: addFarm, page: () => AddFarmScreen()),
    GetPage(name: consultFarm, page: () => ConsultFarmScreen()),
    GetPage(name: consultFarmList, page: () => ConsultFarmList()),
    GetPage(name: editProfile, page: () => EditProfileScreen()),
    GetPage(name: editLanguage, page: () => EditLanguageScreen()),
    GetPage(name: editMeasurement, page: () => EditMeasurementScreen()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: helpAndSupport, page: () => HelpAndSupportScreen()),
    GetPage(name: subscription, page: () => SubscriptionScreen()),
  ];
}
