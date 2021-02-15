import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/waitingDetailPage/ApprovalWaitingScreen.dart';

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
        home: ApprovalWaitingScreen()); //BookingCancelScreen());
  }
}
