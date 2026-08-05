import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ibraheemaltamim_flutter/loading.dart';
import 'package:provider/provider.dart';
import '/helpers/all_routes.dart';
import 'helpers/di.dart';
import 'helpers/language.dart';
import 'helpers/navigation_service.dart';
import 'helpers/register_provider.dart';
import 'networks/dio/dio.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await GetStorage.init();
  diSetup();
  // initiInternetChecker();
  DioSingleton.instance.create();

  // Set status bar color
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Change to your desired color
      statusBarIconBrightness: Brightness.dark, // For white icons
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // rotation();
    // setInitValue();
    return MultiProvider(
      providers: providers,
      child: AnimateIfVisibleWrapper(
        showItemInterval: const Duration(milliseconds: 150),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return const UtillScreenMobile();
          },
        ),
      ),
    );
  }
}

class UtillScreenMobile extends StatelessWidget {
  const UtillScreenMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 827),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          showPerformanceOverlay: false,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: false,
          ),
          debugShowCheckedModeBanner: false,
          translations: LocalString(),
          builder: (context, widget) {
            return MediaQuery(data: MediaQuery.of(context), child: widget!);
          },
          navigatorKey: NavigationService.navigatorKey,
          onGenerateRoute: RouteGenerator.generateRoute,
          home: Loading(),
        );
      },
    );
  }
}
