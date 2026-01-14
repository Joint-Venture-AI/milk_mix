import 'package:get/get.dart';
import 'package:milk_mix/view/authentication/subscription/upgrade_to_consultant_screen.dart';
import 'package:milk_mix/view/authentication/subscription/upgrade_to_premium_user_screen.dart';
import 'package:milk_mix/view/home/homeFarm/farm_home_bottom_nav_bar.dart';
import 'package:milk_mix/view/home/homeFarmMember/farm_member_home_bottom_nav_bar.dart';
import 'package:milk_mix/view/authentication/authentication_screen.dart';
import 'package:milk_mix/view/authentication/signin/signin_screen.dart';
import 'package:milk_mix/view/authentication/signup/create_account_screen.dart';
import 'package:milk_mix/view/authentication/signin/forgot_password_screen.dart';
import 'package:milk_mix/view/authentication/signin/reset_password_screen.dart';
import 'package:milk_mix/view/authentication/signup/otp_verification_screen.dart';
import 'package:milk_mix/view/authentication/signup/select_measurement_system.dart';
import 'package:milk_mix/view/authentication/signup/select_preferred_language_screen.dart';
import 'package:milk_mix/view/authentication/signup/welcome_screen.dart';
import 'package:milk_mix/view/home/members/personal_home_bottom_nav_bar.dart';
import 'package:milk_mix/view/home/home_bottom_nav_screen.dart';
import 'package:milk_mix/view/home/members/add_member_screen.dart';
import 'package:milk_mix/view/home/members/member_details_screen.dart';
import 'package:milk_mix/view/home/members/members_premium_screen.dart';
import 'package:milk_mix/view/home/members/members_screen.dart';
import 'package:milk_mix/view/home/settings/change_password_screen.dart';
import 'package:milk_mix/view/home/settings/edit_language_screen.dart';
import 'package:milk_mix/view/home/settings/edit_measurement_screen.dart';
import 'package:milk_mix/view/home/settings/edit_profile_screen.dart';
import 'package:milk_mix/view/home/settings/help_and_support_screen.dart';
import 'package:milk_mix/view/home/settings/subscription_screen.dart';
import 'package:milk_mix/view/home/homeConsult/home_consult_bottom_nav_screen.dart';
import 'package:milk_mix/view/home/homeConsult/manageFarm/add_farm_screen.dart';
import 'package:milk_mix/view/home/homeConsult/manageFarm/consult_farm_list.dart';
import 'package:milk_mix/view/home/homeConsult/manageFarm/consult_farm_screen.dart';
import 'package:milk_mix/view/home/settingsConsult/edit_language_screen_consult.dart';
import 'package:milk_mix/view/home/settingsConsult/subscription_screen_consult.dart';
import 'package:milk_mix/view/onboarding/onboarding_screen.dart'
    show OnboardingScreen;
