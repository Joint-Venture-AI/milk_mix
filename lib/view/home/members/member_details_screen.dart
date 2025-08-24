import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/data_source/api_service.dart';
import 'package:milk_mix/view/widget/appbar_widget.dart';
import 'package:milk_mix/view/widget/history_tile.dart';

class MemberDetailsScreen extends StatelessWidget {
  final int memberId;
  final int farmId;
  const MemberDetailsScreen({
    required this.memberId,
    required this.farmId,
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
                'John deo',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                textAlign: TextAlign.center,
                'sample@gmail.com',
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
                    'May 20, 2025',
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
                future: ApiService().milkHistory.getMilkHistoryByUser(memberId),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  final historyList = snapshot.data?.data ?? [];
                  if (historyList.isEmpty) {
                    return Center(child: Text('No history available'));
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: historyList.length,
                    itemBuilder: (context, index) {
                      final history = historyList[index];
                      return HistoryTile(
                        number: (index + 1).toString().padLeft(2, '0'),
                        volume: '0',
                        date: '',
                        time: '',
                      );
                    },
                  );
                  // return Column(
                  //   children:
                  //       historyList
                  //           .map(
                  //             (history) => HistoryTile(
                  //               number: history.id.toString(),
                  //               volume: history. volume.toString(),
                  //               date: history.date,
                  //               time: history.time,
                  //             ),
                  //           )
                  //           .toList(),
                  // );
                },
              ),
              // HistoryTile(
              //   number: '01',
              //   volume: '1500',
              //   date: '06-7-25',
              //   time: '10:30 AM',
              // ),
              // HistoryTile(
              //   number: '01',
              //   volume: '1500',
              //   date: '06-7-25',
              //   time: '10:30 AM',
              // ),
              // HistoryTile(
              //   number: '01',
              //   volume: '1500',
              //   date: '06-7-25',
              //   time: '10:30 AM',
              // ),
              // HistoryTile(
              //   number: '01',
              //   volume: '1500',
              //   date: '06-7-25',
              //   time: '10:30 AM',
              // ),
              // HistoryTile(
              //   number: '01',
              //   volume: '1500',
              //   date: '06-7-25',
              //   time: '10:30 AM',
              // ),
              // HistoryTile(
              //   number: '01',
              //   volume: '1500',
              //   date: '06-7-25',
              //   time: '10:30 AM',
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
