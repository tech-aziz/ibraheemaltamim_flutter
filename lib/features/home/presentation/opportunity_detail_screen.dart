import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_icons.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';

class OpportunityDetailScreen extends StatefulWidget {
  const OpportunityDetailScreen({super.key});

  @override
  State<OpportunityDetailScreen> createState() =>
      _OpportunityDetailScreenState();
}

class _OpportunityDetailScreenState extends State<OpportunityDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // ------------custom appbar start -----------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                CustomAppbar(
                  title: 'Opportunity Details',
                  onTap: () {
                    NavigationService.goBack;
                  },
                ),
              ],
            ),

            // ------------custom appbar end-----------

            // ------------ details information start--------
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      UIHelper.verticalSpace(10.h),
                      // 1. Top Card Component
                      _buildProfileCard(),
                      SizedBox(height: 30.h),

                      // 2. Title & Chips
                      Text(
                        'Assessing the Efficacy and Safety of Malaria Prevention and Treatment Strategies: A Systematic Review and Meta-Analysis',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff000066),
                        ),
                      ),
                      SizedBox(height: 15.h),
                      Wrap(
                        spacing: 10.w,
                        runSpacing: 10.h,
                        children: [
                          _buildChip('ENT'),
                          _buildChip('Oncology'),
                          _buildChip('Medicine'),
                          _buildChip('Immuno-oncology'),
                        ],
                      ),
                      SizedBox(height: 30.h),

                      // 3. Research Sections
                      _buildInfoSection(
                        title: 'Research Mentor',
                        items: [
                          'Responsible for the study',
                          'Provides scientific guidance on study design, methodology, and manuscript development',
                          'Ensures academic rigor and alignment with journal standards',
                          'Published at least 50 studies in indexed journals',
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _buildInfoSection(
                        title: 'Research Program Director',
                        items: [
                          'Oversees the entire research process from initiation to submission',
                          'Ensures quality control, milestone tracking and successful project completion',
                        ],
                      ),
                      SizedBox(height: 30.h),

                      // 4. Why Join Section
                      Row(
                        children: [
                          SvgPicture.asset(
                            AppIcons.join_icon,
                            fit: BoxFit.cover,
                            height: 22.h,
                            width: 22.w,
                          ),

                          SizedBox(width: 10.w),
                          Text(
                            'Why Join This Project?',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff000066),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      _buildJoinItem(
                        'Data analysis and publication fees covered',
                      ),
                      _buildJoinItem(
                        'End-to-end research supervision until manuscript submission',
                      ),
                      _buildJoinItem(
                        'Access to recorded Meta-Analysis Expert Academy course',
                      ),
                      _buildJoinItem('Certificate of participation'),
                      _buildJoinItem(
                        'Hands-on mentorship from experienced researchers',
                      ),
                      _buildJoinItem(
                        'Co-authorship on a submitted manuscript within 2 months',
                      ),
                      SizedBox(height: 50.h), // Extra space for FAB
                    ],
                  ),
                ),
              ),
            ),
            // ------------ details information end--------
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => launchWhatsApp(context: context),
        backgroundColor: const Color(0xff000066),
        shape: const CircleBorder(),
        child: Center(
          child: Image.asset(
            'assets/images/whatapp_icon.png',
            width: 30.w,
            height: 30.w,
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xff00004d),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.mentorProfileScreen);
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: const AssetImage('assets/images/img1.png'),
                ),
                SizedBox(width: 15.w),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. Jhon Smith',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Meta-Analysis',
                      style: TextStyle(color: Colors.white70, fontSize: 14.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          const Divider(color: Colors.white24),
          SizedBox(height: 10.h),
          _buildStatRow(
            'Deadline',
            '11 Days Left',
            valueColor: AppColor.cD64545,
          ),
          SizedBox(height: 10.h),
          _buildStatRow('Availability', '12 Seats Only'),
          SizedBox(height: 10.h),
          _buildStatRow('Payment', 'Flexible'),
          SizedBox(height: 20.h),
          const Divider(color: Colors.white24),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                NavigationService.navigateTo(Routes.paymentScreen);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xff00004d),
                padding: EdgeInsets.symmetric(vertical: 15.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
              child: Text(
                'Apply Now',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatRow(
    String label,
    String value, {
    Color valueColor = Colors.white,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xff0077B6).withOpacity(0.2),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: AppColor.darkNavy,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required String title,
    required List<String> items,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border(
          left: BorderSide(color: const Color(0xff0277bd), width: 5.w),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xff000066),
            ),
          ),
          SizedBox(height: 15.h),
          ...items.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '•  ',
                    style: TextStyle(fontSize: 18.sp, color: AppColor.darkNavy),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJoinItem(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppIcons.check_cycle, height: 20.h, width: 20.w),
          // Icon(
          //   Icons.check_circle_outline,
          //   color: const Color(0xff000066),
          //   size: 20.sp,
          // ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 14.sp, color: AppColor.c06113A),
            ),
          ),
        ],
      ),
    );
  }
}
