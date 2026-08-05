import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_logout_widget.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_delete_account_widget.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class CordinatorProfileScreen extends StatefulWidget {
  const CordinatorProfileScreen({super.key});

  @override
  State<CordinatorProfileScreen> createState() =>
      _CordinatorProfileScreenState();
}

class _CordinatorProfileScreenState extends State<CordinatorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xffD6F2FB,
      ), // Matching light blue background
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      NavigationService.navigateToReplacement(
                        Routes.coordinatorHomeScreen,
                      );
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(
                          0xffBCE8F7,
                        ), // slightly darker blue background
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: const Color(0xff03045E),
                        size: 20.sp,
                      ),
                    ),
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                      color: const Color(0xff03045E),
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to edit profile with mock representation
                      NavigationService.navigateTo(Routes.editProfileScreen);
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(
                          0xffBCE8F7,
                        ), // slightly darker blue background
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.edit_note_outlined,
                        color: const Color(0xff03045E),
                        size: 24.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                    _buildProfileHeader(),
                    SizedBox(height: 30.h),
                    _buildSettingsSection(),
                    SizedBox(height: 30.h),
                    Row(
                      children: [
                        Expanded(child: _buildSignOutButton()),
                        SizedBox(width: 15.w),
                        Expanded(child: _buildDeleteAccountButton()),
                      ],
                    ),
                    SizedBox(
                      height: 120.h,
                    ), // Extra scrolling space for navbar overlay
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
    const String name = 'Jenny Wilson';
    const String gender = 'Female';
    const String avatar =
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop';
    const String dobStr = 'DOB : 25th Aug , 1990';

    return Column(
      children: [
        Container(
          width: 100.w,
          height: 100.w,
          decoration: const BoxDecoration(
            color: Color(0xffBCE8F7),
            shape: BoxShape.circle,
          ),
          child: ClipOval(
            child: Image.network(
              avatar,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/placeholder.jpg',
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        SizedBox(height: 15.h),
        Text(
          name,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xff03045E),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          gender,
          style: TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
        ),
        SizedBox(height: 4.h),
        Text(
          dobStr,
          style: TextStyle(fontSize: 15.sp, color: Colors.grey.shade600),
        ),
      ],
    );
  }

  Widget _buildSettingsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'APP SETTINGS',
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xff03045E),
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            children: [
              _buildSettingItem(
                icon: Icons.notifications_none_rounded,
                title: 'Notifications',
                onTap: () {
                  NavigationService.navigateTo(Routes.notificationsScreen);
                },
              ),
              _buildDivider(),
              _buildSettingItem(
                icon: Icons.description_outlined,
                title: 'Terms & Conditions',
                onTap: () {
                  NavigationService.navigateTo(Routes.termsAndConditionScreen);
                },
              ),
              _buildDivider(),
              _buildSettingItem(
                icon: Icons.ios_share_outlined,
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
                  '1.2.3',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey.shade500,
                  ),
                ),
                showChevron: false,
              ),
            ],
          ),
        ),
      ],
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
      dense: true,
      leading: icon != null
          ? Icon(icon, color: const Color(0xff03045E), size: 22.sp)
          : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: 15.sp,
          color: const Color(0xff03045E),
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing:
          trailing ??
          (showChevron
              ? Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16.sp,
                  color: const Color(0xff03045E),
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
      color: Colors.grey.shade100,
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
      height: 52.h,
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
          side: const BorderSide(color: Color(0xff03045E), width: 1.5),
          backgroundColor: const Color(0xffD6F2FB),
          foregroundColor: const Color(0xff03045E),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Sign Out',
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildDeleteAccountButton() {
    return SizedBox(
      height: 52.h,
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
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          'Delete Account',
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
      ),
    );
  }
}
