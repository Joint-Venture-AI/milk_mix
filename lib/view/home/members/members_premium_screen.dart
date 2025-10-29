import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/member_controller.dart';
import 'package:milk_mix/controllers/profile_controller.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/model/pending_consultant_request_response.dart';
import 'package:milk_mix/routes.dart';
import 'package:milk_mix/view/widget/profile_image_circle.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget_light.dart';

class MembersPremiumScreen extends StatefulWidget {
  const MembersPremiumScreen({super.key});

  @override
  State<MembersPremiumScreen> createState() => _MembersPremiumScreenState();
}

class _MembersPremiumScreenState extends State<MembersPremiumScreen> {
  final memberController = Get.put<MemberController>(MemberController());
  final profileController = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    memberController.fetchMembers();
    memberController.fetchConsultants();
    memberController.getPendingRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'manageUser'.tr,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'createAndManageYourTeam'.tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ],
                  ),
                  SvgPicture.asset('assets/logos/i.svg', width: 20.w),
                ],
              ),
              SizedBox(height: 24.h),
              Obx(() {
                return Container(
                  height: 86.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.lightGrey, width: 1.w),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(14.r),
                    child: Container(
                      color: AppColors.shade,
                      child: Row(
                        children: [
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'coreUser'.tr,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textGrey,
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  profileController.farmName.value,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // copy farm email to clipboard
                              Clipboard.setData(
                                ClipboardData(
                                  text: profileController.name.value,
                                ),
                              );
                              Get.snackbar(
                                'Copied',
                                'Farm name copied to clipboard',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.green[100],
                                colorText: Colors.green[900],
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/logos/copy.svg',
                              height: 20.h,
                            ),
                          ),
                          SizedBox(width: 12.w),
                        ],
                      ),
                    ),
                  ),
                );
              }),
              SizedBox(height: 28.h),
              Obx(() {
                final isLoading =
                    memberController.getPendingRequestIsLoading.value;
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  children: <Widget>[
                    ...memberController.pendingRequests.map((request) {
                      return PendingRequestCard(request: request);
                    }),
                  ],
                );
              }),
              SizedBox(height: 24.h),
              // farm members list
              Obx(() {
                final count = memberController.members.length;
                return Row(
                  children: [
                    Text(
                      '${'farmMembers'.tr}'
                      ' ($count)',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Spacer(),

                    /// refresh button
                    IconButton(
                      onPressed: () {
                        memberController.fetchMembers();
                      },
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                );
              }),
              Obx(() {
                final isLoading = memberController.fetchMemberIsLoading.value;
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final members = memberController.members;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: members.length,
                  itemBuilder: (context, index) {
                    final member = members[index];
                    String? utcString = member.farmUserProfile?.joinedDate;
                    DateTime? utcDateTime = DateTime.tryParse(utcString ?? '');
                    DateTime? localDateTime = utcDateTime?.toLocal();
                    String formatted =
                        localDateTime != null
                            ? DateFormat("MMM dd, yyyy").format(localDateTime)
                            : '';
                    //
                    return Column(
                      children: [
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
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
                                      member.farmUserProfile?.name ?? '',
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      'Joined on $formatted',
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
                                      backgroundColor: Colors.white,
                                      buttonColor: AppColors.primary,
                                      middleText:
                                          "Are you sure you want to delete this member?",
                                      textCancel: "Cancel",
                                      textConfirm: "Delete",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () async {
                                        Get.back(); // close dialog before making API call
                                        print(
                                          'Deleting member with ID: ${member.memberId}',
                                        );
                                        final result = await ApiProvider()
                                            .farmMembers
                                            .deleteMember(
                                              memberId: member.memberId!,
                                            );

                                        if (result.isSuccess) {
                                          Get.snackbar(
                                            'Success',
                                            'Member deleted successfully',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );

                                          memberController.fetchMembers();
                                        } else {
                                          Get.snackbar(
                                            'Error',
                                            'Failed to delete member',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        }
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
                      ],
                    );
                  },
                );
              }),
              SizedBox(height: 24.h),
              // farm consultants list
              Obx(() {
                final count = memberController.consultants.length;
                return Row(
                  children: [
                    Text(
                      'Farm Consultants'
                      ' ($count)',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Spacer(),

                    /// refresh button
                    IconButton(
                      onPressed: () {
                        memberController.fetchConsultants();
                      },
                      icon: Icon(Icons.refresh),
                    ),
                  ],
                );
              }),
              Obx(() {
                final isLoading =
                    memberController.fetchConsultantIsLoading.value;
                if (isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final consultants = memberController.consultants;
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: consultants.length,
                  itemBuilder: (context, index) {
                    final consultant = consultants[index];
                    return Column(
                      children: [
                        SizedBox(height: 16.h),
                        GestureDetector(
                          onTap: () {
                            // Get.toNamed(
                            //   AppRoutes.memberDetails,
                            //   arguments: {
                            //     'farmUserId': member.farmUserId,
                            //     'farmUserEmail': member.farmUserEmail,
                            //     'farmUserName':
                            //         member.farmUserProfile?.name ?? '',
                            //     'joinedDate': formatted,
                            //   },
                            // );
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
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        consultant.consultantName ?? '',
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      SizedBox(height: 4.h),
                                      Text(
                                        'Email: ${consultant.consultantEmail}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.textLightGrey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Spacer(),
                                InkWell(
                                  onTap: () async {
                                    if (consultant.id == null) return;

                                    Get.defaultDialog(
                                      title: "Confirm Delete",
                                      backgroundColor: Colors.white,
                                      buttonColor: AppColors.primary,
                                      middleText:
                                          "Are you sure you want to delete this consultant?",
                                      textCancel: "Cancel",
                                      textConfirm: "Delete",
                                      confirmTextColor: Colors.white,
                                      onConfirm: () async {
                                        Get.back(); // close dialog before making API call
                                        print(
                                          'Deleting consultant with ID: ${consultant.id}',
                                        );
                                        final result = await ApiProvider()
                                            .consultants
                                            .deleteConsultantFromFarm(
                                              consultantId: consultant.id!,
                                            );

                                        if (result.isSuccess) {
                                          Get.snackbar(
                                            'Success',
                                            'Consultant deleted successfully',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );

                                          memberController.fetchConsultants();
                                        } else {
                                          Get.snackbar(
                                            'Error',
                                            'Failed to delete consultant',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                        }
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
                      ],
                    );
                  },
                );
              }),

              // SizedBox(height: 16.h),
              // GestureDetector(
              //   onTap: () {
              //     Get.toNamed(AppRoutes.memberDetails);
              //   },
              //   child: Container(
              //     height: 65.h,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(10.r),
              //       border: Border.all(color: AppColors.lightGrey, width: 1.w),
              //       color: AppColors.surface,
              //     ),
              //     padding: EdgeInsets.symmetric(horizontal: 16.w),
              //     child: Row(
              //       children: [
              //         SvgPicture.asset(
              //           'assets/logos/outlinePerson.svg',
              //           width: 40.w,
              //         ),
              //         SizedBox(width: 12.w),
              //         Column(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           crossAxisAlignment: CrossAxisAlignment.start,
              //           children: [
              //             Text(
              //               'Danial Smith',
              //               style: TextStyle(
              //                 fontSize: 16.sp,
              //                 fontWeight: FontWeight.w600,
              //                 color: AppColors.textPrimary,
              //               ),
              //             ),
              //             SizedBox(height: 4.h),
              //             Text(
              //               '${'createdOn'.tr} May 23, 2025',
              //               style: TextStyle(
              //                 fontSize: 14.sp,
              //                 fontWeight: FontWeight.w400,
              //                 color: AppColors.textLightGrey,
              //               ),
              //             ),
              //           ],
              //         ),
              //         Spacer(),
              //         SvgPicture.asset(
              //           'assets/logos/trash.svg',
              //           width: 20.w,
              //           height: 20.h,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 40.h),
              TextWidgetButton(
                text:
                    '+  '
                    '${'addMember'.tr}',
                onPressed: () {
                  Get.toNamed(AppRoutes.addMember);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PendingRequestCard extends StatelessWidget {
  final PendingConsultantRequest request;
  const PendingRequestCard({required this.request, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.lightGrey),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              // SvgPicture.asset(
              //   'assets/logos/avater.svg',
              //   width: 40.w,
              //   height: 40.w,
              // ),
              ProfileImageCircle(
                image: request.farmProfilePicture ?? '',
                size: 40,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      request.farmName ?? '',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      "wantsToJoinAsConsultant".tr,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: TextButtonWidgetLight(
                  text: 'dismiss'.tr,
                  onPressed: () {},
                ),
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Obx(() {
                  final isLoading =
                      Get.find<MemberController>()
                          .acceptConsultantRequestIsLoading
                          .value;
                  return TextWidgetButton(
                    text: isLoading ? 'Loading...' : 'accept'.tr,
                    onPressed: () async {
                      final controller = Get.find<MemberController>();
                      if (request.id == null) return;
                      if (controller.acceptConsultantRequestIsLoading.value) {
                        return;
                      }

                      await controller.acceptConsultantRequest(request.id!);
                      controller.fetchConsultants();
                    },
                  );
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
