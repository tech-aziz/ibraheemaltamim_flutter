import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'Project Deadline Approaching',
      'description':
          'Telemedicine for Pediatric Epilepsy - 10 days left until submission',
      'category': 'Week 3-6: Data & Analysis',
      'time': '2 hours ago',
      'icon': Icons.access_time_rounded,
      'iconBg': const Color(0xFFFFE3E3),
      'iconColor': Colors.red,
      'isUnread': true,
    },
    {
      'title': 'Submission Received',
      'description':
          'Your Week 1-2 Protocol & Methodology submission has been received successfully',
      'category': 'Week 1-2: Protocol & Methodology',
      'time': '5 hours ago',
      'icon': Icons.check_circle_outline_rounded,
      'iconBg': const Color(0xFFE3FAF3),
      'iconColor': const Color(0xFF20C997),
      'isUnread': true,
    },
    {
      'title': 'Project Status Update',
      'description':
          'Carbon-Fiber-Reinforced PEEK project status changed to "Under Review"',
      'category': 'Week 7-8: Submission & Review',
      'time': '1 day ago',
      'icon': Icons.notifications_none_rounded,
      'iconBg': const Color(0xFFE7F5FF),
      'iconColor': const Color(0xFF339AF0),
      'isUnread': false,
    },
    {
      'title': 'New Team Member Added',
      'description':
          'Dr. Sarah Johnson joined as co-researcher on Ophthalmology project',
      'category': 'Evaluating Innovative Intraoperative Technologies',
      'time': '2 days ago',
      'icon': Icons.group_outlined,
      'iconBg': const Color(0xFFF3F0FF),
      'iconColor': const Color(0xFF845EF7),
      'isUnread': false,
    },
    {
      'title': 'Project Status Update',
      'description':
          'Carbon-Fiber-Reinforced PEEK project status changed to "Under Review"',
      'category': 'Week 7-8: Submission & Review',
      'time': '1 day ago',
      'icon': Icons.notifications_none_rounded,
      'iconBg': const Color(0xFFE7F5FF),
      'iconColor': const Color(0xFF339AF0),
      'isUnread': false,
    },
    {
      'title': 'New Team Member Added',
      'description':
          'Dr. Sarah Johnson joined as co-researcher on Ophthalmology project',
      'category': 'Evaluating Innovative Intraoperative Technologies',
      'time': '2 days ago',
      'icon': Icons.group_outlined,
      'iconBg': const Color(0xFFF3F0FF),
      'iconColor': const Color(0xFF845EF7),
      'isUnread': false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              title: 'Notifications',
              onTap: () {
                NavigationService.goBack;
              },
              trailing: GestureDetector(
                onTap: () {
                  ToastUtil.showShortToast("Marked all read");
                  NavigationService.goBack;
                },
                child: Text(
                  'Mark all read',
                  style: TextStyle(
                    color: const Color(0xFF0077B6),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: _notifications.length,
                itemBuilder: (context, index) {
                  return _buildNotificationCard(_notifications[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> data) {
    bool isUnread = data['isUnread'] ?? false;
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.all(15.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: isUnread
            ? Border(
                left: BorderSide(color: const Color(0xFF0077B6), width: 4.w),
              )
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: data['iconBg'],
              shape: BoxShape.circle,
            ),
            child: Icon(data['icon'], color: data['iconColor'], size: 24.sp),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        data['title'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                        ),
                      ),
                    ),
                    if (isUnread)
                      Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFF0077B6),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 5.h),
                Text(
                  data['description'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFD1F1F9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    data['category'],
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF0077B6),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  data['time'],
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey[400]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
