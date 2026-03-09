import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/provider/opportunity_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_model.dart';

class OpportunityCard extends StatefulWidget {
  final List<OpportunityModel> opportunities;
  final Function(int count)? onFavoriteCountChanged;
  const OpportunityCard({
    super.key,
    required this.opportunities,
    this.onFavoriteCountChanged,
  });

  @override
  State<OpportunityCard> createState() => _OpportunityCardState();
}

class _OpportunityCardState extends State<OpportunityCard> {
  void _toggleFavorite(int index) {
    Provider.of<OpportunityProvider>(
      context,
      listen: false,
    ).toggleFavorite(index);

    if (widget.onFavoriteCountChanged != null) {
      final provider = Provider.of<OpportunityProvider>(context, listen: false);
      widget.onFavoriteCountChanged!(provider.favoriteCount);
    }
  }

  ImageProvider _getImageProvider(String imageUrl) {
    final String cleanUrl = imageUrl.trim();
    if (cleanUrl.toLowerCase().contains('assets/') ||
        cleanUrl.toLowerCase().contains('assets\\')) {
      int index = cleanUrl.toLowerCase().indexOf('assets');
      String assetPath = cleanUrl.substring(index);
      return AssetImage(assetPath);
    }
    if (cleanUrl.isEmpty || !cleanUrl.startsWith('http')) {
      return const AssetImage('assets/images/img1.png');
    }
    return NetworkImage(cleanUrl);
  }

  Widget _buildInfoRow(IconData icon, String text, String? price) {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateTo(Routes.mentorProfileScreen);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColor.textColor, size: 20.sp),
              SizedBox(width: 10.w),
              Text(
                text,
                style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
              ),
            ],
          ),
          price != null
              ? Text(
                  '\$${price}',
                  style: TextStyle(color: AppColor.c03045E, fontSize: 14.sp),
                )
              : const SizedBox(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.opportunities.asMap().entries.map((entry) {
        final int index = entry.key;
        final model = entry.value;
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
          child: GestureDetector(
            onTap: () {
              NavigationService.navigateTo(Routes.opportunityDetail);
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.r),
                        ),
                        child: Image(
                          image: _getImageProvider(model.imageUrl),
                          height: 180.h,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              height: 180.h,
                              width: double.infinity,
                              color: Colors.grey[300],
                              child: const Icon(
                                Icons.broken_image,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 15.h,
                        left: 15.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 5.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xff00E5FF),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Text(
                            model.category,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15.h,
                        right: 15.w,
                        child: GestureDetector(
                          onTap: () => _toggleFavorite(index),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              model.isFavorite == true
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: model.isFavorite == true
                                  ? Colors.red
                                  : AppColor.textColor,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          model.title,
                          style: TextStyle(
                            color: AppColor.textColor,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          model.description,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14.sp,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 15.h),
                        _buildInfoRow(
                          Icons.person_outline,
                          model.doctor,
                          '120',
                        ),
                        SizedBox(height: 8.h),
                        _buildInfoRow(
                          Icons.calendar_month_outlined,
                          'Deadline: ${model.deadline}',
                          null,
                        ),
                        SizedBox(height: 20.h),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              NavigationService.navigateTo(
                                Routes.paymentScreen,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff000066),
                              padding: EdgeInsets.symmetric(vertical: 15.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.r),
                              ),
                            ),
                            child: Text(
                              'Apply Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
