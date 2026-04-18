import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ibraheemaltamim_flutter/features/service/model/service_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ServiceCard extends StatelessWidget {
  final Datum service;
  final bool isExpanded;
  final VoidCallback onTap;
  final IconData serviceIcon;
  final Color serviceColor;
  final bool isLoading;

  const ServiceCard({
    super.key,
    required this.service,
    required this.isExpanded,
    required this.onTap,
    required this.serviceIcon,
    required this.serviceColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: AnimatedContainer(
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
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.r),
            border: const Border(
              left: BorderSide(color: Color(0xFF0077B6), width: 4.0),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: isLoading ? null : onTap,
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: serviceColor,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: _buildIcon(),
                      ),
                      if (!isLoading)
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
                  service.title ?? 'Loading Service...',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff000066),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  service.overview ?? 'This is a placeholder for the overview.',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                    height: 1.5,
                  ),
                ),
                AnimatedCrossFade(
                  firstChild: const SizedBox(width: double.infinity),
                  secondChild: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      Divider(
                        color: const Color(0xFF0077B6).withOpacity(0.25),
                        thickness: 1,
                        height: 1,
                      ),
                      SizedBox(height: 20.h),
                      Html(
                        data: service.description ?? 'Loading description...',
                        style: {
                          "body": Style(
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                            fontSize: FontSize(14.sp),
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF6B7280),
                            lineHeight: const LineHeight(1.6),
                          ),
                          "p": Style(
                            margin: Margins.zero,
                            padding: HtmlPaddings.zero,
                          ),
                        },
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Starting from",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xff000066),
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "\$${service.startingPrice ?? '0'}",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.w800,
                                  color: const Color(0xff000066),
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton.icon(
                            onPressed: isLoading
                                ? null
                                : () => launchWhatsApp(
                                    context: context,
                                    phoneNumber:
                                        service.whatsAppNum ?? '+440123456789',
                                  ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff000066),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Start on",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    if (isLoading) return Container();

    if (service.icon != null && service.icon.toString().isNotEmpty) {
      String iconPath = service.icon.toString();
      String fullUrl = iconPath.startsWith('http')
          ? iconPath
          : (iconPath.startsWith('/')
                ? "$imageUrl$iconPath"
                : "$imageUrl/$iconPath");

      if (fullUrl.toLowerCase().endsWith('.svg')) {
        return Padding(
          padding: EdgeInsets.all(12.sp),
          child: SvgPicture.network(
            fullUrl,
            placeholderBuilder: (BuildContext context) => SizedBox(
              width: 24.sp,
              height: 24.sp,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
          ),
        );
      } else {
        return Padding(
          padding: EdgeInsets.all(12.sp),
          child: CachedNetworkImage(
            imageUrl: fullUrl,
            placeholder: (context, url) => SizedBox(
              width: 24.sp,
              height: 24.sp,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            ),
            errorWidget: (context, url, error) =>
                Icon(serviceIcon, color: Colors.white, size: 24.sp),
          ),
        );
      }
    }
    return Icon(serviceIcon, color: Colors.white, size: 24.sp);
  }
}
