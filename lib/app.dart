import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:milk_mix/presentation/authentication/signin_screen.dart';
import 'package:milk_mix/presentation/splash_screen.dart';

class MilkMix extends StatelessWidget {
  const MilkMix({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Milk Mix',
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: Colors.white,
            //  fontFamily: 'inter',
          ),
          home: child,
        );
      },
      child: const SigninScreen(),
    );
  }
}
