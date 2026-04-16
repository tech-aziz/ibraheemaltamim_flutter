import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/privacy_policy_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:shimmer/shimmer.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  @override
  void initState() {
    super.initState();
    termsAndConditionsRxObj.fetchTerms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            CustomAppbar(
              title: 'Terms & Conditions',
              onTap: () => NavigationService.goBack(),
            ),
            Expanded(
              child: StreamBuilder<PrivacyPolicyModel>(
                stream: termsAndConditionsRxObj.termsStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting &&
                      !snapshot.hasData) {
                    return _buildShimmer();
                  }

                  if (snapshot.hasError && !snapshot.hasData) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.error_outline_rounded,
                            size: 48.sp,
                            color: AppColor.textColor.withOpacity(0.4),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            'Failed to load Terms & Conditions',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColor.textColor.withOpacity(0.6),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          TextButton(
                            onPressed: () =>
                                termsAndConditionsRxObj.fetchTerms(),
                            child: Text(
                              'Try Again',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColor.textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final model = snapshot.data;
                  final content = model?.data?.pageContent ?? '';

                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        UIHelper.verticalSpace(8.h),
                        Html(
                          data: content,
                          style: {
                            'body': Style(
                              margin: Margins.zero,
                              padding: HtmlPaddings.symmetric(
                                horizontal: 16,
                                vertical: 4,
                              ),
                              fontSize: FontSize(14.sp),
                              lineHeight: LineHeight(1.7),
                              color: AppColor.textColor.withOpacity(0.8),
                            ),
                            'h1': Style(
                              fontSize: FontSize(20.sp),
                              fontWeight: FontWeight.bold,
                              color: AppColor.textColor,
                              margin: Margins.only(top: 16, bottom: 8),
                            ),
                            'h2': Style(
                              fontSize: FontSize(18.sp),
                              fontWeight: FontWeight.bold,
                              color: AppColor.textColor,
                              margin: Margins.only(top: 14, bottom: 6),
                            ),
                            'h3': Style(
                              fontSize: FontSize(16.sp),
                              fontWeight: FontWeight.bold,
                              color: AppColor.textColor,
                              margin: Margins.only(top: 12, bottom: 4),
                            ),
                            'p': Style(
                              margin: Margins.only(bottom: 12),
                            ),
                            'li': Style(
                              margin: Margins.only(bottom: 6),
                            ),
                            'strong': Style(
                              fontWeight: FontWeight.bold,
                              color: AppColor.textColor,
                            ),
                            'a': Style(
                              color: Colors.blue,
                              textDecoration: TextDecoration.underline,
                            ),
                          },
                        ),
                        UIHelper.verticalSpace(40.h),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 24.h,
              width: 180.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ),
            SizedBox(height: 20.h),
            ...List.generate(12, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  height: 14.h,
                  width: index % 4 == 3 ? 200.w : double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              );
            }),
            SizedBox(height: 20.h),
            ...List.generate(10, (index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Container(
                  height: 14.h,
                  width: index % 3 == 2 ? 160.w : double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
