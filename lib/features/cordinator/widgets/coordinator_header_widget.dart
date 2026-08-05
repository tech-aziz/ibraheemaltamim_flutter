import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoordinatorHeaderWidget extends StatelessWidget {
  const CoordinatorHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile Image
        Container(
          width: 48.w,
          height: 48.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5.w),
            image: const DecorationImage(
              image: NetworkImage(
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop',
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        // Greeting
        Text(
          'Hi, Jenny',
          style: TextStyle(
            color: const Color(0xff03045E),
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Spacer(),
        // Favorite/Heart button
        _buildCircularHeaderButton(Icons.favorite_border),
        SizedBox(width: 10.w),
        // Notification bell button
        _buildCircularHeaderButton(Icons.notifications_none),
      ],
    );
  }

  Widget _buildCircularHeaderButton(IconData icon) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: const BoxDecoration(
        color: Color(0xffBCE8F7), // slightly darker blue background for buttons
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(icon, color: const Color(0xff03045E), size: 20.sp),
      ),
    );
  }
}
