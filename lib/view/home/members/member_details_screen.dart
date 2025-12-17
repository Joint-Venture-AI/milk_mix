import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
import 'package:milk_mix/model/get_milk_history_response.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/history_tile.dart';

class MemberDetailsScreen extends StatelessWidget {
  final int farmUserId;
  final String? farmUserEmail;
  final String? farmUserName;
  final String? joinedDate;
  const MemberDetailsScreen({
    this.farmUserEmail,
    this.farmUserName,
    this.joinedDate,
    required this.farmUserId,
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

              SvgPicture.asset('assets/logos/avater.svg', height: 60.h),
              SizedBox(height: 14.h),
              Text(
                textAlign: TextAlign.center,
                farmUserName ?? '',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                textAlign: TextAlign.center,
                farmUserEmail ?? '',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textLightGrey,
                ),
              ),
              SizedBox(height: 14.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/logos/date.svg',
                    height: 16.h,
                    color: AppColors.primary,
                  ),
                  SizedBox(width: 3.w),
                  Text(
                    textAlign: TextAlign.center,
                    joinedDate ?? '',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              Container(
                height: 1.h,
                width: double.infinity,
                color: AppColors.lightGrey,
              ),
              SizedBox(height: 35.h),
              Text(
                textAlign: TextAlign.start,
                'Mix History',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              FutureBuilder(
                future: ApiProvider().milkHistory.getMilkHistoryByUser(
                  farmUserId,
                ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final historyList = snapshot.data?.data ?? [];
                  if (historyList.isEmpty) {
                    return Column(
                      children: [
                        SizedBox(height: 80.h),
                        Center(
                          child: Text(
                            'No history available',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textLightGrey,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final history = historyList[index];
                      return HistoryTile(
                        number: getWeekDayName(history.createdAt),
                        volume: '${history.totalVolume}',
                        date: formatDate(history.createdAt),
                        time: formatTime(history.createdAt),
                        historyData: history,
                      );
                    },
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

// Format date for display
String formatDate(String? dateString) {
  if (dateString == null) return '';
  try {
    final date = DateTime.parse(dateString).toLocal();
    return '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year.toString().padLeft(2, '0')}';
  } catch (e) {
    return dateString;
  }
}

// Format time for display
String formatTime(String? dateString) {
  if (dateString == null) return '';
  try {
    final date = DateTime.parse(dateString).toLocal();
    final hour = date.hour;
    final minute = date.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '${displayHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  } catch (e) {
    return '';
  }
}

// Get total volume for a history item
String getTotalVolume(GetMilkHistoryData history) {
  if (history.totalVolume != null) {
    return history.totalVolume!;
  }

  // Calculate total volume if not provided
  final bottleSize = history.bottleSize ?? 0;
  final numberOfBottles = history.numberOfBottles ?? 0;
  final total = bottleSize * numberOfBottles;
  return '${total.toStringAsFixed(0)} ml';
}

String getWeekDayName(String? dateString) {
  try {
    final date = DateTime.parse(dateString ?? '').toLocal();
    return DateFormat('EEE').format(date).toUpperCase();
  } catch (e) {
    return '';
  }
}
