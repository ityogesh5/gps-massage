import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';

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
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: animation,
              child: Container(
                color: Colors.white,
                child: new SvgPicture.asset('assets/images_gps/normalLogo.svg',
                    width: 250, height: 250),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateUser() async {
    //NavigationRouter.switchToServiceUserViewProfileScreen(context);
    NavigationRouter.switchToTermsAndConditions(context);
  }
}
