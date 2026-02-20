import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ibraheemaltamim_flutter/features/home/widgets/build_waiting_list_card_widget.dart';
import 'package:ibraheemaltamim_flutter/features/home/widgets/opportunity_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  int _favoriteCount = 0;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _launchWhatsApp() async {
    const phoneNumber = "+8801789398972";
    final whatsappUrl = Uri.parse("whatsapp://send?phone=$phoneNumber");
    final webUrl = Uri.parse("https://wa.me/$phoneNumber");

    try {
      // Try WhatsApp app first
      if (await canLaunchUrl(whatsappUrl)) {
        await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
      }
      // Fallback to Web URL (wa.me)
      else if (await canLaunchUrl(webUrl)) {
        await launchUrl(webUrl, mode: LaunchMode.externalApplication);
      }
      // If canLaunchUrl still returns false (common on some Android versions),
      // try launching anyway as a last resort
      else {
        try {
          await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Could not launch WhatsApp or Browser'),
              ),
            );
          }
        }
      }
    } catch (e) {
      debugPrint("Error launching WhatsApp: $e");
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
                    children: [
                      SizedBox(height: 20.h),
                      _buildHeader(),
                    ],
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
                        OpportunityCard(
                          onFavoriteCountChanged: (count) {
                            setState(() {
                              _favoriteCount = count;
                            });
                          },
                        ),
                        SizedBox(height: 100.h), // Space for navbar
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 20.w,
              bottom: 110.h,
              child: GestureDetector(
                onTap: _launchWhatsApp,
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
        const Spacer(),
        _buildCircularIconBtn(Icons.favorite_border, () {
          // TODO: Implement favorite action
        }, badgeCount: _favoriteCount),
        SizedBox(width: 8.w),
        _buildCircularIconBtn(Icons.notifications_none, () {
          // TODO: Implement notifications action
        }),
      ],
    );
  }

  Widget _buildCircularIconBtn(
    IconData icon,
    VoidCallback onTap, {
    int badgeCount = 0,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44.w,
        height: 44.w,
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(100.r),
          boxShadow: [
            BoxShadow(
              color: AppColor.blackColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Center(
              child: Icon(icon, color: AppColor.textColor, size: 22.sp),
            ),
            if (badgeCount > 0)
              Positioned(
                top: -01.h,
                right: -01.w,
                child: Container(
                  padding: EdgeInsets.all(4.w),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  constraints: BoxConstraints(minWidth: 16.w, minHeight: 16.w),
                  child: Center(
                    child: Text(
                      badgeCount.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
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
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 200.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.r),
                        topRight: Radius.circular(20.r),
                      ),
                    ),
                  );
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
          onTap: () {},
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
