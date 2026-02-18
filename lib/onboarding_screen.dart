import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/assets_helper/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 2), () {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => const LoginScreen()),
      // );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.cCAF0F8,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColor.cCAF0F8,
          body: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                ),
                SizedBox(width: 12),
                Text(
                  'PublicationHub',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    color: AppColor.c03045E,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
