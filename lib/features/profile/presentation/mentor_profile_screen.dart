import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/circular_icon_btn.dart';

class MentorProfileScreen extends StatefulWidget {
  const MentorProfileScreen({super.key});

  @override
  State<MentorProfileScreen> createState() => _MentorProfileScreenState();
}

class _MentorProfileScreenState extends State<MentorProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CircularIconBtn(
                  icon: Icons.arrow_back,
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 10.h),
                    Container(
                      width: 90.w,
                      height: 90.w,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/img1.png',
                          ), // Using placeholder image from project
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Jhon Smith',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xff000066),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.business, // Or a similar building icon
                          color: const Color(0xff000066),
                          size: 18.sp,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Al Hammadi Hospital - Riyadh',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xff000066),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    Divider(
                      color: const Color(0xFF0077B6).withOpacity(0.15),
                      thickness: 1,
                    ),
                    SizedBox(height: 24.h),

                    // About Section
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xff000066),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.w,
                              vertical: 6.h,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xffFFEAEA),
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.verified_user_outlined,
                                  color: Colors.red,
                                  size: 14.sp,
                                ),
                                SizedBox(width: 6.w),
                                Text(
                                  'Medicine (MBBS / MD)',
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF6B7280),
                              height: 1.5,
                            ),
                          ),
                          SizedBox(height: 24.h),

                          // Language Section
                          _buildSectionTitle(
                            Icons.language_outlined,
                            'Language',
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              _buildTag('English'),
                              SizedBox(width: 10.w),
                              _buildTag('Arabic'),
                              SizedBox(width: 10.w),
                              _buildTag('French'),
                            ],
                          ),
                          SizedBox(height: 24.h),

                          // Experience Section
                          _buildSectionTitle(
                            Icons.person_outline,
                            'Experience',
                          ),
                          SizedBox(height: 12.h),
                          _buildTag('8 Years'),
                          SizedBox(height: 24.h),

                          // Publications Section
                          _buildSectionTitle(
                            Icons.description_outlined,
                            'Publications',
                          ),
                          SizedBox(height: 12.h),
                          _buildTag('+10'),
                          SizedBox(height: 24.h),

                          // Mentree Section
                          _buildSectionTitle(Icons.group_outlined, 'Mentree'),
                          SizedBox(height: 12.h),
                          _buildTag('+200'),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(IconData icon, String title) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xff000066), size: 20.sp),
        SizedBox(width: 10.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff000066),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFD3EBF7),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: const Color(0xff000066),
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
