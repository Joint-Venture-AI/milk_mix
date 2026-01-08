import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/consult_farm_controller.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

class ConsultFarmScreen extends StatelessWidget {
  final int farmId;
  final String farmName;

  const ConsultFarmScreen({
    required this.farmId,
    required this.farmName,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ConsultFarmController(farmId));

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AppBarWidget(),
              SizedBox(height: 34.h),
              Container(
                height: 52.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: AppColors.surfaceGrey, width: 1),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      'assets/logos/sample.svg',
                      width: 24.w,
                      height: 24.h,
                    ),
                    SizedBox(width: 10.w),
                    Text(
                      farmName,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 34.h),

              /// Members List Section
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                final members = controller.members;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Farm Members (${members.length})',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          onPressed: controller.fetchMembers,
                          icon: const Icon(Icons.refresh),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    if (members.isEmpty)
                      Padding(
                        padding: EdgeInsets.only(top: 20.h),
                        child: Center(
                          child: Text(
                            'No members found',
                            style: TextStyle(
                              color: AppColors.textLightGrey,
                              fontSize: 14.sp,
                            ),
                          ),
                        ),
                      ),

                    for (var member in members) ...[
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(
                            AppRoutes.memberDetails,
                            arguments: {
                              'farmUserId': member.farmUserId,
                              'farmUserEmail': member.farmUserEmail,
                              'farmUserName':
                                  member.farmUserProfile?.name ?? '',
                              'joinedDate': controller.formatDate(
                                member.farmUserProfile?.joinedDate,
                              ),
                            },
                          );
                        },
                        child: Container(
                          height: 65.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColors.lightGrey,
                              width: 1.w,
                            ),
                            color: AppColors.surface,
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/logos/outlinePerson.svg',
                                width: 40.w,
                              ),
                              SizedBox(width: 12.w),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    member.farmUserProfile?.name ??
                                        'Unknown Name',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 4.h),
                                  Text(
                                    'Created on: ${controller.formatDate(member.farmUserProfile?.joinedDate)}',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: AppColors.textLightGrey,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              InkWell(
                                onTap:
                                    () => controller.deleteMember(
                                      member.memberId,
                                    ),
                                child: SvgPicture.asset(
                                  'assets/logos/trash.svg',
                                  width: 20.w,
                                  height: 20.h,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 16.h),
                    ],
                  ],
                );
              }),

              SizedBox(height: 200.h),
              TextButtonWidgetLight(
                text: 'Back To Home',
                onPressed: () {
                  Get.toNamed(AppRoutes.homeConsult);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
