import 'package:flutter/material.dart';

import 'initialScreens/splashScreen.dart';
import 'utils/SampleShimmerLoader.dart';

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
        title: 'Healing Match',
        debugShowCheckedModeBanner: false,
        home: SplashScreen()); //SplashScreen());
  }
}
