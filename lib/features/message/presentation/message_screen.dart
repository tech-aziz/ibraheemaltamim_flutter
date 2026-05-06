import 'dart:async';

import 'package:dart_pusher_channels/dart_pusher_channels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/circular_icon_btn.dart';
import 'package:ibraheemaltamim_flutter/constants/app_constants.dart';
import 'package:ibraheemaltamim_flutter/features/message/model/chat_show_model.dart';
import 'package:ibraheemaltamim_flutter/helpers/di.dart';
import 'package:ibraheemaltamim_flutter/networks/api_acess.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:ibraheemaltamim_flutter/helpers/toast.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageScreen extends StatefulWidget {
  final String chatId;
  const MessageScreen({super.key, required this.chatId});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  TextEditingController messageController = TextEditingController();
  File? _selectedFilePath;
  bool _isSending = false;
  StreamSubscription? _chatSubscription;
  StreamSubscription<ChannelReadEvent>? subscription;
  PusherChannelsClient? client;
  PrivateChannel? _myPrivateChannel;

  @override
  void initState() {
    super.initState();
    chatShowRxObj.fetchChatShow(chatId: widget.chatId);
    init();
  }

  //

  Future<void> init() async {
    // 1. Define options
    final options = PusherChannelsOptions.fromHost(
      scheme: 'wss',
      host: 'dashboard.hooray-entertainment.online',
      key: 'gau9dawhoh68o0x4qcha',
      port: 443,
      //shouldSupplyMetadataQueries: true,
      metadata: PusherChannelsOptionsMetadata.byDefault(),
    );

    // 2. Create client
    client = PusherChannelsClient.websocket(
      options: options,
      connectionErrorHandler: (exception, trace, refresh) {
        print("Pusher connection error: $exception");
        refresh(); // auto reconnect
      },
    );

    print('Conversation id: ${widget.chatId}');
    // 3. Create a private channel
    _myPrivateChannel = client?.privateChannel(
      "private-opportunity_chat.${widget.chatId}",
      authorizationDelegate:
          EndpointAuthorizableChannelTokenAuthorizationDelegate.forPrivateChannel(
            authorizationEndpoint: Uri.parse(
              "https://ibraheemaltamim.thesyndicates.team/api/broadcasting/auth",
            ),
            headers: {
              "Authorization": "Bearer ${appData.read(kKeyAccessToken)}",
            },
          ),
    );
    //4. Bind to event
    subscription = _myPrivateChannel?.bind('opportunity.chat').listen((event) {
      print("Message received: ${event.data}");
      if (mounted) {
        _loadMessages();
      }
    });

    // 5. Connect client
    client?.connect();

    // 6. Auto-subscribe after connection established
    _chatSubscription = client?.onConnectionEstablished.listen((_) {
      print("Connection Established");
      _myPrivateChannel?.subscribeIfNotUnsubscribed();
      print("Successfully subscribed to private channel");
    });
  }

  @override
  void dispose() {
    subscription?.cancel();
    _chatSubscription?.cancel();
    client?.disconnect();
    messageController.dispose();
    super.dispose();
  }

  ////////////////////
  void _loadMessages() async {
    if (!mounted) return;
    await chatShowRxObj
        .fetchChatShow(chatId: widget.chatId)
        .then((_) {
          if (!mounted) return;
        })
        .catchError((error) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load messages: $error')),
            );
          }
        });
  }

  //

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png', 'gif'],
    );

    if (result != null) {
      final file = result.files.single;
      if (file.size > 10240 * 1024) {
        ToastUtil.showShortToast("File size exceeds 10MB limit");
        return;
      }
      setState(() {
        _selectedFilePath = File(file.path!);
      });
      debugPrint("Selected file: ${_selectedFilePath?.path}");
    }
  }

  Future<void> _sendMessage() async {
    final message = messageController.text.trim();
    if (message.isEmpty && _selectedFilePath == null) return;

    setState(() {
      _isSending = true;
    });

    try {
      final success = await sendMessageRxObj.sendMessage(
        chatId: widget.chatId,
        message: message,
        file: _selectedFilePath,
      );

      if (success != null) {
        messageController.clear();
        setState(() {
          _selectedFilePath = null;
        });
        // Refresh chat list after sending message
        chatShowRxObj.fetchChatShow(chatId: widget.chatId);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSending = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: StreamBuilder<ChatShowModel>(
          stream: chatShowRxObj.getFileData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData || snapshot.data?.data == null) {
              return const Center(child: Text('no message available'));
            }

            final chatData = snapshot.data!.data!;
            final messages = chatData.messages ?? [];
            final chatInfo = chatData.chat;

            return Column(
              children: [
                _buildAppBar(chatInfo),
                Expanded(
                  child: messages.isEmpty
                      ? const Center(child: Text('no message available'))
                      : ListView.builder(
                          reverse: true,
                          padding: EdgeInsets.only(
                            left: 20.w,
                            right: 20.w,
                            top: 10.h,
                            bottom: 20.h,
                          ),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            return _buildMessageBubble(messages[index]);
                          },
                        ),
                ),
                _buildMessageInput(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildAppBar(Chat? chat) {
    String title = 'Chat';
    String subTitle = '';

    if (chat != null) {
      if (chat.type == 'group') {
        title = chat.chatable?.title ?? 'Group Chat';
        subTitle = '${chat.users?.length ?? 0} members';
      } else {
        final currentUserId = userInfoRxObj.dataFetcher.valueOrNull?.data?.id;
        final otherParticipant = chat.users?.firstWhere(
          (u) => u.userId != currentUserId,
          orElse: () => chat.users!.first,
        );
        title = otherParticipant?.user?.name ?? 'Unknown';
        subTitle = otherParticipant?.role ?? '';
      }
    }

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
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xff000066),
                  ),
                ),
                if (subTitle.isNotEmpty) ...[
                  SizedBox(height: 4.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        chat?.type == 'group'
                            ? Icons.people_outline
                            : Icons.person_outline,
                        color: const Color(0xFF8896A6),
                        size: 18.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        subTitle,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: const Color(0xFF8896A6),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Message message) {
    final currentUserId = userInfoRxObj.dataFetcher.valueOrNull?.data?.id;
    bool isMe = message.userId == currentUserId;

    final displayTime = message.createdAt;
    final time = displayTime != null
        ? "${displayTime.hour.toString().padLeft(2, '0')}:${displayTime.minute.toString().padLeft(2, '0')}"
        : "";

    final senderName = message.user?.name ?? 'Unknown';
    final avatar = message.user?.avatar ?? '';

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
                  backgroundColor: const Color(0xffe8f6ff),
                  backgroundImage:
                      (avatar.isNotEmpty && avatar.startsWith('http'))
                      ? NetworkImage(avatar)
                      : null,
                  child: (avatar.isEmpty || !avatar.startsWith('http'))
                      ? Icon(
                          Icons.person,
                          color: const Color(0xff0077b6),
                          size: 20.sp,
                        )
                      : null,
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
                      senderName,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xff000066),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 6.w,
                        vertical: 6.h,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (message.file != null &&
                              message.file.toString().isNotEmpty) ...[
                            _buildFilePreview(message.file.toString(), isMe),
                            if (message.message != null &&
                                message.message!.isNotEmpty)
                              SizedBox(height: 8.h),
                          ],
                          if (message.message != null &&
                              message.message!.isNotEmpty)
                            Text(
                              message.message!,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: isMe
                                    ? Colors.white
                                    : const Color(0xff000066),
                                height: 1.4,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                        ],
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      time,
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
                  backgroundColor: const Color(0xffe8f6ff),
                  backgroundImage:
                      (avatar.isNotEmpty && avatar.startsWith('http'))
                      ? NetworkImage(avatar)
                      : null,
                  child: (avatar.isEmpty || !avatar.startsWith('http'))
                      ? Icon(
                          Icons.person,
                          color: const Color(0xff0077b6),
                          size: 20.sp,
                        )
                      : null,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFilePreview(String fileUrl, bool isMe) {
    final isImage = fileUrl.toLowerCase().contains(
      RegExp(r'\.(jpg|jpeg|png|gif|webp)$'),
    );

    if (isImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.r),
        child: CachedNetworkImage(
          imageUrl: fileUrl,
          width: 200.w,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) =>
              _buildFilePlaceholder(fileUrl, isMe),
        ),
      );
    } else {
      return _buildFilePlaceholder(fileUrl, isMe);
    }
  }

  Widget _buildFilePlaceholder(String fileUrl, bool isMe) {
    final fileName = fileUrl.split('/').last;
    return GestureDetector(
      onTap: () async {
        final uri = Uri.parse(fileUrl);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        decoration: BoxDecoration(
          color: isMe ? Colors.white.withOpacity(0.1) : Colors.grey[200],
          borderRadius: BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.insert_drive_file,
              color: isMe ? Colors.white : const Color(0xff000066),
              size: 24.sp,
            ),
            SizedBox(width: 8.w),
            Flexible(
              child: Text(
                fileName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: isMe ? Colors.white : const Color(0xff000066),
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
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
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: _pickFile,
                  child: Icon(
                    Icons.attach_file,
                    color: _selectedFilePath != null
                        ? Colors.blue
                        : const Color(0xFF8896A6),
                    size: 26.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: TextField(
                    controller: messageController,
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
                GestureDetector(
                  onTap: _isSending ? null : _sendMessage,
                  child: Container(
                    width: 48.w,
                    height: 48.w,
                    decoration: const BoxDecoration(
                      color: Color(0xff000066),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: _isSending
                          ? SizedBox(
                              width: 20.w,
                              height: 20.w,
                              child: const CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 2,
                              ),
                            )
                          : Icon(
                              Icons.navigation_outlined,
                              color: Colors.white,
                              size: 24.sp,
                            ),
                    ),
                  ),
                ),
              ],
            ),
            _selectedFilePath != null
                ? SizedBox(height: 8.h)
                : const SizedBox.shrink(),
            if (_selectedFilePath != null)
              Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "File: ${_selectedFilePath!.path.split('/').last}",
                        style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _selectedFilePath = null),
                      child: Icon(Icons.close, size: 16.sp, color: Colors.red),
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
