import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xffD6F2FB,
      ), // Matching light blue background
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Text(
                'Welcome!',
                style: TextStyle(
                  color: const Color(0xff03045E),
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Please select your role to continue',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 16.sp),
              ),
              SizedBox(height: 40.h),
              Expanded(
                child: Column(
                  children: [
                    _buildRoleCard(
                      role: 'Researcher',
                      title: 'Researcher',
                      description:
                          'Explore opportunities, track progress and submit findings.',
                      icon: Icons.science_outlined,
                      color: const Color(0xff00D8F6),
                    ),
                    SizedBox(height: 20.h),
                    _buildRoleCard(
                      role: 'Coordinator',
                      title: 'Coordinator',
                      description:
                          'Review research submissions and manage approvals.',
                      icon: Icons.assignment_turned_in_outlined,
                      color: const Color(0xff9E77ED),
                    ),
                    SizedBox(height: 20.h),
                    _buildRoleCard(
                      role: 'Mentor',
                      title: 'Mentor',
                      description:
                          'Guide researchers and review ongoing academic papers.',
                      icon: Icons.school_outlined,
                      color: const Color(0xff12B76A),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: ElevatedButton(
                  onPressed: _selectedRole == null
                      ? null
                      : () {
                          if (_selectedRole == 'Researcher') {
                            NavigationService.navigateToReplacement(
                              Routes.navbar,
                            );
                          } else if (_selectedRole == 'Coordinator') {
                            NavigationService.navigateToReplacement(
                              Routes.coordinatorHomeScreen,
                            );
                          } else if (_selectedRole == 'Mentor') {
                            // Redirect to Mentor/Home (navbar handles typical user/mentor views)
                            NavigationService.navigateToReplacement(
                              Routes.navbar,
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff03045E),
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.grey.shade300,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Continue',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required String role,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
  }) {
    final bool isSelected = _selectedRole == role;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedRole = role;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: EdgeInsets.all(18.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected ? const Color(0xff03045E) : Colors.transparent,
            width: 2.w,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 26.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: const Color(0xff03045E),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 13.sp,
                    ),
                  ),
                ],
              ),
            ),
            // Select Indicator
            Container(
              width: 24.w,
              height: 24.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? const Color(0xff03045E)
                      : Colors.grey.shade400,
                  width: 2.w,
                ),
                color: isSelected
                    ? const Color(0xff03045E)
                    : Colors.transparent,
              ),
              child: isSelected
                  ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
