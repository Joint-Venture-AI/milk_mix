import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/controllers/history_controller.dart';
import 'package:milk_mix/view/widget/history_tile.dart';

class HistoryListWidget extends StatefulWidget {
  const HistoryListWidget({super.key});

  @override
  State<HistoryListWidget> createState() => _HistoryListWidgetState();
}

class _HistoryListWidgetState extends State<HistoryListWidget> {
  @override
  void didChangeDependencies() {
    final HistoryController controller = Get.put(HistoryController());
    controller.refreshHistory();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final HistoryController controller = Get.put(HistoryController());

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: controller.refreshHistory,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'history'.tr,
                        style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Obx(
                        () => Text(
                          '${controller.totalCalculations} ${'calculations'.tr}',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Spacer(),
                  // GestureDetector(
                  //   onTap: () => _showClearHistoryDialog(controller),
                  //   child: Container(
                  //     height: 36.h,
                  //     width: 90.h,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(color: Color(0xFFD96346), width: 1),
                  //       borderRadius: BorderRadius.circular(5.r),
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.center,
                  //       children: [
                  //         SvgPicture.asset('assets/logos/trash.svg'),
                  //         SizedBox(width: 9.w),
                  //         Text(
                  //           'clear'.tr,
                  //           style: TextStyle(
                  //             fontSize: 14.sp,
                  //             fontWeight: FontWeight.w500,
                  //             color: Color(0xFFD96346),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 10.h),

              // Loading state
              Obx(() {
                if (controller.isLoading.value) {
                  return Container(
                    height: 200.h,
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    ),
                  );
                }

                // Error state
                if (controller.hasError.value) {
                  return Container(
                    height: 200.h,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline,
                            size: 48.sp,
                            color: Colors.red,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            controller.errorMessage.value,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ElevatedButton(
                            onPressed: controller.refreshHistory,
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // Empty state
                if (controller.historyList.isEmpty) {
                  return Container(
                    height: 200.h,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.history, size: 48.sp, color: Colors.grey),
                          SizedBox(height: 16.h),
                          Text(
                            'No history found',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                // History list
                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.historyList.length,
                  itemBuilder: (context, index) {
                    final history = controller.getSortedHistory()[index];
                    return HistoryTile(
                      // number: 'FRY',
                      number: controller.getWeekDayName(history.createdAt),
                      volume: '${history.totalVolume}',
                      date: controller.formatDate(history.createdAt),
                      time: controller.formatTime(history.createdAt),
                      historyData: history,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _showClearHistoryDialog(HistoryController controller) {
    Get.dialog(
      AlertDialog(
        title: Text('Clear History'),
        content: Text(
          'Are you sure you want to clear all history? This action cannot be undone.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: Text('Cancel')),
          TextButton(
            onPressed: () {
              Get.back();
              controller.clearHistoryFromServer();
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: Text('Clear'),
          ),
        ],
      ),
    );
  }
}
