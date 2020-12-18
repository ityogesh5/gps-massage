import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';

import 'file:///D:/Gps/lib/serviceProvider/initialScreensServiceProvider/termsAndConditions.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/loginScreen.dart';

import 'package:gps_massageapp/serviceProvider/MyHomePage.dart';

void main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: IntroTermsAndPolicy(),
      title: 'ヒーリングマッチ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}

/*class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text('ヒーリングマッチ'),
      ),
    );
  }

}

}*/
