import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/data_source/api/client/token_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (await TokenStorage.getAccessToken() != null) {
        final role = await TokenStorage.getRole();
        if (role == 'consultant') {
          Get.toNamed(AppRoutes.homeConsult);
        } else if (role == 'farm') {
          Get.toNamed(AppRoutes.farmMemberHome);
        } else if (role == 'farm_user') {
          Get.offAllNamed(AppRoutes.memberHome);
        } else {
          Get.toNamed(AppRoutes.signin);
        }
      } else {
        Get.toNamed(AppRoutes.onBoarding);
      }
    });
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
