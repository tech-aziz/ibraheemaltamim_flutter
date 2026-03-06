import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool saveCard = false;
  bool _isOrderSummaryExpanded = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomAppbar(
              title: 'Messages',
              onTap: () {
                NavigationService.navigateToWithArgs(Routes.navbar, {
                  "pageNum": 0,
                });
              },
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderSummary(),
                    SizedBox(height: 24.h),
                    Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(
                          0xff000066,
                        ), // AppColor.buttonColor usually
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Express Checkout',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff4B5563),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    _buildApplePayBtn(),
                    SizedBox(height: 12.h),
                    _buildGooglePayBtn(),
                    SizedBox(height: 24.h),
                    _buildDividerWithText(),
                    SizedBox(height: 24.h),
                    _buildTextFieldSection(
                      'Card Number',
                      '1234 5678 9012 3456',
                    ),
                    SizedBox(height: 16.h),
                    _buildTextFieldSection('Cardholder Name', 'John Doe'),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextFieldSection('Expiry Date', 'MM/YY'),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(child: _buildTextFieldSection('CVV', '123')),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 24.w,
                          height: 24.w,
                          child: Checkbox(
                            value: saveCard,
                            onChanged: (val) {
                              setState(() {
                                saveCard = val ?? false;
                              });
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            side: const BorderSide(
                              color: Color(0xFF9CA3AF),
                              width: 1.5,
                            ),
                            activeColor: const Color(0xFF0077B6),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          'Save card for future applications',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF6B7280),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h),
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: ElevatedButton(
                        onPressed: () {
                          NavigationService.navigateTo(
                            Routes.paymentSuccessScreen,
                          );
                          // ToastUtil.showShortToast("Payment Successfully");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff000066),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Pay \$150.00',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: const Border(
            left: BorderSide(color: Color(0xFF0077B6), width: 4.0),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isOrderSummaryExpanded = !_isOrderSummaryExpanded;
                  });
                },
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order Summary',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w800,
                        color: const Color(0xff000066),
                      ),
                    ),
                    Icon(
                      _isOrderSummaryExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: const Color(0xff000066),
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
              AnimatedCrossFade(
                firstChild: const SizedBox(width: double.infinity),
                secondChild: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    Divider(
                      color: const Color(0xFFF3F4F6),
                      height: 1,
                      thickness: 1,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Research Opportunity',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF9CA3AF),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      'Assessing the Efficacy and Safety of\nMalaria Prevention',
                      style: TextStyle(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF0077B6),
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xff000066),
                          ),
                        ),
                        Text(
                          '\$150.00',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xff000066),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                crossFadeState: _isOrderSummaryExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: const Duration(milliseconds: 300),
                layoutBuilder:
                    (topChild, topChildKey, bottomChild, bottomChildKey) {
                      return Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            key: bottomChildKey,
                            left: 0.0,
                            top: 0.0,
                            right: 0.0,
                            child: bottomChild,
                          ),
                          Positioned(key: topChildKey, child: topChild),
                        ],
                      );
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildApplePayBtn() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xff000033),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 0,
        ),
        icon: Icon(Icons.apple, color: Colors.white, size: 24.sp),
        label: Text(
          'Pay with Apple Pay',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildGooglePayBtn() {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          elevation: 0,
        ),
        icon: _buildGoogleIcon(),
        label: Text(
          'Pay with Google Pay',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleIcon() {
    return Container(
      width: 20.w,
      height: 20.w,
      decoration: const BoxDecoration(color: Colors.white),
      child: Stack(
        alignment: Alignment.center,
        children: [
 
          Text(
            'G',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.red, // Close enough substitute
            ),
          ),
    
        ],
      ),
    );
  }

  Widget _buildDividerWithText() {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: const Color(0xFFD1D5DB),
            thickness: 1,
            endIndent: 12.w,
          ),
        ),
        Text(
          'or pay with card',
          style: TextStyle(
            fontSize: 14.sp,
            color: const Color(0xFF4B5563),
            fontWeight: FontWeight.w500,
          ),
        ),
        Expanded(
          child: Divider(
            color: const Color(0xFFD1D5DB),
            thickness: 1,
            indent: 12.w,
          ),
        ),
      ],
    );
  }

  Widget _buildTextFieldSection(String title, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: const Color(0xff374151),
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: const Color(0xFF9CA3AF),
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 14.h,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
