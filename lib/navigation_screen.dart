// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_fonts.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_icons.dart';
import 'package:ibraheemaltamim_flutter/features/chat/presentation/chat_screen.dart';
import 'package:ibraheemaltamim_flutter/features/home/presentation/home_screen.dart';
import 'package:ibraheemaltamim_flutter/features/profile/presentation/profile_screen.dart';
import 'package:ibraheemaltamim_flutter/features/service/presentation/service_screen.dart';
import 'package:ibraheemaltamim_flutter/helpers/helper_methods.dart';

final class BottomNavBar extends StatefulWidget {
  final int? pageNum;
  const BottomNavBar({super.key, this.pageNum});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _currentIndex = 0;

  final List<StatefulWidget> _screens = [
    HomeScreen(),
    ServiceScreen(),
    ChatScreen(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.pageNum ?? 0; // Use the pageNum or default to 0
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        showMaterialDialog(context);
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _screens[_currentIndex],
        bottomNavigationBar: SizedBox(
          height: 70.h,
          child: CustomNavigationBar(
            iconSize: 24..sp,
            // strokeColor: AppColor.c0A5B55,
            // unSelectedColor: AppColor.c0A5B55,
            backgroundColor: Colors.white,
            items: [
              CustomNavigationBarItem(
                icon: _currentIndex == 0
                    ? SvgPicture.asset(AppIcons.home)
                    : SvgPicture.asset(AppIcons.home),
                title: Text(
                  'Home',
                  style: TextFontStyle.textStyle24RobotoW600.copyWith(
                    fontWeight: FontWeight.w500,
                    color: _currentIndex == 0
                        ? AppColor.blackColor
                        : AppColor.c03045E,
                    fontSize: 14.sp,
                    height: 1.2.h,
                    letterSpacing: 0,
                  ),
                ),
              ),
              CustomNavigationBarItem(
                icon: _currentIndex == 1
                    ? SvgPicture.asset(AppIcons.service)
                    : SvgPicture.asset(AppIcons.service),
                title: Text(
                  'Service',
                  style: TextFontStyle.textStyle24RobotoW600.copyWith(
                    fontWeight: FontWeight.w500,
                    color: _currentIndex == 1
                        ? AppColor.c03045E
                        : AppColor.c03045E,
                    fontSize: 14.sp,
                    height: 1.2.h,
                    letterSpacing: 0,
                  ),
                ),
              ),
              CustomNavigationBarItem(
                icon: _currentIndex == 2
                    ? SvgPicture.asset(AppIcons.chat)
                    : SvgPicture.asset(AppIcons.chat),
                title: Text(
                  'Chat',
                  style: TextFontStyle.textStyle24RobotoW600.copyWith(
                    fontWeight: FontWeight.w500,
                    color: _currentIndex == 2
                        ? AppColor.c03045E
                        : AppColor.c03045E,
                    fontSize: 14.sp,
                    height: 1.2.h,
                    letterSpacing: 0,
                  ),
                ),
              ),
              CustomNavigationBarItem(
                icon: _currentIndex == 3
                    ? SvgPicture.asset(AppIcons.profile)
                    : SvgPicture.asset(AppIcons.profile),
                title: Text(
                  'Profile',
                  style: TextFontStyle.textStyle24RobotoW600.copyWith(
                    fontWeight: FontWeight.w500,
                    color: _currentIndex == 3
                        ? AppColor.c03045E
                        : AppColor.c03045E,
                    fontSize: 14.sp,
                    height: 1.2.h,
                    letterSpacing: 0,
                  ),
                ),
              ),
            ],
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
