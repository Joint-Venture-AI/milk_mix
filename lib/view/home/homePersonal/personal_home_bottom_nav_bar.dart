import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:milk_mix/constants/color.dart';
import 'package:milk_mix/view/home/calculate/calculate_screen.dart';
import 'package:milk_mix/view/home/history/history_screen.dart';
import 'package:milk_mix/view/home/members/members_screen.dart';
import 'package:milk_mix/view/home/settings/setting_screen.dart';

class PersonalHomeBottomNavBar extends StatefulWidget {
  const PersonalHomeBottomNavBar({super.key});

  @override
  State<PersonalHomeBottomNavBar> createState() => _MainPageState();
}

class _MainPageState extends State<PersonalHomeBottomNavBar> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CalculateScreen(),
    HistoryScreen(),
    MembersScreen(),
    SettingScreen(),
  ];

  BottomNavigationBarItem _navIcon({
    required String title,
    required String icon,
    required int index,
  }) {
    return BottomNavigationBarItem(
      icon: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            icon,
            colorFilter: ColorFilter.mode(
              _currentIndex == index
                  ? AppColors.primary
                  : AppColors.textLightGrey,
              BlendMode.srcIn,
            ),
            height: 20.sp,
          ),
          SizedBox(height: 4.h),
        ],
      ),
      label: title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: _screens[_currentIndex]),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 8.h),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textLightGrey,
          selectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelStyle: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
          onTap: (index) => setState(() => _currentIndex = index),
          iconSize: 25.sp,
          items: [
            _navIcon(
              title: 'Calculate',
              icon: 'assets/logos/calculate.svg',
              index: 0,
            ),
            _navIcon(
              title: 'History',
              icon: 'assets/logos/history_h.svg',
              index: 1,
            ),
            _navIcon(
              title: 'Members',
              icon: 'assets/logos/members.svg',
              index: 2,
            ),
            _navIcon(
              title: 'Settings',
              icon: 'assets/logos/settings.svg',
              index: 3,
            ),
          ],
          backgroundColor: AppColors.surface,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
