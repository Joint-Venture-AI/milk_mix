import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class MembersScreen extends StatelessWidget {
  const MembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 240.h),
              SvgPicture.asset('assets/logos/lock_round.svg', height: 80.h),
              SizedBox(height: 20.h),
              Text(
                textAlign: TextAlign.center,
                'Unlock and Add Members',
                style: TextStyle(
                  fontSize: 23.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                textAlign: TextAlign.center,
                'Upgrade plan and get the option to add your farms member ( Each member cost \$10 )',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textLightGrey,
                ),
              ),
              SizedBox(height: 160.h),
              TextWidgetButton(text: 'Upgrade Now!', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
