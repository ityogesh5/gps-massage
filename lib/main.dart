import 'package:flutter/material.dart';
import 'file:///C:/Users/user1/Documents/gps-massage/lib/initialScreens/splashScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerFirstScreen.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ヒーリングマッチ',
      debugShowCheckedModeBanner: false,
      home: RegisterFirstScreen()
    );
  }
}
