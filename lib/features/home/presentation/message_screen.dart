import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';
import 'package:ibraheemaltamim_flutter/common_widgets/custom_appbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/whatsapp_helper.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // ------------custom appbar start -----------
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  CustomAppbar(
                    title: 'Message',
                    onTap: () {
                      // NavigationService.goBack;


                    },
                  ),
                ],
              ),
            ),

            // ------------custom appbar end-----------

            // ------------ details information start--------
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),

                      SizedBox(height: 50.h), // Extra space for FAB
                    ],
                  ),
                ),
              ),
            ),
            // ------------ details information end--------
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => launchWhatsApp(context: context),
        backgroundColor: const Color(0xff000066),
        shape: const CircleBorder(),
        child: Center(
          child: Image.asset(
            'assets/images/whatapp_icon.png',
            width: 30.w,
            height: 30.w,
          ),
        ),
      ),
    );
  }
}
