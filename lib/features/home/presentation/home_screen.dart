import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/features/profile/model/user_info_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/opportunity_list_model.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_opportunity_list/rx.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ibraheemaltamim_flutter/provider/opportunity_provider.dart';
import 'package:ibraheemaltamim_flutter/features/home/data/rx_wishlist/rx.dart';
import 'package:ibraheemaltamim_flutter/features/home/model/wish_list_model.dart';
import 'package:provider/provider.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/profile_avatar.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/circular_icon_btn.dart';
import 'package:ibraheemaltamim_flutter/features/home/widgets/build_waiting_list_card_widget.dart';
import 'package:ibraheemaltamim_flutter/features/home/widgets/filter_dialog.dart';
import 'package:ibraheemaltamim_flutter/features/home/widgets/opportunity_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userInfoRxObj.fetchUserInfo();
    getOpportunitiesRx.fetchOpportunities(perPage: 15, isRefresh: true);
    getWishlistRx.fetchWishlist();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [_buildHeader()],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              UIHelper.verticalSpace(10.h),
                              _buildSearchBar(),
                              SizedBox(height: 20.h),
                              const WaitingListCard(),
                              SizedBox(height: 25.h),
                              _buildSectionHeader('Opportunities'),
                              SizedBox(height: 15.h),
                            ],
                          ),
                        ),
                        StreamBuilder<OpportunityListModel>(
                          stream: getOpportunitiesRx.getFileData,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                itemCount: 2,
                                separatorBuilder: (context, index) => SizedBox(height: 20.h),
                                itemBuilder: (context, index) {
                                  return Shimmer.fromColors(
                                    baseColor: Colors.grey[200]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      height: 350.h,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20.r),
                                      ),
                                    ),
                                  );
                                },
                              );
                            }
                            if (snapshot.hasError) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Center(child: Text('Error: ${snapshot.error}')),
                              );
                            }
                            
                            final list = snapshot.data?.data ?? [];
                            if (list.isEmpty) {
                              return Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                child: const Center(child: Text('No opportunities available.')),
                              );
                            }
                            
                            return OpportunityCard(
                              opportunities: list.take(15).toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
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

  Widget _buildHeader() {
    return StreamBuilder<UserInfoModel>(
      stream: userInfoRxObj.dataFetcher.stream,
      builder: (context, snapshot) {
        final user = snapshot.data?.data;
        return Row(
          children: [
            // ProfileScreen
            GestureDetector(
              onTap: () {
                NavigationService.navigateTo(Routes.profileScreen);
              },
              child: Row(
                children: [
                  ProfileAvatar(
                    imageUrl: user?.avatar,
                    radius: 25,
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Hi, ${user?.name?.split(' ').first ?? 'Guest'}',
                    style: TextStyle(
                      color: AppColor.textColor,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            StreamBuilder<WishListModel>(
              stream: getWishlistRx.getFileData,
              builder: (context, snapshot) {
                return CircularIconBtn(
                  icon: Icons.favorite_border,
                  iconColor: Colors.red,
                  onTap: () {
                    NavigationService.navigateTo(Routes.wishlistScreen);
                  },
                  badgeCount: snapshot.data?.data?.length ?? 0,
                );
              },
            ),
            SizedBox(width: 8.w),
            CircularIconBtn(
              icon: Icons.notifications_none,
              onTap: () {
                NavigationService.navigateTo(Routes.notificationScreen);
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/search.png',
            fit: BoxFit.cover,
            color: AppColor.textColor,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              controller: _searchController,
              cursorRadius: const Radius.circular(12),
              cursorColor: AppColor.textColor,
              style: TextStyle(color: AppColor.textColor, fontSize: 16.sp),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: AppColor.c707171, fontSize: 16.sp),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return const FilterDialog();
                },
              );
            },
            child: Image.asset(
              'assets/images/filter.png',
              fit: BoxFit.cover,
              color: AppColor.textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: AppColor.textColor,
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        GestureDetector(
          onTap: () {
            NavigationService.navigateTo(Routes.allOpportunitiesScreen);
          },
          child: Text(
            'View all',
            style: TextStyle(
              color: AppColor.textColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
