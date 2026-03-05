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
import 'package:ibraheemaltamim_flutter/features/payment/presentation/payment_screen.dart';
import 'package:ibraheemaltamim_flutter/features/payment/presentation/payment_success_screen.dart';
import 'package:ibraheemaltamim_flutter/features/profile/presentation/edit_profile_screen.dart';
import 'package:ibraheemaltamim_flutter/features/profile/presentation/mentor_profile_screen.dart';
import 'package:ibraheemaltamim_flutter/features/profile/presentation/privacy_screen.dart';
import 'package:ibraheemaltamim_flutter/features/profile/presentation/profile_screen.dart';
import 'package:ibraheemaltamim_flutter/features/profile/presentation/terms_and_condition_screen.dart';

final class Routes {
  static final Routes _routes = Routes._internal();
  Routes._internal();
  static Routes get instance => _routes;
  // ---------- Register Screen ----------
  static const String registerScreen = '/onboardingScreen';
  // ---------- Login Screen ----------
  static const String loginScreen = '/loginScreen';
  // ---------- Register Otp Verification Screen ----------
  static const String registerOtpVerificationScreen =
      '/registerOtpVerificationScreen';
  // ---------- Login Verification Screen ----------
  static const String loginVerificationScreen = '/loginVerificationScreen';
  // ---------- Enterprice Login Screen ----------
  static const String enterpriceLoginScreen = '/enterpriceLoginScreen';
  // ---------- Select Area Screen ----------
  static const String selectAreaScreen = '/selectAreaScreen';
  // ---------- Profile Setup Screen ----------
  static const String profileSetupScreen = '/profileSetupScreen';
  // ---------- Home Screen ----------
  static const String homeScreen = '/homeScreen';
  // ---------- Set New Password Screen ----------
  static const String setNewPasswordScreen = '/setNewPasswordScreen';
  // ---------- Navbar ----------
  static const String navbar = '/navbar';
  // ---------- All Opportunities Screen ----------
  static const String allOpportunitiesScreen = '/allOpportunitiesScreen';
  // ---------- Wishlist Screen ----------
  static const String wishlistScreen = '/wishlistScreen';
  // ---------- Opportunity Detail Screen ----------
  static const String opportunityDetail = '/opportunityDetail';
  // ---------- Notification Screen ----------
  static const String notificationScreen = '/notificationScreen';
  // ---------- Edit Profile Screen ----------
  static const String editProfileScreen = '/editProfileScreen';
  // ---------- Mentor Profile Screen ----------
  static const String mentorProfileScreen = '/mentorProfileScreen';
  // ---------- Payment Screen ----------
  static const String paymentScreen = '/paymentScreen';
  // ---------- Payment Success Screen ----------
  static const String paymentSuccessScreen = '/paymentSuccessScreen';
  // ---------- Profile Screen ----------
  static const String profileScreen = '/profileScreen';
  // ---------- Notifications Screen ----------
  static const String notificationsScreen = '/notificationsScreen';
  // ---------- Terms and Condition Screen ----------
  static const String termsAndConditionScreen = '/termsAndConditionScreen';
  // ---------- Privacy Screen ----------
  static const String privacyScreen = '/privacyScreen';
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

      // ---------- Mentor Profile Screen ----------
      case Routes.mentorProfileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: MentorProfileScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => MentorProfileScreen());

      // ---------- Payment Screen ----------
      case Routes.paymentScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: PaymentScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => PaymentScreen());

      // ---------- Payment Success Screen ----------
      case Routes.paymentSuccessScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: PaymentSuccessScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => PaymentSuccessScreen());

      // ---------- Profile Screens ----------
      case Routes.profileScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: ProfileScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => ProfileScreen());

      // ---------- Notifications Screen ----------
      case Routes.notificationsScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: NotificationScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(builder: (context) => NotificationScreen());

      // ---------- Terms And Condition Screen ----------
      case Routes.termsAndConditionScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(
                widget: TermsAndConditionScreen(),
                settings: settings,
              )
            : CupertinoPageRoute(
                builder: (context) => TermsAndConditionScreen(),
              );

      // ---------- Privacy Screen ----------
      case Routes.privacyScreen:
        return Platform.isAndroid
            ? _FadedTransitionRoute(widget: PrivacyScreen(), settings: settings)
            : CupertinoPageRoute(builder: (context) => PrivacyScreen());
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
