import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerFirstScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerSecondScreen.dart';

main() {
  runApp(SplashScreen());
}

class SplashScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  var _visible = true;
  String result = '';
  var colorsValue = Colors.white;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 7);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    _navigateUser();
  }

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 7));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.easeInCirc);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    startTime();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: animation,
              child: Container(
                child: new SvgPicture.asset(
                  'assets/images_gps/gpsLogo.svg',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Container(
              child: ColorizeAnimatedTextKit(
                onTap: () {
                  //print("Tap Event");
                },
                text: [
                  "ヒーリングマッチ",
                ],
                textStyle: TextStyle(
                    fontSize: 30.0,
                    fontStyle: FontStyle.italic,
                    fontFamily: "Canterbury"),
                colors: [
                  Colors.purple,
                  Colors.blue,
                  Colors.yellow,
                  Colors.red,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateUser() async {
    //NavigationRouter.switchToRegistration(context);
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RegisterFirstScreen()),
        (Route<dynamic> route) => false);
  }
}
