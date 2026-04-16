import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_fonts.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_buttons.dart';
import 'package:ibraheemaltamim_flutter/constants/app_constants.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/di.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:ibraheemaltamim_flutter/networks/dio/dio.dart';

class CustomDeleteAccountWidget extends StatefulWidget {
  const CustomDeleteAccountWidget({super.key});

  @override
  State<CustomDeleteAccountWidget> createState() => _CustomDeleteAccountWidgetState();
}

class _CustomDeleteAccountWidgetState extends State<CustomDeleteAccountWidget> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 10.h,
      ),
      decoration: BoxDecoration(
        color: AppColor.cFFFFFF,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UIHelper.verticalSpace(12.h),
          Container(
            width: 40.w,
            height: 6.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28.r),
              color: AppColor.cD9D9D9,
            ),
          ),
          UIHelper.verticalSpace(12.h),
          Text(
            'Delete Account?',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.redAccent,
            ),
          ),
          UIHelper.verticalSpace(6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Are you sure you want to delete your account? This action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle13PoppinsW500.copyWith(
                fontSize: 16.sp,
                color: AppColor.c4B5563,
                height: 1.5,
              ),
            ),
          ),
          UIHelper.verticalSpace(6.h),
          Divider(color: AppColor.cEEEEEE, thickness: 1.sp),
          UIHelper.verticalSpace(6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              children: [
                Expanded(
                  child: CustomButtons(
                    name: 'Cancel',
                    bgColor: AppColor.cE8EBEF,
                    textStyle: TextFontStyle.textStyle13PoppinsW500.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.c4B5563,
                      fontWeight: FontWeight.w600,
                    ),
                    callback: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                UIHelper.horizontalSpace(12.w),
                Expanded(
                  child: CustomButtons(
                    name: 'Yes, Delete',
                    bgColor: Colors.redAccent,
                    isLoading: _isLoading,
                    callback: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        final res = await deleteAccountRxObj.delete();
                        if (res != null) {
                          appData.remove(kKeyAccessToken);
                          DioSingleton.instance.update('');
                          NavigationService.navigateToUntilReplacement(
                            Routes.loginScreen,
                          );
                        }
                      } finally {
                        if (mounted) {
                          setState(() {
                            _isLoading = false;
                          });
                        }
                      }
                    },
                    textStyle: TextFontStyle.textStyle13PoppinsW500.copyWith(
                      fontSize: 16.sp,
                      color: AppColor.cFFFFFF,
                      fontWeight: FontWeight.w600,
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
