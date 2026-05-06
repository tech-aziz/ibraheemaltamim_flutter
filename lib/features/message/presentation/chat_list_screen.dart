import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/ui_helpers.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';
import 'package:ibraheemaltamim_flutter/features/message/model/chat_list_model.dart';
import 'package:ibraheemaltamim_flutter/features/message/presentation/message_screen.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:shimmer/shimmer.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    getChatListRxObj.fetchChatList();
    whatsAppCallRxObj.fetchWhatsAppCall();
    if (userInfoRxObj.dataFetcher.valueOrNull == null) {
      userInfoRxObj.fetchUserInfo();
    }
    _searchController.addListener(() {
      setState(() {
        _searchQuery = _searchController.text.toLowerCase();
      });
    });
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
              children: [
                CustomAppbar(
                  title: 'Messages',
                  onTap: () {
                    // NavigationService.navigateToWithArgs(Routes.navbar, {
                    //   "pageNum": 0,
                    // });
                  },
                ),
                UIHelper.verticalSpace(10.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: _buildSearchBar(),
                ),
                SizedBox(height: 10.h),
                Expanded(
                  child: StreamBuilder<ChatListModel>(
                    stream: getChatListRxObj.getFileData,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return _buildShimmerLoading();
                      }
                      if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      }
                      if (!snapshot.hasData ||
                          snapshot.data?.data == null ||
                          snapshot.data!.data!.isEmpty) {
                        return const Center(child: Text('No messages yet'));
                      }

                      final allChats = snapshot.data!.data!;
                      final filteredChats = allChats.where((chat) {
                        final name = _getChatName(chat).toLowerCase();
                        return name.contains(_searchQuery);
                      }).toList();

                      if (filteredChats.isEmpty) {
                        return const Center(child: Text('No results found'));
                      }

                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        itemCount: filteredChats.length,
                        itemBuilder: (context, index) {
                          return _buildMessageTile(filteredChats[index]);
                        },
                      );
                    },
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

  String _getChatName(Datum chat) {
    if (chat.type == 'group') {
      return chat.chatable?.title ?? 'Group Chat';
    } else {
      if (chat.users == null || chat.users!.isEmpty) return 'Unknown';
      final currentUserId = userInfoRxObj.dataFetcher.valueOrNull?.data?.id;
      final otherParticipant = chat.users!.firstWhere(
        (u) => u.userId != currentUserId,
        orElse: () => chat.users!.first,
      );
      return otherParticipant.user?.name ?? 'Unknown';
    }
  }

  String _getChatImage(Datum chat) {
    if (chat.type == 'group') {
      return chat.chatable?.thumbnail ?? '';
    } else {
      if (chat.users == null || chat.users!.isEmpty) return '';
      final currentUserId = userInfoRxObj.dataFetcher.valueOrNull?.data?.id;
      final otherParticipant = chat.users!.firstWhere(
        (u) => u.userId != currentUserId,
        orElse: () => chat.users!.first,
      );
      return otherParticipant.user?.avatar ?? '';
    }
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            margin: EdgeInsets.only(bottom: 15.h),
            height: 90.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.r),
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageTile(Datum data) {
    final isGroup = data.type == 'group';
    final name = _getChatName(data);
    final image = _getChatImage(data);

    final displayTime = data.updatedAt ?? data.createdAt;
    final time = displayTime != null
        ? "${displayTime.hour.toString().padLeft(2, '0')}:${displayTime.minute.toString().padLeft(2, '0')}"
        : "";

    final lastMsg =
        data.lastMessage?.message ??
        (isGroup ? "Group Chat" : "No messages yet");

    return GestureDetector(
      onTap: () {
        debugPrint("Chat ID: ${data.id}");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MessageScreen(chatId: data.id.toString()),
          ),
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
                  backgroundImage:
                      (image.isNotEmpty && image.startsWith('http'))
                      ? NetworkImage(image)
                      : null,
                  child: (image.isEmpty || !image.startsWith('http'))
                      ? Icon(
                          isGroup ? Icons.groups : Icons.person,
                          color: const Color(0xff0077b6),
                          size: 30.sp,
                        )
                      : null,
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
                      Expanded(
                        child: Text(
                          name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff001d61),
                          ),
                        ),
                      ),
                      Text(
                        time,
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
                          lastMsg,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      if ((data.unseenCount ?? 0) > 0)
                        Container(
                          padding: EdgeInsets.all(6.r),
                          decoration: const BoxDecoration(
                            color: Color(0xff0077b6),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '${data.unseenCount}',
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
