import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';
import 'package:ibraheemaltamim_flutter/features/message/presentation/chat_screen.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'name': 'Dr. John Smith',
      'message': 'I need more information about',
      'time': '9:35 AM',
      'unreadCount': 2,
      'isOnline': true,
      'isGroup': false,
      'image': 'assets/images/img1.png',
    },
    {
      'name': 'COVID-19 Vaccine Study',
      'message': '8 members',
      'time': 'Yesterday',
      'unreadCount': 0,
      'isOnline': true,
      'isGroup': true,
      'image': null,
    },
    {
      'name': 'Dr. Sarah Lee',
      'message': 'Jenny, have you reviewed',
      'time': '9:40 AM',
      'unreadCount': 1,
      'isOnline': true,
      'isGroup': false,
      'image': 'assets/images/img1.png', // Using available image
    },
    {
      'name': 'Dr. Emily Brown',
      'message': 'Can we schedule a meeting for next..',
      'time': 'Yesterday',
      'unreadCount': 0,
      'isOnline': false,
      'isGroup': false,
      'image': 'assets/images/img1.png',
    },
    {
      'name': 'Dr. James Wilson',
      'message': 'The latest results look promising.',
      'time': '2 days ago',
      'unreadCount': 0,
      'isOnline': false,
      'isGroup': false,
      'image': 'assets/images/img1.png',
    },
  ];

  final TextEditingController _searchController = TextEditingController();

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
              children: [
                CustomAppbar(
                  title: 'Messages',
                  onTap: () {
                    NavigationService.navigateToWithArgs(Routes.navbar, {
                      "pageNum": 0,
                    });
                  },
                ),
                SizedBox(height: 20.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildSearchBar(),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return _buildMessageTile(_messages[index]);
                    },
                  ),
                ),
              ],
            ),

            Positioned(
              right: 20.w,
              bottom: 110.h,
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
        ],
      ),
    );
  }

  Widget _buildMessageTile(Map<String, dynamic> data) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ChatScreen()),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15.h),
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundColor: const Color(0xffe8f6ff),
                  backgroundImage: data['image'] != null
                      ? AssetImage(data['image'])
                      : null,
                  child: data['isGroup']
                      ? Icon(
                          Icons.groups,
                          color: const Color(0xff0077b6),
                          size: 30.sp,
                        )
                      : null,
                ),
                if (data['isOnline'])
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 14.w,
                      height: 14.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 15.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        data['name'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff001d61),
                        ),
                      ),
                      Text(
                        data['time'],
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          data['message'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      if (data['unreadCount'] > 0)
                        Container(
                          padding: EdgeInsets.all(6.w),
                          decoration: const BoxDecoration(
                            color: Color(0xff0077b6),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            data['unreadCount'].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
