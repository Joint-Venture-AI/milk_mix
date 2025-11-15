import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/profile_controller.dart';
import 'package:milk_mix/controllers/subscription_controller.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/data_source/api/client/token_storage.dart';
import 'package:milk_mix/services/revenuecat_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), _initApp);
  }

  Future<void> _initApp() async {
    if (await TokenStorage.getAccessToken() == null) {
      return Get.offAllNamed(AppRoutes.onBoarding);
    }

    final profile = Get.put(ProfileController());
    await profile.loadProfile();

    await RevenueCatService.initialize();
    final subscription = Get.put(SubscriptionController());
    await subscription.checkSubscriptionStatus();

    final role = await TokenStorage.getRole();
    if (role == 'consultant') {
      Get.offAllNamed(AppRoutes.homeConsult);
    } else
    //
    //
    if (role == 'farm') {
      if (subscription.hasAddMemberAccess.value) {
        Get.offAllNamed(AppRoutes.home);
      } else if (subscription.hasIndividualAccess.value) {
        Get.offAllNamed(AppRoutes.farmMemberHome);
      } else {
        Get.snackbar('Subscription Required', 'Please subscribe to continue');
        Get.offAllNamed(AppRoutes.upgradeToIndividualUser);
      }
    } else
    //
    //
    if (role == 'farm_user') {
      Get.offAllNamed(AppRoutes.memberHome);
    } else {
      Get.offAllNamed(AppRoutes.signin);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1.sw,
        height: 1.sh,
        color: AppColors.surface,
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 81.w),
              SvgPicture.asset('assets/logos/milkmix.svg', width: 171.w),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
