import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/data_source/api/provider/api_provider.dart';
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
                      final date = DateTime.tryParse(history.createdAt ?? '');
                      final formattedDate = DateFormat(
                        'yyyy-MM-dd',
                      ).format(date!);
                      final formattedTime = DateFormat('hh:mm a').format(date);
                      return HistoryTile(
                        number: (index + 1).toString().padLeft(2, '0'),
                        volume: history.totalVolume ?? '',
                        date: formattedDate,
                        time: formattedTime,
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
