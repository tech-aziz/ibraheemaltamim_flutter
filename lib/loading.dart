import 'package:flutter/material.dart';
import 'package:ibraheemaltamim_flutter/features/auth/login/presentation/login_screen.dart';
import 'package:ibraheemaltamim_flutter/features/home/presentation/home_screen.dart';
import 'package:ibraheemaltamim_flutter/features/navbar.dart';
import 'package:ibraheemaltamim_flutter/helpers/helper_methods.dart';
import 'package:ibraheemaltamim_flutter/onboarding_screen.dart';
import 'package:ibraheemaltamim_flutter/constants/app_constants.dart';
import 'package:ibraheemaltamim_flutter/helpers/di.dart';

final class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool _isLoading = true;

  @override
  void initState() {
    loadInitialData();
    super.initState();
  }

  loadInitialData() async {
    _isLoading = true;
    await setInitValue();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SplashScreen();
    } else {
      bool isLoggedIn = appData.read(kKeyIsLoggedIn) ?? false;
      if (isLoggedIn) {
        return const Navbar();
      } else {
        return const LoginScreen();
      }
    }
  }
}
