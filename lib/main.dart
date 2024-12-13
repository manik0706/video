import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sourcecad_app/utils/hive_utils.dart';
import 'package:sourcecad_app/view/splash.dart';
// import 'package:sourcecad_app/view_models/homescreen_vm.dart';
import 'package:sourcecad_app/view_models/login_vm.dart';
import 'package:sourcecad_app/view_models/sign_up_vm.dart';
import 'package:sourcecad_app/view_models/splash_vm.dart';

import 'constant/my_theme.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await setupFlutterNotifications();
  await HiveUtils.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SplashVM()),
        ChangeNotifierProvider(create: (context) => LoginVM()),
        ChangeNotifierProvider(create: (context) => SignUpVM()),
        // ChangeNotifierProvider(
        //     create: (context) => HomeScreenVM()), // Add this line
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  // static FirebaseAnalyticsObserver observer =
  // FirebaseAnalyticsObserver(analytics: analytics);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      key: navigatorKey,
      title: 'Source Cad',
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      home: const SplashWidget(),
    );
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
