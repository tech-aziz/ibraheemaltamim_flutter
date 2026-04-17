import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';
import 'package:ibraheemaltamim_flutter/features/service/data/rx.dart';
import 'package:ibraheemaltamim_flutter/features/service/model/service_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:shimmer/shimmer.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  int? expandedIndex;

  final List<IconData> _icons = [
    Icons.bar_chart,
    Icons.find_in_page_outlined,
    Icons.draw_outlined,
    Icons.fact_check_outlined,
    Icons.track_changes,
    Icons.biotech,
  ];

  final List<Color> _iconColors = [
    const Color(0xFF20C997),
    const Color(0xFF9B51E0),
    const Color(0xFFE0519B),
    const Color(0xFFF43F5E),
    const Color(0xFFF97316),
    const Color(0xFF10B981),
  ];

  @override
  void initState() {
    super.initState();
    getServicesRx.fetchServices();
  }

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
                  child: StreamBuilder<ServiceModel>(
                    stream: getServicesRx.getFileData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return ListView.separated(
                          padding: EdgeInsets.only(
                            top: 10.h,
                            left: 20.w,
                            right: 20.w,
                            bottom: 100.h,
                          ),
                          itemCount: 6,
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              baseColor: Colors.grey[200]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                padding: EdgeInsets.all(20.w),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 48.w,
                                          height: 48.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(14.r),
                                          ),
                                        ),
                                        Container(
                                          width: 28.w,
                                          height: 28.w,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 18.h),
                                    Container(
                                      width: 200.w,
                                      height: 18.h,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 8.h),
                                    Container(
                                      width: double.infinity,
                                      height: 14.h,
                                      color: Colors.white,
                                    ),
                                    SizedBox(height: 6.h),
                                    Container(
                                      width: 250.w,
                                      height: 14.h,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      final servicesList = snapshot.data?.data ?? [];
                      if (servicesList.isEmpty) {
                        return const Center(
                          child: Text('No services available.'),
                        );
                      }
                      return ListView.separated(
                        padding: EdgeInsets.only(
                          top: 10.h,
                          left: 20.w,
                          right: 20.w,
                          bottom: 100.h,
                        ),
                        itemCount: servicesList.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16.h),
                        itemBuilder: (context, index) {
                          final service = servicesList[index];
                          final isExpanded = expandedIndex == index;
                          final serviceIcon = _icons[index % _icons.length];
                          final serviceColor =
                              _iconColors[index % _iconColors.length];

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
                                              color: serviceColor,
                                              borderRadius:
                                                  BorderRadius.circular(14.r),
                                            ),
                                            child: Builder(
                                              builder: (context) {
                                                if (service.icon != null &&
                                                    service.icon
                                                        .toString()
                                                        .isNotEmpty) {
                                                  String iconPath = service.icon
                                                      .toString();
                                                  String fullUrl =
                                                      iconPath.startsWith(
                                                        'http',
                                                      )
                                                      ? iconPath
                                                      : (iconPath.startsWith(
                                                              '/',
                                                            )
                                                            ? "$imageUrl$iconPath"
                                                            : "$imageUrl/$iconPath");

                                                  if (fullUrl
                                                      .toLowerCase()
                                                      .endsWith('.svg')) {
                                                    return Padding(
                                                      padding: EdgeInsets.all(
                                                        12.sp,
                                                      ),
                                                      child: SvgPicture.network(
                                                        fullUrl,
                                                        placeholderBuilder:
                                                            (
                                                              BuildContext
                                                              context,
                                                            ) => SizedBox(
                                                              width: 24.sp,
                                                              height: 24.sp,
                                                              child:
                                                                  const CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                    strokeWidth:
                                                                        2,
                                                                  ),
                                                            ),
                                                      ),
                                                    );
                                                  } else {
                                                    return Padding(
                                                      padding: EdgeInsets.all(
                                                        12.sp,
                                                      ),
                                                      child: CachedNetworkImage(
                                                        imageUrl: fullUrl,
                                                        placeholder:
                                                            (
                                                              context,
                                                              url,
                                                            ) => SizedBox(
                                                              width: 24.sp,
                                                              height: 24.sp,
                                                              child:
                                                                  const CircularProgressIndicator(
                                                                    color: Colors
                                                                        .white,
                                                                    strokeWidth:
                                                                        2,
                                                                  ),
                                                            ),
                                                        errorWidget:
                                                            (
                                                              context,
                                                              url,
                                                              error,
                                                            ) => Icon(
                                                              serviceIcon,
                                                              color:
                                                                  Colors.white,
                                                              size: 24.sp,
                                                            ),
                                                      ),
                                                    );
                                                  }
                                                }

                                                return Icon(
                                                  serviceIcon,
                                                  color: Colors.white,
                                                  size: 24.sp,
                                                );
                                              },
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
                                      service.title ?? '',
                                      style: TextStyle(
                                        fontSize: 18.sp,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xff000066),
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      service.overview ?? '',
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
                                          SizedBox(height: 10.h),
                                          Html(
                                            data: service.description ?? '',
                                            style: {
                                              "body": Style(
                                                margin: Margins.zero,
                                                padding: HtmlPaddings.zero,
                                                fontSize: FontSize(14.sp),
                                                fontWeight: FontWeight.w400,
                                                color: const Color(0xFF6B7280),
                                                lineHeight: const LineHeight(
                                                  1.6,
                                                ),
                                              ),
                                              "p": Style(
                                                margin: Margins.zero,
                                                padding: HtmlPaddings.zero,
                                              ),
                                            },
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
                                                      fontWeight:
                                                          FontWeight.w700,
                                                      color: const Color(
                                                        0xff000066,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 4.h),
                                                  Text(
                                                    "\$${service.startingPrice ?? ''}",
                                                    style: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight:
                                                          FontWeight.w800,
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
                                                  phoneNumber:
                                                      service.whatsAppNum ??
                                                      '+440123456789',
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: const Color(
                                                    0xff000066,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          16.r,
                                                        ),
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
                                                        fontWeight:
                                                            FontWeight.w400,
                                                        height: 1.2,
                                                      ),
                                                    ),
                                                    Text(
                                                      "WhatsApp",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 13.sp,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
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
