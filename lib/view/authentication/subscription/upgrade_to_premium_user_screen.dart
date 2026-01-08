import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/subscription_controller.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/subscription_plan_card.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class UpgradeToPremiumUserScreen extends StatelessWidget {
  const UpgradeToPremiumUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SubscriptionController());

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppBarWidget(),
              SizedBox(height: 30.h),
              Text(
                'Purchase to Add Farm Members',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              SubscriptionPlanCard(
                title: 'Premium Plan -',
                subtitle: 'Start 30 Days Free',
                price: '\$25',
                duration: '/year',
                onTap: () async {
                  await controller.purchaseAddMemberPlan();
                  if (controller.hasAddMemberAccess.value) {
                    Get.offAndToNamed(AppRoutes.home);
                  } else {
                    Get.snackbar('Error', 'Failed to purchase plan');
                  }
                },
              ),
              SizedBox(height: 20.h),
              TextWidgetButton(
                text: 'Restore Purchases',
                onPressed: () async {
                  await controller.checkSubscriptionStatus();
                  if (controller.hasAddMemberAccess.value) {
                    Get.offAllNamed(AppRoutes.home);
                  }
                },
              ),
              SizedBox(height: 20.h),
              TextWidgetButton(
                text: 'logout'.tr,
                onPressed: () async {
                  await ApiProvider().logout();
                  Get.offAllNamed(AppRoutes.signin);
                },
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/logos/private.svg', height: 14.h),
                  const SizedBox(width: 6),
                  const Text('Secure Payment • Cancel Anytime'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
