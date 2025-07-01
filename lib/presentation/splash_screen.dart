import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Get.toNamed(AppRoutes.signin);
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
