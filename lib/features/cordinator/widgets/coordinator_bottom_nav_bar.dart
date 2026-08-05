import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CoordinatorBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const CoordinatorBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  static const List<Map<String, dynamic>> _navItems = [
    {'label': 'Home', 'icon': Icons.home_outlined},
    {'label': 'Chat', 'icon': Icons.chat_bubble_outline},
    {'label': 'Profile', 'icon': Icons.person_outline},
  ];

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20.w,
      right: 20.w,
      bottom: 20.h,
      child: Container(
        height: 70.h,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: const Color(0xffB1E3F1),
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(_navItems.length, (index) {
            final bool isSelected = selectedIndex == index;
            final item = _navItems[index];

            return GestureDetector(
              onTap: () => onTap(index),
              child: AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  height: 48.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: isSelected ? 16.w : 0,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xff03045E) : Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 48.h, // Ensures unselected item is a circle
                        height: 48.h,
                        child: Center(
                          child: Icon(
                            item['icon'],
                            color: isSelected
                                ? Colors.white
                                : const Color(0xff03045E),
                            size: 22.sp,
                          ),
                        ),
                      ),
                      if (isSelected) ...[
                        SizedBox(width: 4.w),
                        Text(
                          item['label'],
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8.w),
                      ],
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
