import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbar(
                title: 'Profile',
                trailing: GestureDetector(
                  onTap: () {
                    NavigationService.navigateTo(Routes.editProfileScreen);
                  },
                  child: Icon(
                    Icons.edit_note_outlined,
                    color: AppColor.textColor,
                    size: 28.sp,
                  ),
                ),
                onTap: () {
                  NavigationService.navigateToWithArgs(Routes.navbar, {
                    "pageNum": 0,
                  });
                },
              ),
              // SizedBox(height: 20.h),
              _buildProfileHeader(),
              SizedBox(height: 20.h),
              _buildSettingsSection(),
              SizedBox(height: 20.h),
              _buildSignOutButton(),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        CircleAvatar(
          radius: 50.r,
          backgroundImage: const AssetImage('assets/images/person.png'),
        ),
        SizedBox(height: 15.h),
        Text(
          'Jenny Wilson',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Female',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColor.textColor.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'DOB : 25th Aug , 1990',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColor.textColor.withOpacity(0.8),
          ),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'APP SETTINGS',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.textColor,
            ),
          ),
          SizedBox(height: 10.h),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Column(
              children: [
                _buildSettingItem(
                  icon: Icons.notifications_rounded,
                  title: 'Notifications',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.description_rounded,
                  title: 'Terms & Conditions',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.ios_share_rounded,
                  title: 'Share The App',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.star_border_rounded,
                  title: 'Rate The App',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.lock_outline_rounded,
                  title: 'Privacy',
                  onTap: () {},
                ),
                _buildDivider(),
                _buildSettingItem(
                  title: 'App Version',
                  trailing: Text(
                    '1.2.3',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColor.textColor.withOpacity(0.6),
                    ),
                  ),
                  showChevron: false,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    IconData? icon,
    required String title,
    VoidCallback? onTap,
    Widget? trailing,
    bool showChevron = true,
  }) {
    return ListTile(
      onTap: onTap,
      leading: icon != null
          ? Icon(icon, color: AppColor.textColor, size: 24.sp)
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: AppColor.textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          trailing ??
          (showChevron
              ? Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18.sp,
                  color: AppColor.textColor,
                )
              : null),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 0.5,
      indent: 15.w,
      endIndent: 15.w,
      color: Colors.grey.withOpacity(0.2),
    );
  }

  Widget _buildSignOutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: SizedBox(
        width: double.infinity,
        height: 55.h,
        child: OutlinedButton(
          onPressed: () {
            NavigationService.navigateToReplacement(Routes.loginScreen);
            ToastUtil.showShortToast("Signed out Successfully");
          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColor.textColor, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
          child: Text(
            'Sign Out',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.textColor,
            ),
          ),
        ),
      ),
    );
  }
}
