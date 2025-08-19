import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/data_source/api_service.dart';
import 'package:milk_mix/model/search_farm_response.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/text_button_widget.dart';
import 'package:milk_mix/controllers/add_farm_controller.dart';

class AddFarmScreen extends StatefulWidget {
  const AddFarmScreen({super.key});

  @override
  State<AddFarmScreen> createState() => _AddFarmScreenState();
}

class _AddFarmScreenState extends State<AddFarmScreen> {
  Farm? selectedFarm;

  @override
  Widget build(BuildContext context) {
    // final AddFarmController farmController = Get.put(AddFarmController());
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
                  final res = await ApiService.instance.consultants.searchFarms(
                    query: search,
                  );
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
                  final farmName = farm.profile?.name ?? '';
                  final farmId = farm.id;
                  return ListTile(
                    title: Text(farmName),
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
              SizedBox(height: 280.h),
              TextWidgetButton(
                text: '+  Add Farm (\$25/farm)',
                onPressed:
                    selectedFarm == null
                        ? null
                        : () async {
                          final profileResult =
                              await ApiService.instance.auth.getProfile();
                          final consultantId = profileResult.data?.id;
                          if (consultantId == null) return;
                          final farmId = selectedFarm?.id;
                          if (farmId == null) return;
                          await ApiService.instance.consultants.joinRequest(
                            farmId: farmId,
                            consultantId: consultantId,
                          );
                        },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
