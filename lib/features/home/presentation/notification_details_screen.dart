import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/get_all_notification_list_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:intl/intl.dart';

class NotificationDetailsScreen extends StatelessWidget {
  final Datum notification;

  const NotificationDetailsScreen({super.key, required this.notification});

  @override
  Widget build(BuildContext context) {
    final data = notification.data;
    final time = data?.timestamp != null
        ? DateFormat('EEE MMM d h:mma').format(data!.timestamp!)
        : (notification.createdAt != null
            ? DateFormat('EEE MMM d h:mma').format(notification.createdAt!)
            : "");

    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar(
              title: 'Notification Details',
              onTap: () {
                NavigationService.goBack;
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data?.title ?? "No Title",
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        time,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Divider(color: Colors.grey[200]),
                      SizedBox(height: 20.h),
                      Text(
                        data?.message ?? "No Message",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      if (data?.type != null) ...[
                        SizedBox(height: 30.h),
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
                            data!.type!,
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xFF0077B6),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
