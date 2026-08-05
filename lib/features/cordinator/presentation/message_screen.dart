import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();

  final List<Map<String, dynamic>> _messages = [
    {
      'sender': 'Jhon Smith',
      'avatar':
          'https://images.unsplash.com/photo-1537368910025-700350fe46c7?q=80&w=150&auto=format&fit=crop',
      'message':
          'Hi Jenny! I wanted to discuss the telemedicine project details with you.',
      'time': '9:30 AM',
      'isMe': false,
    },
    {
      'sender': 'Me',
      'avatar':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop',
      'message':
          'Sure! I\'d be happy to discuss. What specific aspects are you interested in?',
      'time': '9:32 AM',
      'isMe': true,
    },
    {
      'sender': 'Jhon Smith',
      'avatar':
          'https://images.unsplash.com/photo-1537368910025-700350fe46c7?q=80&w=150&auto=format&fit=crop',
      'message':
          'I need more information about the pediatric epilepsy cases and the research methodology.',
      'time': '9:35 AM',
      'isMe': false,
    },
    {
      'sender': 'Dr. Sarah Lee',
      'avatar':
          'https://images.unsplash.com/photo-1594744803329-e58b31de215f?q=80&w=150&auto=format&fit=crop',
      'message': 'Jenny, have you reviewed the orthopedic study results yet?',
      'time': '9:40 AM',
      'isMe': false,
    },
    {
      'sender': 'Me',
      'avatar':
          'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop',
      'message':
          'Yes, I\'m preparing the analysis report. Will share it by end of day.',
      'time': '9:42 AM',
      'isMe': true,
    },
  ];

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(
        0xffD6F2FB,
      ), // Matching light blue background
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header Row
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      width: 40.w,
                      height: 40.w,
                      decoration: const BoxDecoration(
                        color: Color(
                          0xffBCE8F7,
                        ), // slightly darker blue background
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: const Color(0xff03045E),
                        size: 20.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COVID-19 Vaccine Study',
                          style: TextStyle(
                            color: const Color(0xff03045E),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Row(
                          children: [
                            Icon(
                              Icons.group_outlined,
                              color: Colors.grey.shade600,
                              size: 14.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '8 members',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13.sp,
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
            // Messages List Area
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return _buildMessageRow(msg);
                },
              ),
            ),
            // Bottom Message Composer
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x0a000000),
                      blurRadius: 10,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Attachment Icon
                    IconButton(
                      icon: Icon(
                        Icons.attach_file,
                        color: Colors.grey.shade500,
                        size: 22.sp,
                      ),
                      onPressed: () {},
                    ),
                    // Input TextField
                    Expanded(
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 15.sp,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.symmetric(horizontal: 8.w),
                        ),
                        style: TextStyle(
                          color: const Color(0xff03045E),
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    // Send Button
                    GestureDetector(
                      onTap: () {
                        if (_messageController.text.trim().isNotEmpty) {
                          setState(() {
                            _messages.add({
                              'sender': 'Me',
                              'avatar':
                                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=150&auto=format&fit=crop',
                              'message': _messageController.text.trim(),
                              'time': 'Just now',
                              'isMe': true,
                            });
                          });
                          _messageController.clear();
                        }
                      },
                      child: Container(
                        width: 40.w,
                        height: 40.w,
                        decoration: const BoxDecoration(
                          color: Color(0xff03045E),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Icon(
                            Icons.send,
                            color: Colors.white,
                            size: 18.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageRow(Map<String, dynamic> msg) {
    final bool isMe = msg['isMe'];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe) ...[_buildAvatar(msg['avatar']), SizedBox(width: 10.w)],
          Expanded(
            child: Column(
              crossAxisAlignment: isMe
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                // Sender Name
                Text(
                  isMe ? 'Me' : msg['sender'],
                  style: TextStyle(
                    color: const Color(0xff03045E),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 6.h),
                // Message Bubble
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? const Color(0xff03045E) : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: isMe ? Radius.circular(20.r) : Radius.zero,
                      bottomRight: isMe ? Radius.zero : Radius.circular(20.r),
                    ),
                  ),
                  child: Text(
                    msg['message'],
                    style: TextStyle(
                      color: isMe ? Colors.white : const Color(0xff03045E),
                      fontSize: 14.sp,
                      height: 1.4.h,
                    ),
                  ),
                ),
                SizedBox(height: 4.h),
                // Time
                Text(
                  msg['time'],
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),
          if (isMe) ...[SizedBox(width: 10.w), _buildAvatar(msg['avatar'])],
        ],
      ),
    );
  }

  Widget _buildAvatar(String url) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: const Color(0xffBCE8F7),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.network(
          url,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              'assets/images/placeholder.jpg',
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
