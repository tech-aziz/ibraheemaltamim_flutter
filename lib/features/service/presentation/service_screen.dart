import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';

class ServiceScreen extends StatefulWidget {
  const ServiceScreen({super.key});

  @override
  State<ServiceScreen> createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Center(child: Text('Service')),
    );
  }
}
