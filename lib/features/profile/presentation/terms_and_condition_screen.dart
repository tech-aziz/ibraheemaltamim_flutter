import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_fonts.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';

class TermsAndConditionScreen extends StatelessWidget {
  const TermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CustomAppbar(title: 'Terms & Conditions'),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UIHelper.verticalSpace(24.h),
                    _buildSection(
                      '1. Acceptance of Terms',
                      'By accessing and using Publication Hub, you agree to be bound by these Terms of Service. If you do not agree to these terms, please do not use the application.',
                    ),
                    _buildSection(
                      '2. User Obligations',
                      'Users are responsible for maintaining the confidentiality of their account information and for all activities that occur under their account. You agree to use the platform only for lawful purposes.',
                    ),
                    _buildSection(
                      '3. Intellectual Property',
                      'All content provided on Publication Hub, including text, graphics, logos, and software, is the property of Publication Hub and is protected by copyright laws.',
                    ),
                    _buildSection(
                      '4. Termination',
                      'We reserve the right to terminate or suspend access to our platform immediately, without prior notice or liability, for any reason whatsoever.',
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
