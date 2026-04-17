import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/wish_list_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/provider/wishlist_provider.dart';
import 'package:provider/provider.dart';
import 'package:ibraheemaltamim_flutter/networks/endpoints.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_remove_favourite/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_wishlist/rx.dart';

class WishlistCardWidget extends StatefulWidget {
  final List<Datum> wishLists;
  final Function(int count)? onFavoriteCountChanged;
  const WishlistCardWidget({
    super.key,
    required this.wishLists,
    this.onFavoriteCountChanged,
  });

  @override
  State<WishlistCardWidget> createState() => _WishlistCardWidgetState();
}

class _WishlistCardWidgetState extends State<WishlistCardWidget> {

  
  Future<void> _toggleFavorite(int index) async {
    final model = widget.wishLists[index];
    
    // Fallback ID checking using fav object if parent id isn't populated
    final favId = model.id?.toString();
    if (favId != null && favId.isNotEmpty) {
      // Show loader
      showDialog(
        context: context,
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.3),
        builder: (context) => const Center(
          child: CircularProgressIndicator(color: Colors.white),
        ),
      );

      // Execute the API hook
      final success = await removeFavouriteRx.deleteFavourite(favId);
      
      // Close the loader
      if (mounted) Navigator.pop(context);

      if (success) {
        // Re-fetch wishlist on successful removal
        getWishlistRx.fetchWishlist();
      }
    } else {
      // Local state fallback if needed
      Provider.of<WishlistProvider>(context, listen: false).toggleFavorite(index);

      if (widget.onFavoriteCountChanged != null) {
        final provider = Provider.of<WishlistProvider>(context, listen: false);
        widget.onFavoriteCountChanged!(provider.favoriteCount);
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
      String fullUrl = cleanUrl.startsWith('/') ? "$imageUrl$cleanUrl" : "$imageUrl/$cleanUrl";
      return NetworkImage(fullUrl);
    }
  }

  Widget _buildInfoRow(IconData icon, String text, String? price) {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateTo(Routes.mentorProfileScreen);
      },
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
    return Column(
      children: widget.wishLists.asMap().entries.map((entry) {
        final model = entry.value;
        final fav = model.favouriteable;
        final categoryDisplay = model.favouriteableType?.split('\\\\').last ?? 'General';
        
        return Padding(
          padding: EdgeInsets.only(bottom: 20.h, left: 20.w, right: 20.w),
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
                        image: _getImageProvider(fav?.thumbnail?.toString() ?? ''),
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
                          color: const Color(0xff00E5FF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Text(
                          categoryDisplay,
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
                        onTap: () => _toggleFavorite(entry.key),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.red,
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
                        fav?.title ?? 'No Title',
                        style: TextStyle(
                          color: AppColor.textColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        fav?.overview ?? 'No description available',
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
                        'Mentor #${fav?.mentorId ?? '-'}',
                        fav?.price?.toString(),
                      ),
                      SizedBox(height: 8.h),
                      _buildInfoRow(
                        Icons.calendar_month_outlined,
                        'Deadline: ${fav?.deadLine?.toIso8601String().split('T').first ?? '-'}',
                        null,
                      ),
                      SizedBox(height: 20.h),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            NavigationService.navigateTo(
                              Routes.opportunityDetail,
                              arguments: {'id': model.favouriteableId},
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
        );
      }).toList(),
    );
  }
}
