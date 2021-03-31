import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gps_massageapp/serviceUser/floatingSample.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/detailPageSearch.dart';

import 'initialScreens/splashScreen.dart';

void main() {
  runApp(HealingMatchApp());
}

class HealingMatchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // FlutterStatusbarcolor.setStatusBarColor(ColorConstants.statusBarColor);
    /*  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: ColorConstants.statusBarColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark)); */
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'NotoSansJP',
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('ja'),
        ],
        title: 'Healing Match',
        debugShowCheckedModeBanner: false,
        home: SplashScreen()); //FloatingSample());
    /*routes: Routes.routes(),
      initialRoute: Routes.initScreen(),*/ //StripePaymentUser

    //home: SplashScreen());
  }
}
