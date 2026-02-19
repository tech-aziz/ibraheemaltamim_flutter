import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';

class WaitingListCard extends StatefulWidget {
  const WaitingListCard({super.key});

  @override
  State<WaitingListCard> createState() => _WaitingListCardState();
}

class _WaitingListCardState extends State<WaitingListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xffFFF7EB),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Waiting List',
                  style: TextStyle(
                    color: Colors.orange,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '8M 20S left ',
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: ' to accept your slot',
                        style: TextStyle(color: Colors.grey, fontSize: 14.sp),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Image.asset('assets/images/clock.png', fit: BoxFit.cover),
        ],
      ),
    );
  }
}
