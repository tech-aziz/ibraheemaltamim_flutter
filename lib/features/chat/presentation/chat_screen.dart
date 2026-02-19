import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Center(child: Text('Chat')),
    );
  }
}
