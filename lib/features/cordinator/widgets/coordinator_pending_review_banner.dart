import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoordinatorPendingReviewBanner extends StatelessWidget {
  const CoordinatorPendingReviewBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xffFEF6E4), // Light cream/yellow
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'PENDING REVIEW',
                  style: TextStyle(
                    color: const Color(0xffF79009), // Orange/yellow
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  '3 New Research Submissions',
                  style: TextStyle(
                    color: const Color(0xff03045E),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Clock alarm icon
          Container(
            width: 36.w,
            height: 36.w,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: Icon(
              Icons.alarm,
              color: const Color(0xffFDA29B),
              size: 28.sp,
            ),
          ),
        ],
      ),
    );
  }
}
