import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';

class CoordinatorSubmissionCard extends StatelessWidget {
  final Map<String, dynamic> item;
  const CoordinatorSubmissionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Image Area with Badges
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20.r),
                ),
                child: Image.network(
                  item['image'],
                  height: 160.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/placeholder.jpg',
                      height: 160.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
              // Left Category Badge
              Positioned(
                top: 12.h,
                left: 12.w,
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xff00D8F6),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Text(
                    item['category'],
                    style: TextStyle(
                      color: const Color(0xff03045E),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              // Right Favorite Badge
              Positioned(
                top: 12.h,
                right: 12.w,
                child: Container(
                  width: 32.w,
                  height: 32.w,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      item['isFavorite'] ? Icons.favorite : Icons.favorite_border,
                      color: item['isFavorite'] ? Colors.red : Colors.grey,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Bottom content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'],
                  style: TextStyle(
                    color: const Color(0xff03045E),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                Text(
                  item['description'],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13.sp,
                  ),
                ),
                SizedBox(height: 12.h),
                // Author Row
                Row(
                  children: [
                    Icon(
                      Icons.person_outline,
                      color: const Color(0xff03045E),
                      size: 16.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      item['author'],
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 13.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                // Status Badge
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: item['statusBg'],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        item['status'] == 'Approved'
                            ? Icons.check_circle_outline
                            : Icons.access_time,
                        color: item['statusColor'],
                        size: 14.sp,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        item['status'],
                        style: TextStyle(
                          color: item['statusColor'],
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),
                // View Details Button
                SizedBox(
                  width: double.infinity,
                  height: 48.h,
                  child: ElevatedButton(
                    onPressed: () {
                      NavigationService.navigateTo(Routes.viewDetailsScreen);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff03045E),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
