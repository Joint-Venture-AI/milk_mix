import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/manage_farm_controller.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/model/search_farm_response.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';

class AddFarmScreen extends StatefulWidget {
  const AddFarmScreen({super.key});

  @override
  State<AddFarmScreen> createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  Farm? selectedFarm;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final AddFarmController farmController = Get.put(AddFarmController());
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBarWidget(),
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'joinFarm'.tr,
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Manage member and histories',
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
              SizedBox(height: 30.h),
              Text(
                'Add Farm',
                style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 6.h),
              TypeAheadField<Farm>(
                suggestionsCallback: (search) async {
                  final res = await ApiProvider.instance.consultants
                      .searchFarms(query: search);
                  return res.data?.data ?? [];
                },
                builder: (context, controller, focusNode) {
                  return TextField(
                    controller: controller,
                    focusNode: focusNode,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Farm User Name',
                      hintStyle: TextStyle(
                        color: AppColors.textLightGrey,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(12.w),
                        child: SvgPicture.asset(
                          'assets/logos/at.svg',
                          width: 18.w,
                          height: 18.h,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      prefixIconConstraints: BoxConstraints(
                        minWidth: 40.w,
                        minHeight: 40.h,
                      ),
                    ),
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 14.sp,
                    ),
                  );
                },
                itemBuilder: (context, farm) {
                  final farmName = farm.profile?.farmName ?? '';
                  final farmId = farm.id;
                  return ListTile(
                    tileColor: Colors.white,
                    dense: true,
                    title: Text(
                      farmName,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    leading: SvgPicture.asset(
                      'assets/logos/sample.svg',
                      width: 24.w,
                      height: 24.h,
                    ),
                    subtitle:
                        farmId.toString().isNotEmpty
                            ? Text('ID: $farmId')
                            : null,
                  );
                },
                onSelected: (value) {
                  setState(() {
                    selectedFarm = value;
                  });
                },
              ),
              SizedBox(height: 26.h),
              if (selectedFarm == null)
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 6.w),
                          SvgPicture.asset(
                            'assets/logos/i.svg',
                            width: 15.w,
                            color: AppColors.textPrimary,
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            'How to join a farm?',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '  •  Ask farm owner / manager for username',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '  •  Search username here',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '  •  Join the farm',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              if (selectedFarm != null)
                Container(
                  padding: EdgeInsets.all(10.r),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Selected Farm',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          SizedBox(width: 6.w),
                          SvgPicture.asset(
                            'assets/logos/sample.svg',
                            width: 24.w,
                            height: 24.h,
                          ),
                          SizedBox(width: 12.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                selectedFarm?.profile?.farmName ?? 'Farm Name',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                'ID: ${selectedFarm?.id ?? 'N/A'}',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.6),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              Spacer(),
              TextWidgetButton(
                text: isLoading ? 'Adding...' : '+  Add Farm (\$25/farm)',
                onPressed:
                    selectedFarm == null
                        ? null
                        : () async {
                          if (isLoading) return;
                          setState(() {
                            isLoading = true;
                          });
                          final profileResult =
                              await ApiProvider.instance.auth.getProfile();
                          final consultantId = profileResult.data?.id;
                          if (consultantId == null) return;
                          final farmId = selectedFarm?.id;
                          if (farmId == null) return;
                          final joinResult = await ApiProvider
                              .instance
                              .consultants
                              .joinRequest(
                                farmId: farmId,
                                consultantId: consultantId,
                              );
                          setState(() {
                            isLoading = false;
                          });
                          // Show success message on bottom
                          if (joinResult.isSuccess) {
                            Get.snackbar(
                              'Success',
                              'Farm request sent successfully.',
                              backgroundColor: Colors.green.withOpacity(0.6),
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 2),
                            );
                            Get.find<ManageFarmController>()
                                .fetchAcceptedFarms();
                            Get.find<ManageFarmController>()
                                .fetchPendingRequests();
                          } else {
                            Get.snackbar(
                              'Error',
                              'Failed to send farm request.',
                              backgroundColor: Colors.red.withOpacity(0.6),
                              snackPosition: SnackPosition.BOTTOM,
                              duration: Duration(seconds: 2),
                            );
                          }
                        },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
