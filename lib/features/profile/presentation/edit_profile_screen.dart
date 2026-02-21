import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Jenny Wilson',
  );
  final TextEditingController _genderController = TextEditingController(
    text: 'Female',
  );
  final TextEditingController _dobController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _genderController.dispose();
    _dobController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbar(
                title: 'Edit Profile',
                onTap: () {
                  NavigationService.goBack;
                },
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Personal Information',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColor.textColor,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Handle save action
                              NavigationService.goBack;
                              ToastUtil.showShortToast(
                                "Profile Updated Successfully",
                              );
                            },
                            child: Text(
                              'Save',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xff323280),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25.h),
                      _buildPhotoUpload(),
                      SizedBox(height: 30.h),
                      _buildTextField(
                        label: 'Name',
                        controller: _nameController,
                        hint: 'Enter your name',
                      ),
                      SizedBox(height: 20.h),
                      _buildTextField(
                        label: 'Gender',
                        controller: _genderController,
                        hint: 'Enter gender',
                      ),
                      SizedBox(height: 20.h),
                      _buildTextField(
                        label: 'Date of birth',
                        controller: _dobController,
                        hint: 'DD/MM/YYYY',
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhotoUpload() {
    return Column(
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundImage: const AssetImage('assets/images/person.png'),
        ),
        SizedBox(height: 15.h),
        GestureDetector(
          onTap: () {
            // Handle photo upload
          },
          child: Text(
            'Upload Profile Photo',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xff323280),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textColor,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xffD1F1F9).withOpacity(0.5),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: controller,
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColor.textColor.withOpacity(0.8),
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                color: AppColor.textColor.withOpacity(0.5),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: 15.h,
              ),
              border: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
