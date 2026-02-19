import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Center(child: Text('Profile')),
    );
  }
}
