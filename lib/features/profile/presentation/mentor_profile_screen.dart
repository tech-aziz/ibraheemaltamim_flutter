import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/circular_icon_btn.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/mentor_details_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';

class MentorProfileScreen extends StatefulWidget {
  final int? mentorId;
  const MentorProfileScreen({super.key, this.mentorId});

  @override
  State<MentorProfileScreen> createState() => _MentorProfileScreenState();
}

class _MentorProfileScreenState extends State<MentorProfileScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.mentorId != null) {
      mentorDetailsRxObj.fetchMentorDetails(widget.mentorId.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: ValueListenableBuilder<bool>(
          valueListenable: mentorDetailsRxObj.isLoading,
          builder: (context, isLoading, child) {
            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return StreamBuilder<MentorDetailsModel>(
              stream: mentorDetailsRxObj.dataFetcher.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      _buildBackButton(),
                      Expanded(
                        child: Center(child: Text("Error: ${snapshot.error}")),
                      ),
                    ],
                  );
                }

                final mentor = snapshot.data?.data;
                if (mentor == null) {
                  return Column(
                    children: [
                      _buildBackButton(),
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.mentorId == null
                                ? "No mentor ID provided"
                                : "No mentor details found",
                          ),
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  children: [
                    _buildBackButton(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            UIHelper.verticalSpace(10.h),
                            Container(
                              width: 90.w,
                              height: 90.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: _getImageProvider(
                                    mentor.user?.avatar ?? '',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(height: 16.h),
                            Text(
                              mentor.user?.name ?? 'N/A',
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
                                  Icons.business,
                                  color: const Color(0xff000066),
                                  size: 18.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  mentor.university ?? 'N/A',
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
                                  Text(
                                    mentor.bio ?? 'No bio available',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      color: const Color(0xFF6B7280),
                                      height: 1.5,
                                    ),
                                  ),
                                  SizedBox(height: 24.h),

                                  Text(
                                    'Department',
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
                                          mentor.department ?? 'N/A',
                                          style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // // Language Section (Hardcoded as not in model yet)
                                  // _buildSectionTitle(
                                  //   Icons.language_outlined,
                                  //   'Language',
                                  // ),
                                  // SizedBox(height: 12.h),
                                  // Row(
                                  //   children: [
                                  //     _buildTag('English'),
                                  //     SizedBox(width: 10.w),
                                  //     _buildTag('Arabic'),
                                  //     SizedBox(width: 10.w),
                                  //     _buildTag('French'),
                                  //   ],
                                  // ),
                                  // SizedBox(height: 24.h),

                                  // // Experience Section
                                  // _buildSectionTitle(
                                  //   Icons.person_outline,
                                  //   'Experience',
                                  // ),
                                  // SizedBox(height: 12.h),
                                  // _buildTag('8 Years'),
                                  // SizedBox(height: 24.h),

                                  // // Publications Section
                                  // _buildSectionTitle(
                                  //   Icons.description_outlined,
                                  //   'Publications',
                                  // ),
                                  // SizedBox(height: 12.h),
                                  // _buildTag('+10'),
                                  // SizedBox(height: 24.h),

                                  // // Mentree Section
                                  // _buildSectionTitle(
                                  //   Icons.group_outlined,
                                  //   'Mentree',
                                  // ),
                                  // SizedBox(height: 12.h),
                                  // _buildTag('+200'),
                                  // SizedBox(height: 40.h),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  ImageProvider _getImageProvider(String imageUrlPath) {
    final String cleanUrl = imageUrlPath.trim();

    if (cleanUrl.isEmpty) {
      return const AssetImage('assets/images/img1.png');
    }

    if (cleanUrl.toLowerCase().contains('assets/') ||
        cleanUrl.toLowerCase().contains('assets\\\\')) {
      int index = cleanUrl.toLowerCase().indexOf('assets');
      String assetPath = cleanUrl.substring(index);
      return AssetImage(assetPath);
    }

    if (cleanUrl.startsWith('http')) {
      return NetworkImage(cleanUrl);
    } else {
      String fullUrl = cleanUrl.startsWith('/')
          ? "$imageUrl$cleanUrl"
          : "$imageUrl/$cleanUrl";
      return NetworkImage(fullUrl);
    }
  }

  Widget _buildBackButton() {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: CircularIconBtn(
          icon: Icons.arrow_back,
          onTap: () {
            Navigator.pop(context);
          },
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
