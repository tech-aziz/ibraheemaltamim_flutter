import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';
import 'package:ibraheemaltamim_flutter/provider/opportunity_provider.dart';
import 'package:provider/provider.dart';
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
  void dispose() {
    _searchController.dispose();
    super.dispose();
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
                              SizedBox(height: 20.h),
                              _buildSearchBar(),
                              SizedBox(height: 20.h),
                              const WaitingListCard(),
                              SizedBox(height: 25.h),
                              _buildSectionHeader('Opportunities'),
                              SizedBox(height: 15.h),
                            ],
                          ),
                        ),
                        Consumer<OpportunityProvider>(
                          builder: (context, opportunityProvider, child) {
                            return OpportunityCard(
                              opportunities: opportunityProvider.opportunities
                                  .take(2)
                                  .toList(),
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
    return Row(
      children: [
        // ProfileScreen
        GestureDetector(
          onTap: () {
            NavigationService.navigateTo(Routes.profileScreen);
          },
          child: Row(
            children: [
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: _getImageProvider('assets/images/person.png'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Hi, Jenny',
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
        Consumer<OpportunityProvider>(
          builder: (context, opportunityProvider, child) {
            return CircularIconBtn(
              icon: Icons.favorite_border,
              onTap: () {
                NavigationService.navigateTo(Routes.wishlistScreen);
              },
              badgeCount: opportunityProvider.favoriteCount,
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
