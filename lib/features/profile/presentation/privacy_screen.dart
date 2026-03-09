import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_fonts.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CustomAppbar(title: 'Privacy Policy'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpace(24.h),
                    _buildSection(
                      '1. Data Collection',
                      'We collect personal information that you provide to us directly, such as your name and email address, when you register for an account.',
                    ),
                    _buildSection(
                      '2. Use of Information',
                      'The information we collect is used to provide and improve our services, communicate with you, and personalize your experience.',
                    ),
                    _buildSection(
                      '3. Data Protection',
                      'We implement industry-standard security measures to protect your personal data from unauthorized access, disclosure, or destruction.',
                    ),
                    _buildSection(
                      '4. Third-Party Services',
                      'We do not sell your personal information to third parties. We may use third-party service providers to help us operate our platform.',
                    ),
                    UIHelper.verticalSpace(40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textColor,
          ),
        ),
        UIHelper.verticalSpace(8.h),
        Text(
          content,
          style: TextFontStyle.textStyle14InterW400.copyWith(
            fontSize: 14.sp,
            color: AppColor.textColor.withOpacity(0.7),
            height: 1.5,
          ),
        ),
        UIHelper.verticalSpace(24.h),
      ],
    );
  }
}
