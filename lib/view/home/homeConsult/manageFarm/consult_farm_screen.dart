import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
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
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBarWidget(),
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
              FutureBuilder(
                future: ApiProvider().farmMembers.getAllMembers(farmId: farmId),
                builder: (context, snapshot) {
                  final members = snapshot.data?.data?.data ?? [];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Farm Members (${members.length})',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      for (var member in members) ...[
                        GestureDetector(
                          onTap: () {
                            String? utcString =
                                member.farmUserProfile?.joinedDate;
                            DateTime? utcDateTime = DateTime.tryParse(
                              utcString ?? '',
                            );
                            DateTime? localDateTime = utcDateTime?.toLocal();
                            String formatted =
                                localDateTime != null
                                    ? DateFormat(
                                      "MMM dd, yyyy",
                                    ).format(localDateTime)
                                    : '';
                            Get.toNamed(
                              AppRoutes.memberDetails,
                              arguments: {
                                'farmUserId': member.farmUserId,
                                'farmUserEmail': member.farmUserEmail,
                                'farmUserName':
                                    member.farmUserProfile?.name ?? '',
                                'joinedDate': formatted,
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
                                      // 'Created on: May 23, 2025',
                                      'Created on: ${DateFormat('MMM dd, yyyy').format(DateTime.parse(member.farmUserProfile?.joinedDate ?? ''))}',
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.textLightGrey,
                                      ),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                InkWell(
                                  onTap: () async {
                                    if (member.memberId == null) return;

                                    Get.defaultDialog(
                                      title: "Confirm Delete",
                                      middleText:
                                          "Are you sure you want to delete this member?",
                                      textCancel: "Cancel",
                                      textConfirm: "Delete",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () async {
                                        Get.back(); // close dialog before making API call

                                        // final result = await ApiService()
                                        //     .farmMembers
                                        //     .deleteMember(
                                        //       memberId: member.memberId!,
                                        //     );

                                        // if (result.isSuccess) {
                                        //   Get.snackbar(
                                        //     'Success',
                                        //     'Member deleted successfully',
                                        //   );
                                        // } else {
                                        //   Get.snackbar(
                                        //     'Error',
                                        //     'Failed to delete member',
                                        //   );
                                        // }
                                      },
                                    );
                                  },
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
                },
              ),

              //
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
