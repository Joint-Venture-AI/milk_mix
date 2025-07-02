import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milk_mix/routes.dart';

class MilkMix extends StatelessWidget {
  const MilkMix({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Milk Mix',
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            fontFamily: 'inter',
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: const Color.fromARGB(
                255,
                194,
                194,
                194,
              ).withOpacity(0.08),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 14.h,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: const BorderSide(color: Colors.grey, width: 2),
              ),
            ),
          ),
          initialRoute: AppRoutes.splashScreen,
          getPages: AppRoutes.pages,
        );
      },
    );
  }
}
