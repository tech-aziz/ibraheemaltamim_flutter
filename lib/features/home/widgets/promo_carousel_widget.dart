import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';

class PromoSlide {
  final String title;
  final String description;
  final String code;
  final DateTime targetTime;

  PromoSlide({
    required this.title,
    required this.description,
    required this.code,
    required this.targetTime,
  });
}

class PromoCarouselWidget extends StatefulWidget {
  const PromoCarouselWidget({super.key});

  @override
  State<PromoCarouselWidget> createState() => _PromoCarouselWidgetState();
}

class _PromoCarouselWidgetState extends State<PromoCarouselWidget> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _pageTimer;
  Timer? _countdownTimer;
  late final List<PromoSlide> _slides;

  @override
  void initState() {
    super.initState();

    // Setup 3 promotional slides with target times
    _slides = [
      PromoSlide(
        title: "🚀 Summer Package - 10% Off",
        description: "Subscribe to any research project and you'll automatically get lifetime access to all platform courses... an offer that won't be repeated!",
        code: "SUMMER10",
        targetTime: DateTime.now().add(const Duration(days: 23, hours: 11, minutes: 39, seconds: 7)),
      ),
      PromoSlide(
        title: "⚡ Flash Sale - 20% Off Courses",
        description: "Upgrade your learning journey today! Get a 20% discount on all advanced academic courses. Fast action recommended!",
        code: "FLASH20",
        targetTime: DateTime.now().add(const Duration(days: 2, hours: 4, minutes: 15, seconds: 0)),
      ),
      PromoSlide(
        title: "🎓 Mentor Special - 15% Off",
        description: "Book a direct 1-on-1 session with our top verified research mentors. Master your thesis and project path now!",
        code: "MENTOR15",
        targetTime: DateTime.now().add(const Duration(days: 5, hours: 8, minutes: 45, seconds: 30)),
      ),
    ];

    // Page switcher timer (every 4 seconds)
    _pageTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_pageController.hasClients) {
        int nextPage = _currentPage + 1;
        if (nextPage >= _slides.length) {
          nextPage = 0;
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });

    // Live countdown refresh timer (every 1 second)
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _pageTimer?.cancel();
    _countdownTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 185.h,
          child: PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (context, index) {
              final slide = _slides[index];
              Duration remaining = slide.targetTime.difference(DateTime.now());
              if (remaining.isNegative) {
                remaining = Duration.zero;
              }

              final days = remaining.inDays.toString().padLeft(2, '0');
              final hours = (remaining.inHours % 24).toString().padLeft(2, '0');
              final minutes = (remaining.inMinutes % 60).toString().padLeft(2, '0');
              final seconds = (remaining.inSeconds % 60).toString().padLeft(2, '0');

              return _buildSlideCard(slide, days, hours, minutes, seconds);
            },
          ),
        ),
        SizedBox(height: 10.h),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_slides.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              width: 8.w,
              height: 8.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _currentPage == index
                    ? AppColor.textColor
                    : AppColor.textColor.withValues(alpha: 0.3),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildSlideCard(
    PromoSlide slide,
    String days,
    String hours,
    String minutes,
    String seconds,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE5F3FD), // Soft sky blue
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: const Color(0xFFCBE3FF),
          width: 1.w,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Countdown row
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTimeSegment(days, "Days"),
              _buildSeparator(),
              _buildTimeSegment(hours, "Hours"),
              _buildSeparator(),
              _buildTimeSegment(minutes, "Minutes"),
              _buildSeparator(),
              _buildTimeSegment(seconds, "Seconds"),
            ],
          ),
          SizedBox(height: 10.h),
          // Title
          Text(
            slide.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColor.textColor,
            ),
          ),
          SizedBox(height: 6.h),
          // Description
          Text(
            slide.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              height: 1.35.h,
              color: AppColor.textColor.withValues(alpha: 0.8),
            ),
          ),
          const Spacer(),
          // Copy Code Button
          GestureDetector(
            onTap: () {
              Clipboard.setData(ClipboardData(text: slide.code));
              Fluttertoast.showToast(
                msg: "Coupon code '${slide.code}' copied!",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                backgroundColor: AppColor.textColor,
                textColor: Colors.white,
                fontSize: 14.sp,
              );
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: AppColor.textColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.copy_rounded,
                    color: Colors.white,
                    size: 13.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Copy Code',
                    style: GoogleFonts.poppins(
                      fontSize: 11.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSegment(String val, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          val,
          style: GoogleFonts.poppins(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: AppColor.textColor,
            height: 1.1,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 9.sp,
            color: AppColor.c797A7C,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      child: Text(
        '.',
        style: GoogleFonts.poppins(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColor.textColor,
          height: 1.0,
        ),
      ),
    );
  }
}
