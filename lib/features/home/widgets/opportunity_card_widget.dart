import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_list_model.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_add_favourite/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_wishlist/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/wish_list_model.dart'
    as wishlist;
import 'package:ibraheemaltamim_flutter/features/home/data/rx_remove_favourite/rx.dart';
import 'package:skeletonizer/skeletonizer.dart';

class OpportunityCard extends StatefulWidget {
  final List<Datum> opportunities;
  final Function(int count)? onFavoriteCountChanged;
  final bool isLoading;
  const OpportunityCard({
    super.key,
    required this.opportunities,
    this.onFavoriteCountChanged,
    this.isLoading = false,
  });

  @override
  State<OpportunityCard> createState() => _OpportunityCardState();
}

class _OpportunityCardState extends State<OpportunityCard> {
  void _toggleFavorite(int? opportunityId) {
    if (opportunityId != null) {
      final currentWishlist =
          (getWishlistRx.dataFetcher.hasValue
              ? getWishlistRx.dataFetcher.value.data
              : null) ??
          [];
      final existingFavorite = currentWishlist.firstWhere(
        (item) => item.favouriteableId == opportunityId,
        orElse: () => wishlist.Datum(),
      );

      if (existingFavorite.id != null) {
        // Already favorited, so remove it
        removeFavouriteRx.deleteFavourite(existingFavorite.id!.toString());
      } else {
        // Not favorited, so add it
        addFavouriteRx.addFavourite(opportunityId);
      }
    }
  }

  ImageProvider _getImageProvider(String imageUrlPath) {
    final String cleanUrl = imageUrlPath.trim();

    if (cleanUrl.isEmpty) {
      return const AssetImage('assets/images/img1.png');
    }

    if (cleanUrl.toLowerCase().contains('assets/') ||
        cleanUrl.toLowerCase().contains('assets\\\\')) {
      int index = cleanUrl.toLowerCase().indexOf('assets');
      String assetPath = cleanUrl.substring(index);
      return AssetImage(assetPath);
    }

    if (cleanUrl.startsWith('http')) {
      return NetworkImage(cleanUrl);
    } else {
      String fullUrl = cleanUrl.startsWith('/')
          ? "$imageUrl$cleanUrl"
          : "$imageUrl/$cleanUrl";
      return NetworkImage(fullUrl);
    }
  }

  Widget _buildInfoRow(
    IconData icon,
    String text,
    String? price, {
    int? mentorId,
  }) {
    return GestureDetector(
      onTap: mentorId != null
          ? () {
              NavigationService.navigateToWithArgs(Routes.mentorProfileScreen, {
                "id": mentorId,
              });
            }
          : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Icon(icon, color: AppColor.textColor, size: 20.sp),
                SizedBox(width: 10.w),
                Flexible(
                  child: Text(
                    text,
                    style: TextStyle(color: Colors.grey[700], fontSize: 14.sp),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
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
    final displayList = widget.isLoading
        ? List.generate(
            3,
            (index) => Datum(
              id: index,
              title: 'Loading Opportunity Title...',
              overview:
                  'This is a placeholder description for the skeleton loading state.',
              price: '000',
              mentor: Mentor(user: {'name': 'Mentor Name'}),
              deadLine: DateTime.now(),
              categories: [Category(name: 'Category')],
            ),
          )
        : widget.opportunities;

    return Skeletonizer(
      enabled: widget.isLoading,
      child: Column(
        children: [
          ...displayList.asMap().entries.map((entry) {
            final model = entry.value;
            return Padding(
              padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
              child: GestureDetector(
                onTap: () {
                  NavigationService.navigateTo(
                    Routes.opportunityDetail,
                    arguments: {'id': model.id},
                  );
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
                              image: _getImageProvider(
                                model.thumbnail?.toString() ?? '',
                              ),
                              height: 180.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/images/img1.png',
                                  height: 180.h,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
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
                                color: const Color.fromARGB(255, 193, 231, 236),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                model.categories?.isNotEmpty == true
                                    ? model.categories!.first.name ?? 'General'
                                    : 'General',
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
                            child: StreamBuilder<wishlist.WishListModel>(
                              stream: getWishlistRx.getFileData,
                              builder: (context, snapshot) {
                                final isFavorite =
                                    snapshot.data?.data?.any(
                                      (item) =>
                                          item.favouriteableId == model.id,
                                    ) ??
                                    false;
                                return GestureDetector(
                                  onTap: () => _toggleFavorite(model.id),
                                  child: Container(
                                    padding: EdgeInsets.all(8.w),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isFavorite
                                          ? Icons.favorite
                                          : Icons.favorite_border,
                                      color: isFavorite
                                          ? Colors.red
                                          : AppColor.textColor,
                                      size: 20.sp,
                                    ),
                                  ),
                                );
                              },
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
                              model.title ?? 'No Title',
                              style: TextStyle(
                                color: AppColor.textColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              model.overview ?? 'No description available',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 14.sp,
                                height: 1.4,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 15.h),
                            _buildInfoRow(
                              Icons.person_outline,
                              model.mentor?.user is Map
                                  ? (model.mentor?.user['name'] ??
                                        'Mentor #${model.mentorId ?? '-'}')
                                  : 'Mentor #${model.mentorId ?? '-'}',
                              model.price?.toString(),
                              mentorId: model.mentorId,
                            ),
                            SizedBox(height: 8.h),
                            _buildInfoRow(
                              Icons.calendar_month_outlined,
                              'Deadline: ${model.deadLine?.toIso8601String().split('T').first ?? '-'}',
                              null,
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  NavigationService.navigateTo(
                                    Routes.paymentScreen,
                                    arguments: {'id': model.id},
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
          SizedBox(height: 70.h),
        ],
      ),
    );
  }
}
