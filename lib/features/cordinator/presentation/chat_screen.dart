import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/helpers/all_routes.dart';
import 'package:ibraheemaltamim_flutter/helpers/navigation_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _activeTab = 'All';

  final List<Map<String, dynamic>> _chats = [
    {
      'name': 'Dr. John Smith',
      'message': 'I need more information about the pediatric epilepsy cases...',
      'time': '9:35 AM',
      'unreadCount': 2,
      'isGroup': false,
      'avatar': 'https://images.unsplash.com/photo-1537368910025-700350fe46c7?q=80&w=150&auto=format&fit=crop',
      'isOnline': true,
    },
    {
      'name': 'COVID-19 Vaccine Study',
      'message': '8 members',
      'time': 'Yesterday',
      'unreadCount': 0,
      'isGroup': true,
      'avatar': '',
      'isOnline': true,
    },
    {
      'name': 'Dr. Sarah Lee',
      'message': 'Jenny, have you reviewed the orthopedic study results yet?',
      'time': '9:40 AM',
      'unreadCount': 1,
      'isGroup': false,
      'avatar': 'https://images.unsplash.com/photo-1594744803329-e58b31de215f?q=80&w=150&auto=format&fit=crop',
      'isOnline': true,
    },
    {
      'name': 'Dr. Emily Brown',
      'message': 'Can we schedule a meeting for next week to discuss this?',
      'time': 'Yesterday',
      'unreadCount': 0,
      'isGroup': false,
      'avatar': 'https://images.unsplash.com/photo-1573496359142-b8d87734a5a2?q=80&w=150&auto=format&fit=crop',
      'isOnline': true,
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Custom Header Row (Static representation, back option is handled or hidden as tab)
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
          child: Row(
            children: [
              Text(
                'Messages',
                style: TextStyle(
                  color: const Color(0xff03045E),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Search Input Field
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Icon(
                  Icons.search,
                  color: Colors.grey.shade400,
                  size: 20.sp,
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search messages...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 15.sp,
                      ),
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                    style: TextStyle(
                      color: const Color(0xff03045E),
                      fontSize: 15.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
        // Custom Segmented Pill Tab Bar
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            height: 50.h,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: const Color(0xffB1E3F1),
              borderRadius: BorderRadius.circular(30.r),
            ),
            child: Row(
              children: [
                _buildTabButton('All'),
                _buildTabButton('Private'),
                _buildTabButton('Groups'),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.h),
        // Messages List View
        Expanded(
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 110.h),
            itemCount: _chats.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              final item = _chats[index];
              // Filter items based on active tab
              if (_activeTab == 'Private' && item['isGroup'] == true) {
                return const SizedBox.shrink();
              }
              if (_activeTab == 'Groups' && item['isGroup'] == false) {
                return const SizedBox.shrink();
              }

              return _buildChatTile(item);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(String label) {
    final bool isActive = _activeTab == label;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _activeTab = label;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isActive ? const Color(0xff03045E) : Colors.transparent,
            borderRadius: BorderRadius.circular(26.r),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: isActive ? Colors.white : const Color(0xff03045E),
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChatTile(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () {
        NavigationService.navigateTo(Routes.messageScreen);
      },
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Row(
          children: [
          // Avatar with online status badge
          Stack(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: const BoxDecoration(
                  color: Color(0xffD6F2FB),
                  shape: BoxShape.circle,
                ),
                child: item['isGroup']
                    ? Center(
                        child: Icon(
                          Icons.group_outlined,
                          color: const Color(0xff03045E),
                          size: 26.sp,
                        ),
                      )
                    : ClipOval(
                        child: Image.network(
                          item['avatar'],
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/placeholder.jpg',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
              ),
              if (item['isOnline'] == true)
                Positioned(
                  bottom: 2.w,
                  right: 2.w,
                  child: Container(
                    width: 12.w,
                    height: 12.w,
                    decoration: BoxDecoration(
                      color: const Color(0xff12B76A),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2.w),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(width: 14.w),
          // Name and Message Preview
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['name'],
                  style: TextStyle(
                    color: const Color(0xff03045E),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  item['message'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13.sp,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10.w),
          // Time and Unread Badge
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                item['time'],
                style: TextStyle(color: Colors.grey.shade400, fontSize: 11.sp),
              ),
              SizedBox(height: 6.h),
              if (item['unreadCount'] > 0)
                Container(
                  width: 20.w,
                  height: 20.w,
                  decoration: const BoxDecoration(
                    color: Color(0xff03045E),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${item['unreadCount']}',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              else
                SizedBox(height: 20.w),
            ],
          ),
        ],
      ),
    ),);
  }
}
