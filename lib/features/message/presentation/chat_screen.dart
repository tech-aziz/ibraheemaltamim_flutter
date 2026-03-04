import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/circular_icon_btn.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'Jhon Smith',
      'isMe': false,
      'text':
          'Hi Jenny! I wanted to discuss the telemedicine project details with you.',
      'time': '9:30 AM',
      'avatar': 'assets/images/img1.png',
    },
    {
      'sender': 'Me',
      'isMe': true,
      'text':
          'Sure! I\'d be happy to discuss.\nWhat specific aspects are you interested in?',
      'time': '9:32 AM',
      'avatar': 'assets/images/img1.png',
    },
    {
      'sender': 'Jhon Smith',
      'isMe': false,
      'text':
          'I need more information about the pediatric epilepsy cases and the research methodology.',
      'time': '9:35 AM',
      'avatar': 'assets/images/img1.png',
    },
    {
      'sender': 'Dr. Sarah Lee',
      'isMe': false,
      'text': 'Jenny, have you reviewed the orthopedic study results yet?',
      'time': '9:40 AM',
      'avatar': 'assets/images/img1.png',
    },
    {
      'sender': 'Me',
      'isMe': true,
      'text':
          'Yes, I\'m preparing the analysis report. Will share it by end of day.',
      'time': '9:45 AM',
      'avatar': 'assets/images/img1.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(
                  left: 20.w,
                  right: 20.w,
                  top: 10.h,
                  bottom: 20.h,
                ),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return _buildMessageBubble(_messages[index]);
                },
              ),
            ),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: CircularIconBtn(
              icon: Icons.arrow_back,
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'COVID-19 Vaccine Study',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff000066),
                  ),
                ),
                SizedBox(height: 4.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.people_outline,
                      color: const Color(0xFF8896A6),
                      size: 18.sp,
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      '8 members',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: const Color(0xFF8896A6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Icon(
          //   Icons.videocam_outlined,
          //   color: const Color(0xff000066),
          //   size: 30.sp,
          // ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    bool isMe = message['isMe'];

    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: isMe
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: isMe
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isMe) ...[
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage('assets/images/img1.png'),
                ),
                SizedBox(width: 12.w),
              ],
              Flexible(
                child: Column(
                  crossAxisAlignment: isMe
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      message['sender'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff000066),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: isMe ? const Color(0xff000066) : Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                          bottomLeft: isMe
                              ? Radius.circular(20.r)
                              : const Radius.circular(0),
                          bottomRight: isMe
                              ? const Radius.circular(0)
                              : Radius.circular(20.r),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Text(
                        message['text'],
                        style: TextStyle(
                          fontSize: 15.sp,
                          color: isMe ? Colors.white : const Color(0xff000066),
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      message['time'],
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF8896A6),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              if (isMe) ...[
                SizedBox(width: 12.w),
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: Colors.transparent,
                  backgroundImage: const AssetImage('assets/images/img1.png'),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 10.h,
      ).copyWith(bottom: 30.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              Icons.attach_file,
              color: const Color(0xFF8896A6),
              size: 26.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: TextStyle(
                    color: const Color(0xFF8896A6),
                    fontSize: 16.sp,
                  ),
                  border: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            Container(
              width: 48.w,
              height: 48.w,
              decoration: const BoxDecoration(
                color: Color(0xff000066),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.navigation_outlined,
                color: Colors.white,
                size: 24.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
