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

class UpgradeToConsultantScreen extends StatelessWidget {
  const UpgradeToConsultantScreen({super.key});

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
                'Purchase to Unlock the Consultant Feature',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              SubscriptionPlanCard(
                title: 'Consultant Plan -',
                subtitle: 'Consultant access for a Year',
                price: '\$25',
                duration: '/year',
                onTap: () async {
                  await controller.purchaseConsultantPlan();
                  if (controller.hasConsultantAccess.value) {
                    Get.offAndToNamed(AppRoutes.homeConsult);
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
                  if (controller.hasConsultantAccess.value) {
                    Get.offAllNamed(AppRoutes.homeConsult);
                  } else {
                    Get.snackbar('Error', 'Failed to restore purchases');
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