import 'package:milk_mix/view/splash_screen.dart';
import 'package:milk_mix/view/authentication/subscription/congratulation_screen.dart';
import 'package:milk_mix/view/authentication/subscription/upgrade_to_individual_user_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash-screen";
  static String auth = "/authentication";
  static String signin = "/signin";
  static String forgotPassword = "/forgot-password";
  static String resetPassword = "/reset-password";
  static String createAccount = "/create-account";
  static String otpVerification = "/otp-verification";
  static String selectLanguage = "/select-language";
  static String selectMeasurement = "/select-measurement";
  static String welcome = "/welcome";
  static String upgradeToIndividualUser = "/upgrade-to-individual-user";
  static String upgradeToPremiumUser = "/upgrade-to-premium-user";
  static String upgradeToConsultant = "/upgrade-to-consultant";
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
  static String recipeSummary = "/recipe-summary";
  static String homePersonal = "/personal-home";
  static String member = "/member";
  static String editProfileConsult = "/edit-profile";
  static String editLanguageConsult = "/edit-language";
  static String editMeasurementConsult = "/edit-measurement";
  static String changePasswordConsult = "/change-password";
  static String helpAndSupportConsult = "/help-and-support";
  static String subscriptionConsult = "/subscription";
  static String farmMemberHome = "/farm-member-home";
  static String memberHome = "/member-home";

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: auth, page: () => const AuthenticationScreen()),
    GetPage(name: signin, page: () => SigninScreen()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordScreen()),
    GetPage(
      name: resetPassword,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final email =
            args != null && args.containsKey('email')
                ? args['email'] as String
                : '';
        return ResetPasswordScreen(email: email);
      },
    ),
    GetPage(name: createAccount, page: () => CreateAccountScreen()),
    GetPage(
      name: otpVerification,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final email =
            args != null && args.containsKey('email')
                ? args['email'] as String
                : null;
        return OtpVerificationScreen(email: email);
      },
    ),
    GetPage(name: selectLanguage, page: () => SelectPreferredLanguageScreen()),
    GetPage(name: selectMeasurement, page: () => SelectMeasurementSystem()),
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(
      name: upgradeToIndividualUser,
      page: () => UpgradeToIndividualUserScreen(),
    ),
    GetPage(
      name: upgradeToPremiumUser,
      page: () => UpgradeToPremiumUserScreen(),
    ),
    GetPage(name: upgradeToConsultant, page: () => UpgradeToConsultantScreen()),
    GetPage(name: congratulation, page: () => CongratulationScreen()),
    GetPage(name: home, page: () => HomeBottomNavScreen()),
    GetPage(name: memberPremium, page: () => MembersPremiumScreen()),
    GetPage(name: addMember, page: () => AddMemberScreen()),
    GetPage(name: onBoarding, page: () => OnboardingScreen()),
    GetPage(
      name: memberDetails,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final int? farmUserId =
            args != null && args.containsKey('farmUserId')
                ? args['farmUserId']
                : null;
        final String? farmUserEmail =
            args != null && args.containsKey('farmUserEmail')
                ? args['farmUserEmail']
                : null;
        final String? farmUserName =
            args != null && args.containsKey('farmUserName')
                ? args['farmUserName']
                : null;
        final String? joinedDate =
            args != null && args.containsKey('joinedDate')
                ? args['joinedDate']
                : null;
        if (farmUserId == null) {
          throw ArgumentError('farmUserId is required');
        }
        return MemberDetailsScreen(
          farmUserId: farmUserId,
          farmUserEmail: farmUserEmail,
          farmUserName: farmUserName,
          joinedDate: joinedDate,
        );
      },
    ),
    GetPage(name: homeConsult, page: () => HomeConsultBottomNavScreen()),
    GetPage(name: homeFarm, page: () => FarmHomeBottomNavBar()),
    GetPage(name: homePersonal, page: () => PersonalHomeBottomNavBar()),
    GetPage(name: addFarm, page: () => AddFarmScreen()),
    GetPage(
      name: consultFarm,
      page: () {
        final args = Get.arguments as Map<String, dynamic>?;
        final int? farmId =
            args != null && args.containsKey('farmId') ? args['farmId'] : null;
        final farmName =
            args != null && args.containsKey('farmName')
                ? args['farmName']
                : null;
        if (farmId == null) {
          throw ArgumentError('farmId is required');
        }
        return ConsultFarmScreen(farmId: farmId, farmName: farmName);
      },
    ),
    GetPage(name: consultFarmList, page: () => ConsultFarmList()),
    GetPage(name: editProfile, page: () => EditProfileScreen()),
    GetPage(name: editLanguage, page: () => EditLanguageScreen()),
    GetPage(name: editMeasurement, page: () => EditMeasurementScreen()),
    GetPage(name: changePassword, page: () => ChangePasswordScreen()),
    GetPage(name: helpAndSupport, page: () => HelpAndSupportScreen()),
    GetPage(name: subscription, page: () => SubscriptionScreen()),
    // GetPage(name: recipeSummary, page: () => RecipeSummaryDialog()),
    GetPage(name: member, page: () => MembersScreen()),
    GetPage(name: editLanguageConsult, page: () => EditLanguageScreenConsult()),
    GetPage(name: subscriptionConsult, page: () => SubscriptionScreenConsult()),
    GetPage(name: farmMemberHome, page: () => FarmHomeBottomNavBar()),
    GetPage(name: memberHome, page: () => MemberHomeBottomNavBar()),
  ];
}
