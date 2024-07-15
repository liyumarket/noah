import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:noahrealstate/app/firebase_options.dart';
import 'package:noahrealstate/app/modules/splash/views/splash_view.dart';

import 'app/routes/app_pages.dart';

Future<void> main() async {
   WidgetsBinding widgetsBinding =WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
//  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ScreenUtilInit(
    designSize: const Size(360, 690),
    minTextAdapt: true,
    splitScreenMode: true,
    // Use builder only if you need to use library outside ScreenUtilInit context
    builder: (_, child) {
      return GetMaterialApp(
        navigatorObservers: [
          FirebaseAnalyticsObserver(analytics: FirebaseAnalytics.instance),
        ],
        debugShowCheckedModeBanner: false,
        title: "Noah",
        // initialRoute: AppPages.INITIAL,
        home:  SplashView(),
        getPages: AppPages.routes,
      );
    },
    child: const SizedBox(),
  ));
  // FlutterNativeSplash.remove();
}
