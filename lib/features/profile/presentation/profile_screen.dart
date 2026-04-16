import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_logout_widget.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/profile_avatar.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/user_info_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_delete_account_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    userInfoRxObj.fetchUserInfo();
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'N/A';
    try {
      DateTime dt = DateTime.parse(dateStr);
      String day = DateFormat('d').format(dt);
      String suffix = 'th';
      if (day.endsWith('1') && !day.endsWith('11'))
        suffix = 'st';
      else if (day.endsWith('2') && !day.endsWith('12'))
        suffix = 'nd';
      else if (day.endsWith('3') && !day.endsWith('13'))
        suffix = 'rd';

      return "DOB : $day$suffix ${DateFormat('MMM , yyyy').format(dt)}";
    } catch (e) {
      return dateStr;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              title: 'Profile',
              trailing: GestureDetector(
                onTap: () {
                  NavigationService.navigateToWithObject(
                    Routes.editProfileScreen,
                    userInfoRxObj.dataFetcher.value.data,
                  );
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
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildProfileHeader(),
                    SizedBox(height: 20.h),
                    _buildSettingsSection(),
                    SizedBox(height: 20.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Row(
                        children: [
                          Expanded(child: _buildSignOutButton()),
                          SizedBox(width: 15.w),
                          Expanded(child: _buildDeleteAccountButton()),
                        ],
                      ),
                    ),
                    SizedBox(height: 100.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return StreamBuilder<UserInfoModel>(
      stream: userInfoRxObj.dataFetcher.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting &&
            !snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = snapshot.data?.data;
        if (user == null) {
          return const SizedBox.shrink();
        }

        return Column(
          children: [
            ProfileAvatar(imageUrl: user.avatar, radius: 50),
            SizedBox(height: 15.h),
            Text(
              user.name ?? 'Guest',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColor.textColor,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              user.gender != null
                  ? user.gender![0].toUpperCase() + user.gender!.substring(1)
                  : 'Gender: N/A',
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.textColor.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              _formatDate(user.birthdate?.toString()),
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColor.textColor.withOpacity(0.8),
              ),
            ),
          ],
        );
      },
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
                  onTap: () {
                    NavigationService.navigateTo(Routes.notificationsScreen);
                  },
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.description_rounded,
                  title: 'Terms & Conditions',
                  onTap: () {
                    NavigationService.navigateTo(
                      Routes.termsAndConditionScreen,
                    );
                  },
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.lock_reset_rounded,
                  title: 'Change Password',
                  onTap: () {
                    NavigationService.navigateTo(Routes.changePasswordScreen);
                  },
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.ios_share_rounded,
                  title: 'Share The App',
                  onTap: () {
                    Share.share(
                      'Check out the Ibraheem Al Tamim app! Experience the best services at your fingertips. Download now: https://play.google.com/store/apps/details?id=com.ibraheemaltamim.app',
                      subject: 'Ibraheem Al Tamim App',
                    );
                  },
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.star_border_rounded,
                  title: 'Rate The App',
                  onTap: () {
                    if (Platform.isAndroid) {
                      _launchUrl(
                        'https://play.google.com/store/apps/details?id=com.ibraheemaltamim.app',
                      );
                    } else if (Platform.isIOS) {
                      _launchUrl('https://apps.apple.com/app/id[YOUR_APP_ID]');
                    }
                  },
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.lock_outline_rounded,
                  title: 'Privacy',
                  onTap: () {
                    NavigationService.navigateTo(Routes.privacyScreen);
                  },
                ),
                _buildDivider(),
                _buildSettingItem(
                  title: 'App Version',
                  trailing: Text(
                    '1.0.0',
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

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      ToastUtil.showShortToast('Could not launch $url');
    }
  }

  Widget _buildSignOutButton() {
    return SizedBox(
      height: 55.h,
      child: OutlinedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => CustomLogoutWidget(),
          );
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
    );
  }
  

  _buildDeleteAccountButton() {
    return SizedBox(
      height: 55.h,
      child: OutlinedButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            builder: (context) => const CustomDeleteAccountWidget(),
          );
        },
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.redAccent, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.r),
          ),
        ),
        child: Text(
          'Delete Account',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
