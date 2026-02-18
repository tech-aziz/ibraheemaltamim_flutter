import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_fonts.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_buttons.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';

class CustomLogoutWidget extends StatelessWidget {
  CustomLogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom + 110.h,
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
            'Log Out?',
            style: TextFontStyle.textStyle13PoppinsW500.copyWith(
              fontSize: 22.sp,
              color: AppColor.c266FEF,
              fontWeight: FontWeight.w700,
            ),
          ),
          UIHelper.verticalSpace(6.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Text(
              'Are you sure you want to log out?',
              textAlign: TextAlign.center,
              style: TextFontStyle.textStyle13PoppinsW500.copyWith(
                fontSize: 16.sp,
                color: AppColor.c4B5563,
                height: 1.5,
              ),
            ),
          ),
          UIHelper.verticalSpace(6.h),
          Divider(
            color: AppColor.cEEEEEE,
            thickness: 1.sp,
          ),
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
                      Navigator.of(context).pop(false);
                    },
                  ),
                ),
                UIHelper.horizontalSpace(12.w),
                Expanded(
                  child: CustomButtons(
                    name: 'Yes, Log out',
                    bgColor: AppColor.c266FEF,
                    callback: () async {
                      // await logOutRx.logout().waitingForFuture();
                      // appData.write(kKeyIsLoggedIn, false);
                      // appData.remove(kKeyAccessToken);
                      // appData.remove(kKeyUserRole);
                      // DioSingleton.instance.update('');
                      // totalDataClean();
                      // NavigationService.navigateToUntilReplacement(
                      //   Routes.loginScreen,
                      // );
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
