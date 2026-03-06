import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_fonts.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_button.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_text_widget.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';

class RegisterOtpVerificationScreen extends StatefulWidget {
  final String email;
  const RegisterOtpVerificationScreen({super.key, required this.email});

  @override
  State<RegisterOtpVerificationScreen> createState() =>
      _RegisterOtpVerificationScreenState();
}

class _RegisterOtpVerificationScreenState
    extends State<RegisterOtpVerificationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController otpController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        UIHelper.verticalSpace(110.h),

                        customTextWidget(
                          name: 'Verify OTP'.tr,
                          alignment: Alignment.center,

                          style: TextFontStyle.textStyle13PoppinsW500.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppColor.textColor,
                            fontSize: 28.sp,
                            height: 1.2,
                          ),
                        ),
                        UIHelper.verticalSpace(8.h),
                        Text(
                          textAlign: TextAlign.center,
                          // "An authentication code has been sent to \n +88${widget.phoneNumber}",
                          "Please enter the code we sent you\n to email " +
                              widget.email,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: AppColor.textColor1,
                          ),
                        ),
                        UIHelper.verticalSpace(40.h),
                        OtpTextField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          numberOfFields: 4,
                          focusedBorderColor: AppColor.c333334,
                          showFieldAsBox: true,
                          fillColor: AppColor.bgColor,
                          cursorColor: AppColor.c333334,
                          filled: true,
                          enabledBorderColor: AppColor.textColor,
                          borderRadius: BorderRadius.circular(4.r),
                          margin: EdgeInsets.symmetric(horizontal: 15.w),
                          fieldHeight: 54.h,
                          fieldWidth: 54.w,
                          contentPadding: EdgeInsets.zero,
                          textStyle: TextFontStyle.textStyle13PoppinsW500
                              .copyWith(
                                fontSize: 16.sp,
                                color: AppColor.c797A7C,
                                fontWeight: FontWeight.w500,
                              ),
                          // Centers the text inside each OTP field
                          mainAxisAlignment: MainAxisAlignment.center,
                          onCodeChanged: (String code) {},
                          onSubmit: (String verificationCode) {
                            if (verificationCode.length == 4) {
                              otpController.text = verificationCode;
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Please enter a valid 4-digit OTP".tr,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                        UIHelper.verticalSpace(15.h),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Didn\'t receive OTP ?'.tr,
                                  style: TextFontStyle.textStyle13PoppinsW500
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                        color: AppColor.c323232.withOpacity(
                                          0.5,
                                        ),

                                        letterSpacing: 0.25.sp,
                                      ),
                                ),
                                TextSpan(
                                  text: ' Resend Code'.tr,
                                  style: TextFontStyle.textStyle13PoppinsW500
                                      .copyWith(
                                        color: AppColor.textColor,
                                        height: 1.2,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.sp,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      // final formattedPhone =
                                      //     '${widget.phoneNumber}';
                                      // await resendOtpRxObj
                                      //     .resendOtpRx(phone: formattedPhone)
                                      //     .waitingForFuture();
                                    },
                                ),
                              ],
                            ),
                          ),
                        ),
                        UIHelper.verticalSpace(15.h),
                        Text(
                          '1:00 min',
                          style: TextFontStyle.textStyle13PoppinsW500.copyWith(
                            color: AppColor.textColor,
                            height: 1.2,
                            fontWeight: FontWeight.w700,
                            fontSize: 12.sp,
                          ),
                        ),
                        UIHelper.verticalSpace(40.h),
                        CustomButton(
                          text: 'Verify'.tr,
                          backgroundColor: AppColor.textColor,
                          onPressed: () async {
                            if (!_isLoading) {
                              if (otpController.text.length != 4) {
                                ToastUtil.showShortToast(
                                  'Please enter a valid 4-digit OTP'.tr,
                                );
                                return;
                              }

                              setState(() {
                                _isLoading = true;
                              });

                              try {
                                NavigationService.navigateToReplacement(
                                  Routes.loginScreen,
                                );
                                ToastUtil.showShortToast(
                                  "Successfully Verified",
                                );
                              } catch (e) {
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    _isLoading = false;
                                  });
                                }
                              }
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
