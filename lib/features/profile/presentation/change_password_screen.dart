import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_textfield_widget.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _updatePassword() async {
    if (_formKey.currentState!.validate()) {
      final res = await updatePasswordRxObj.updatePassword(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
        newPasswordConfirmation: _confirmPasswordController.text,
      );
      if (res != null) {
        NavigationService.goBack();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              title: 'Change Password',
              onTap: () => NavigationService.goBack,
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Password',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextfieldWidget(
                        hintText: 'Enter current password',
                        controller: _currentPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter current password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'New Password',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextfieldWidget(
                        hintText: 'Enter new password',
                        controller: _newPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter new password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        'Confirm New Password',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColor.textColor,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      CustomTextfieldWidget(
                        hintText: 'Confirm new password',
                        controller: _confirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your new password';
                          }
                          if (value != _newPasswordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40.h),
                      ValueListenableBuilder<bool>(
                        valueListenable: updatePasswordRxObj.isLoading,
                        builder: (context, isLoading, child) {
                          return SizedBox(
                            width: double.infinity,
                            height: 55.h,
                            child: OutlinedButton(
                              onPressed: isLoading ? null : _updatePassword,
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: AppColor.textColor,
                                  width: 1.5,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                              ),
                              child: isLoading
                                  ? SizedBox(
                                      height: 20.h,
                                      width: 20.h,
                                      child: CircularProgressIndicator(
                                        color: AppColor.textColor,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text(
                                      'Update Password',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.bold,
                                        color: AppColor.textColor,
                                      ),
                                    ),
                            ),
                          );
                        },
                      ),
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
