import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:gps_massageapp/constantUtils/colorConstants.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/ApprovalWaitingScreen.dart';

import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/detailPageSearchOne.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/ConditionsAppliedScreen.dart';

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
          fontFamily: 'Oxygen',
        ),
        title: 'Healing Match',
        debugShowCheckedModeBanner: false,
        home: SplashScreen()); //SplashScreen());
  }
}
