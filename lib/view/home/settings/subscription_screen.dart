import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/payment_history_tile.dart';
import 'package:milk_mix/view/widget/subscription_plan_card.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppBarWidget(),

              SizedBox(height: 16.h),
              Text(
                textAlign: TextAlign.start,
                'Subscription and Plan',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(width: 1.5.h, color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 7.w,
                          height: 7.w,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Current plan',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    SubscriptionPlanCard(
                      title: 'Personal Plan -',
                      subtitle: 'Start 30 Days Free',
                      price: '\$25',
                      duration: '/year',
                      onTap: () {},
                    ),
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/logos/date.svg',
                          width: 16.w,

                          color: Colors.orange,
                        ),
                        SizedBox(width: 8.w),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Next Payment: ',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.orange,
                                ),
                              ),
                              TextSpan(
                                text: 'January 1, 2026',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey[500],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(width: 1.5.h, color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 4.w),
                        Text(
                          'Change Plan',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    SubscriptionPlanCard(
                      title: 'Personal Plan -',
                      subtitle: 'Start 30 Days Free',
                      price: '\$25',
                      duration: '/year',
                      onTap: () {},
                    ),
                    SizedBox(height: 12.h),
                    SubscriptionPlanCard(
                      title: 'Be A Consultant',
                      subtitle: '',
                      price: '\$25',
                      duration: '/year',
                      onTap: () {},
                    ),
                    SizedBox(height: 12.h),
                    SubscriptionPlanCard(
                      title: 'Enterprise Plan',
                      subtitle: '',
                      price: '\$25',
                      duration: '/year',
                      onTap: () {},
                    ),
                    SizedBox(height: 20.h),
                    TextButtonWidgetLight(text: 'Upgrade', onPressed: () {}),
                  ],
                ),
              ),
              SizedBox(height: 12.h),

              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(width: 1.5.h, color: Colors.grey.shade200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 4.w),
                        Text(
                          'Payment History',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                    PaymentHistoryTile(price: '\$25.00', date: 'Dec 1, 2025'),
                    SizedBox(height: 12.h),
                    PaymentHistoryTile(price: '\$25.00', date: 'Dec 1, 2025'),
                    SizedBox(height: 12.h),
                    PaymentHistoryTile(price: '\$25.00', date: 'Dec 1, 2025'),
                  ],
                ),
              ),
              SizedBox(height: 12.h),
              TextWidgetButton(text: 'Back To Settings', onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }
}
