import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/bookingCancelScreens/BookingCancelScreen.dart';

import 'initialScreens/splashScreen.dart';

void main() {
  runApp(HealingMatchApp());
}

class HealingMatchApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          fontFamily: 'Oxygen',
        ),
        title: 'Healing Match',
        debugShowCheckedModeBanner: false,
        home: SplashScreen()); //BookingCancelScreen());
  }
}
