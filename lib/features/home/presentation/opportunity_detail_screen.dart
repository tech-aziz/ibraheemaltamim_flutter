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
import 'package:ibraheemaltamim_flutter/features/home/data/rx_opportunity_details/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_details_model.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_details_model.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:flutter_html/flutter_html.dart';

class OpportunityDetailScreen extends StatefulWidget {
  final int? opportunityId;
  const OpportunityDetailScreen({super.key, this.opportunityId});

  @override
  State<OpportunityDetailScreen> createState() =>
      _OpportunityDetailScreenState();
}

class _OpportunityDetailScreenState extends State<OpportunityDetailScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.opportunityId != null) {
      getOpportunityDetailsRx.fetchDetails(widget.opportunityId.toString());
    }
  }

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
              child: StreamBuilder<OpportunityDetailsModel>(
                stream: getOpportunityDetailsRx.getFileData,
                builder: (context, snapshot) {
                  final isLoading =
                      snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.data?.data == null;
                  final data = isLoading
                      ? Data(
                          id: 0,
                          title: 'Loading Opportunity Details...',
                          overview:
                              'This is a placeholder for the opportunity overview description while content is loading.',
                          price: '000',
                          deadLine: DateTime.now(),
                          durations: '0 Months',
                          startDate: DateTime.now(),
                          categories: [Category(name: 'Loading...')],
                          mentor: Mentor(
                            department: 'Department',
                            user: {'name': 'Mentor Name'},
                          ),
                          desciptions: [
                            Desciption(
                              title: 'Description Title',
                              description: 'Description content placeholder.',
                            ),
                          ],
                        )
                      : snapshot.data?.data;

                  if (data == null && !isLoading) {
                    return const Center(child: Text('No details found.'));
                  }

                  return Skeletonizer(
                    enabled: isLoading,
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            UIHelper.verticalSpace(10.h),
                            // 1. Top Card Component
                            _buildProfileCard(data!),
                            SizedBox(height: 30.h),

                            // 2. Title & Chips
                            Text(
                              data.title ?? 'No Title',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff000066),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            if (data.categories?.isNotEmpty == true)
                              Wrap(
                                spacing: 10.w,
                                runSpacing: 10.h,
                                children: data.categories!
                                    .map((cat) => _buildChip(cat.name ?? ''))
                                    .toList(),
                              ),
                            SizedBox(height: 30.h),

                            // 3. Research Sections
                            if (data.desciptions != null)
                              ...data.desciptions!.map(
                                (desc) => Padding(
                                  padding: EdgeInsets.only(bottom: 20.h),
                                  child: _buildInfoSection(
                                    title: desc.title ?? 'Description',
                                    items: [desc.description ?? ''],
                                  ),
                                ),
                              ),

                            if (data.specialities?.isNotEmpty == true ||
                                data.studydesignTypes?.isNotEmpty == true) ...[
                              Text(
                                'Specialities & Design',
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
                                  if (data.specialities != null)
                                    ...data.specialities!.map(
                                      (s) => _buildChip(s.name ?? ''),
                                    ),
                                  if (data.studydesignTypes != null)
                                    ...data.studydesignTypes!.map(
                                      (s) => _buildChip(s.name ?? ''),
                                    ),
                                ],
                              ),
                              SizedBox(height: 30.h),
                            ], // 4. Why Join Section (Optional from static or could be part of descriptions)
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
                                  'Overview',
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xff000066),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              data.overview ?? 'No overview available.',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[700],
                                height: 1.5,
                              ),
                            ),

                            SizedBox(height: 50.h), // Extra space for FAB
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // ------------ details information end--------
            ),
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

  // Shimmer removed in favor of Skeletonizer

  Widget _buildProfileCard(Data data) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30.r,
                      backgroundColor: Colors.white24,
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 30.sp,
                      ),
                    ),
                    SizedBox(width: 15.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data.mentor?.user is Map
                              ? (data.mentor?.user['name'] ??
                                    'Mentor #${data.mentorId ?? '-'}')
                              : 'Mentor #${data.mentorId ?? '-'}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data.mentor?.department ?? 'Department',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(
                  '\$${data.price ?? '0'}',
                  style: TextStyle(color: AppColor.cFFFFFF, fontSize: 16.sp),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          const Divider(color: Colors.white24),
          SizedBox(height: 10.h),
          _buildStatRow(
            'Deadline',
            data.deadLine?.toIso8601String().split('T').first ?? '-',
            valueColor: AppColor.cD64545,
          ),
          SizedBox(height: 10.h),
          _buildStatRow('Duration', data.durations ?? '-'),
          SizedBox(height: 10.h),
          _buildStatRow(
            'Start Date',
            data.startDate?.toIso8601String().split('T').first ?? '-',
          ),
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
              child: Html(
                data: item,
                style: {
                  "body": Style(
                    fontSize: FontSize(13.sp),
                    color: Colors.grey[600],
                    lineHeight: const LineHeight(1.5),
                    margin: Margins.zero,
                    padding: HtmlPaddings.zero,
                  ),
                  "ul": Style(margin: Margins.only(left: 0.w)),
                  "li": Style(margin: Margins.only(bottom: 0.h)),
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
