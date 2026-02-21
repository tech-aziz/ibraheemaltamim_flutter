import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:ibraheemaltamim_flutter/features/auth/login/presentation/login_screen.dart';
import 'package:ibraheemaltamim_flutter/features/auth/otp/presentation/register_otp_verification_screen.dart';
import 'package:ibraheemaltamim_flutter/features/auth/register/presentation/register_screen.dart';
import 'package:ibraheemaltamim_flutter/features/auth/set_new_password/presentation/set_new_password_screen.dart';
import 'package:ibraheemaltamim_flutter/features/home/presentation/all_opportunities_screen.dart';
import 'package:ibraheemaltamim_flutter/features/home/presentation/home_screen.dart';
import 'package:ibraheemaltamim_flutter/features/home/presentation/notification_screen.dart';
import 'package:ibraheemaltamim_flutter/features/home/presentation/opportunity_detail_screen.dart';
import 'package:ibraheemaltamim_flutter/features/home/presentation/wishlist_screen.dart';
import 'package:ibraheemaltamim_flutter/features/navbar.dart';
import 'package:ibraheemaltamim_flutter/features/profile/presentation/edit_profile_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;

  static const String registerScreen = '/onboardingScreen';
  static const String loginScreen = '/loginScreen';
  static const String registerOtpVerificationScreen =
      '/registerOtpVerificationScreen';
  static const String homeScreen = '/homeScreen';
  static const String setNewPasswordScreen = '/setNewPasswordScreen';
  static const String navbar = '/navbar';
  static const String allOpportunitiesScreen = '/allOpportunitiesScreen';
  static const String wishlistScreen = '/wishlistScreen';
  static const String opportunityDetail = '/opportunityDetail';
  static const String notificationScreen = '/notificationScreen';
  static const String editProfileScreen = '/editProfileScreen';
}

final class RouteGenerator {
  static final RouteGenerator _routeGenerator = RouteGenerator._internal();

  RouteGenerator._internal();
  static RouteGenerator get instance => _routeGenerator;

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // ---------- Register Screen ----------
      case Routes.registerScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: RegisterScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => RegisterScreen());

      // ---------- Login Screen ----------
      case Routes.loginScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: LoginScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => LoginScreen());

      // ---------- Register Otp Verification Screen ----------
      case Routes.registerOtpVerificationScreen:
        final args = settings.arguments as Map;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: RegisterOtpVerificationScreen(email: args['email']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) =>
                    RegisterOtpVerificationScreen(email: args['email']),
              );

      // ---------- Home Screen ----------
      case Routes.homeScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: HomeScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => HomeScreen());
      // ---------- Set New Password Screen ----------
      case Routes.setNewPasswordScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: SetNewPasswordScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => SetNewPasswordScreen());

      // ---------- Navbar ----------
      case Routes.navbar:
        final args = settings.arguments as Map<String, dynamic>?;
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: Navbar(pageNum: args?['pageNum']),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => Navbar(pageNum: args?['pageNum']),
              );

      // ---------- All Opportunities Screen ----------
      case Routes.allOpportunitiesScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: AllOpportunitiesScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => AllOpportunitiesScreen(),
              );

      // ---------- Wishlist Screen ----------
      case Routes.wishlistScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: WishlistScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => WishlistScreen());

      // ---------- Opportunity Details Screen ----------
      case Routes.opportunityDetail:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: OpportunityDetailScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => OpportunityDetailScreen(),
              );

      // ---------- Notification Screen ----------
      case Routes.notificationScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: NotificationScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => NotificationScreen());

      // ---------- Edit Profile Screen ----------
      case Routes.editProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: EditProfileScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => EditProfileScreen());

      // case Routes.bottomNavBar:
      //   final args = settings.arguments as Map;
      //   return Platform.isAndroid
      //       ? _FadedTransitionRoute(
      //           widget: BottomNavBar(pageNum: args["pageNum"]),
      //           settings: settings)
      //       : CupertinoPageRoute(
      //           builder: (context) => BottomNavBar(pageNum: args["pageNum"]));

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
        pageBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return widget;
            },
        transitionDuration: const Duration(milliseconds: 1),
        transitionsBuilder:
            (
              BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child,
            ) {
              return FadeTransition(
                opacity: CurvedAnimation(parent: animation, curve: Curves.ease),
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
        return Opacity(opacity: value, child: child);
      },
      child: widget,
    );
  }
}
