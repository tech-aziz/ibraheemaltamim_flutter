import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int? expandedIndex;

  final List<Map<String, dynamic>> services = [
    {
      "title": "Statistical Analysis",
      "description":
          "Advanced statistical methods for robust research conclusions.",
      "icon": Icons.bar_chart,
      "iconColor": const Color(0xFF20C997),
      "details":
          "Comprehensive statistical support including descriptive analysis, inferential statistics, regression modeling, survival analysis, and more. Our experts use SPSS, R, and Stata to ensure accuracy.",
      "features": [
        "Data cleaning & preparation",
        "Hypothesis testing",
        "Multivariate analysis",
        "Results interpretation",
      ],
      "price": "\$299",
    },
    {
      "title": "Systematic Review",
      "description":
          "Rigorous literature synthesis following PRISMA guidelines.",
      "icon": Icons.find_in_page_outlined,
      "iconColor": const Color(0xFF9B51E0),
      "details":
          "Comprehensive literature search and synthesis following PRISMA guidelines to ensure high-quality reviews.",
      "features": [
        "Protocol development",
        "Literature search strategy",
        "Data extraction",
        "Quality assessment",
      ],
      "price": "\$399",
    },
    {
      "title": "Manuscript Writing",
      "description": "Expert scientific writing and editing services.",
      "icon": Icons.draw_outlined,
      "iconColor": const Color(0xFFE0519B),
      "details":
          "Professional manuscript writing assistance from experienced researchers and writers.",
      "features": [
        "Drafting full manuscript",
        "Formatting for specific journals",
        "Proofreading & editing",
        "Plagiarism check",
      ],
      "price": "\$499",
    },
    {
      "title": "Publication Support",
      "description": "Expert scientific writing and editing services.",
      "icon": Icons.fact_check_outlined,
      "iconColor": const Color(0xFFF43F5E),
      "details":
          "Complete support for the publication process, including journal selection, submission, and responding to reviewers.",
      "features": [
        "Journal selection",
        "Cover letter writing",
        "Submission assistance",
        "Response to reviewers",
      ],
      "price": "\$199",
    },
    {
      "title": "Research Methodology",
      "description": "Expert scientific writing and editing services.",
      "icon": Icons.track_changes,
      "iconColor": const Color(0xFFF97316),
      "details":
          "Consultation and design of robust research methodologies tailored to your study objectives.",
      "features": [
        "Study design",
        "Sample size calculation",
        "Data collection tools",
        "Analytical plan",
      ],
      "price": "\$249",
    },
    {
      "title": "Lab & Clinical Studies",
      "description": "Expert scientific writing and editing services.",
      "icon": Icons.biotech,
      "iconColor": const Color(0xFF10B981),
      "details":
          "Specialized support for laboratory and clinical research studies.",
      "features": [
        "Clinical trial design",
        "Regulatory compliance",
        "Data management",
        "Clinical study reports",
      ],
      "price": "\$599",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                CustomAppbar(
                  title: 'Service',
                  onTap: () {
                    NavigationService.navigateToWithArgs(Routes.navbar, {
                      "pageNum": 0,
                    });
                  },
                ),

                Expanded(
                  child: ListView.separated(
                    padding: EdgeInsets.only(
                      top: 10.h,
                      left: 20.w,
                      right: 20.w,
                      bottom: 100.h,
                    ),
                    itemCount: services.length,
                    separatorBuilder: (context, index) =>
                        SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final service = services[index];
                      final isExpanded = expandedIndex == index;

                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        // To avoid border rendering overflow issues, apply left border inside
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            border: const Border(
                              left: BorderSide(
                                color: Color(0xFF0077B6),
                                width: 4.0,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 20.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (isExpanded) {
                                        expandedIndex = null;
                                      } else {
                                        expandedIndex = index;
                                      }
                                    });
                                  },
                                  behavior: HitTestBehavior.opaque,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 48.w,
                                        height: 48.w,
                                        decoration: BoxDecoration(
                                          color: service['iconColor'],
                                          borderRadius: BorderRadius.circular(
                                            14.r,
                                          ),
                                        ),
                                        child: Icon(
                                          service['icon'],
                                          color: Colors.white,
                                          size: 24.sp,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.h),
                                        child: Icon(
                                          isExpanded
                                              ? Icons.keyboard_arrow_up
                                              : Icons.keyboard_arrow_down,
                                          color: const Color(0xFF8896A6),
                                          size: 28.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 18.h),
                                Text(
                                  service['title'],
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w800,
                                    color: const Color(0xff000066),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  service['description'],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0xFF6B7280),
                                    height: 1.5,
                                  ),
                                ),
                                AnimatedCrossFade(
                                  firstChild: const SizedBox(
                                    width: double.infinity,
                                  ),
                                  secondChild: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 20.h),
                                      Divider(
                                        color: const Color(
                                          0xFF0077B6,
                                        ).withOpacity(0.25),
                                        thickness: 1,
                                        height: 1,
                                      ),
                                      SizedBox(height: 20.h),
                                      Text(
                                        service['details'] ?? '',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: const Color(0xFF6B7280),
                                          height: 1.6,
                                        ),
                                      ),
                                      SizedBox(height: 24.h),
                                      ...((service['features']
                                                  as List<String>?) ??
                                              [])
                                          .map(
                                            (feature) => Padding(
                                              padding: EdgeInsets.only(
                                                bottom: 14.h,
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Icon(
                                                    Icons.check,
                                                    color: const Color(
                                                      0xFF0077B6,
                                                    ),
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(width: 14.w),
                                                  Expanded(
                                                    child: Text(
                                                      feature,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: const Color(
                                                          0xff000066,
                                                        ),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 1.3,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                      SizedBox(height: 16.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Starting from",
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w700,
                                                  color: const Color(
                                                    0xff000066,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 4.h),
                                              Text(
                                                service['price'] ?? '',
                                                style: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w800,
                                                  color: const Color(
                                                    0xff000066,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () => launchWhatsApp(
                                              context: context,
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: const Color(
                                                0xff000066,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16.r),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                                vertical: 12.h,
                                              ),
                                              elevation: 0,
                                            ),
                                            icon: Image.asset(
                                              'assets/images/whatapp_icon.png',
                                              width: 22.w,
                                              height: 22.w,
                                            ),
                                            label: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Start on",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400,
                                                    height: 1.2,
                                                  ),
                                                ),
                                                Text(
                                                  "WhatsApp",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13.sp,
                                                    fontWeight: FontWeight.w600,
                                                    height: 1.2,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  crossFadeState: isExpanded
                                      ? CrossFadeState.showSecond
                                      : CrossFadeState.showFirst,
                                  duration: const Duration(milliseconds: 300),
                                  layoutBuilder:
                                      (
                                        topChild,
                                        topChildKey,
                                        bottomChild,
                                        bottomChildKey,
                                      ) {
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
                                            Positioned(
                                              key: topChildKey,
                                              child: topChild,
                                            ),
                                          ],
                                        );
                                      },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),

            // WhatsApp Button
            Positioned(
              right: 20.w,
              bottom: 105.h,
              child: GestureDetector(
                onTap: () => launchWhatsApp(context: context),
                child: Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    color: const Color(0xff000066),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Image.asset(
                      'assets/images/whatapp_icon.png',
                      width: 30.w,
                      height: 30.w,
                    ),
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
