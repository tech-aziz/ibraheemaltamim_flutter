import 'dart:io';
import 'package:flutter/cupertino.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;
  static const String onboardingScreen = '/onboarding_screen';
  static const String loginScreen = '/loginScreen';
  static const String signupScreen = '/signupScreen';
  static const String enterpriceLoginScreen = '/enterpriceLoginScreen';
  static const String selectAreaScreen = '/selectAreaScreen';
  static const String profileSetupScreen = '/profileSetupScreen';
  static const String signupOtpVerificationScreen =
      '/signupOtpVerificationScreen';
  static const String loginVerificationScreen = '/loginVerificationScreen';
  static const String homeScreen = '/homeScreen';
  static const String farmersScreen = '/farmersScreen';
  static const String pondsScreen = '/pondsScreen';
  static const String bottomNavBar = '/bottomNavBar';
  static const String mainObservationScreen = '/mainObservationScreen';
  static const String knowledgeBaseScreen = '/knowledgeBaseScreen';
  static const String supportScreen = '/supportScreen';
  static const String productInputsScreen = '/productInputsScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();

  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.productInputsScreen:

        // return Platform.isAndroid
        //     ? _FadedTransitionRoute(
        //         widget: const ProductInputsScreen(), settings: settings)
        //     : CupertinoPageRoute(
        //         builder: (context) => const ProductInputsScreen());

      // case Routes.onboardingScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: OnboardingScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => OnboardingScreen());

      // case Routes.loginScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(widget: LoginScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => LoginScreen());

      // case Routes.signupScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(widget: SignupScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => SignupScreen());

      // case Routes.signupOtpVerificationScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: SignupOtpVerificationScreen(), settings: settings)
      //       : CupertinoPageRoute(
      //           builder: (context) => SignupOtpVerificationScreen());

      // case Routes.loginVerificationScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: LoginVerificationScreen(), settings: settings)
      //       : CupertinoPageRoute(
      //           builder: (context) => LoginVerificationScreen());

      // case Routes.enterpriceLoginScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: EnterpriceLoginScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => EnterpriceLoginScreen());

      // case Routes.selectAreaScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: SelectAreaScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => SelectAreaScreen());

      // case Routes.profileSetupScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: ProfileSetupScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => ProfileSetupScreen());

      // case Routes.homeScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(widget: HomeScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => HomeScreen());
      // case Routes.farmersScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(widget: FarmersScreen(), settings: settings)
      //       : CupertinoPageRoute(
      //           builder: (contexFarmersScreent) => FarmersScreen());

      // case Routes.pondsScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(widget: PondsScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => PondsScreen());

      // case Routes.mainObservationScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: MainObservationScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => MainObservationScreen());

      // case Routes.knowledgeBaseScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const KnowledgeBaseScreen(), settings: settings)
      //       : CupertinoPageRoute(
      //           builder: (context) => const KnowledgeBaseScreen());
      // case Routes.supportScreen:
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: const SupportScreen(), settings: settings)
      //       : CupertinoPageRoute(builder: (context) => const SupportScreen());

      // case Routes.bottomNavBar:
      //   final args = settings.arguments as Map;
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: BottomNavBar(pageNum: args["pageNum"]),
      //           settings: settings)
      //       : CupertinoPageRoute(
      //           builder: (context) => BottomNavBar(pageNum: args["pageNum"]));

      default:
        return null;
    }
  }
}

class _FadedTransitionRoute extends PageRouteBuilder {
  final Widget widget;
  @override
  final RouteSettings settings;

  _FadedTransitionRoute({required this.widget, required this.settings})
      : super(
          settings: settings,
          reverseTransitionDuration: const Duration(milliseconds: 1),
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return widget;
          },
          transitionDuration: const Duration(milliseconds: 1),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.ease,
              ),
              child: child,
            );
          },
        );
}

class ScreenTitle extends StatelessWidget {
  final Widget widget;

  const ScreenTitle({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: Tween<double>(begin: .5, end: 1),
      duration: const Duration(milliseconds: 500),
      curve: Curves.bounceIn,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: child,
        );
      },
      child: widget,
    );
  }
}
