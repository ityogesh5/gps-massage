import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';

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
  Future<SharedPreferences> _sharedPreferences =
      SharedPreferences.getInstance();
  bool userLoggedIn = false;
  bool providerLoggedIn = false;
  bool userLoggedOut = false;
  bool providerLoggedOut = false;
  bool userRegistered = false;
  bool providerRegistered = false;

  startTime() async {
    var _duration = new Duration(seconds: 7);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    //DialogHelper.showNoTherapistsDialog(context);
    checkStatus();
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

  checkStatus() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        ChangeValues("Internet available", Colors.green[900]);
        print('Internet available');
        HealingMatchConstants.isInternetAvailable = true;
      } else {
        ChangeValues("No Internet", Colors.red[900]);
        print('No Internet');
      }
    });
  }

  ChangeValues(String resultValue, Color colorValue) {
    setState(() {
      result = resultValue;
      colorsValue = colorValue;
      //print('Internet result ==> $result');
      if (result != null) {
        print('Internet result ==> $result');
      } else {
        //print('Unknown Error..');
      }
    });
  }

  _navigateUser() async {
    print('Entering loops !!');
    _sharedPreferences.then((value) {
      userLoggedIn = value.getBool('isUserLoggedIn');
      providerLoggedIn = value.getBool('isProviderLoggedIn');
      userRegistered = value.getBool('isUserRegister');
      providerRegistered = value.getBool('isProviderRegister');
      userLoggedOut = value.getBool('isUserLoggedOut');
      if (userLoggedIn != null && userLoggedIn) {
        print('Entering 1 loop !!');
        NavigationRouter.switchToServiceUserBottomBar(context);
      } else if (providerLoggedIn != null && providerLoggedIn) {
        print('Entering 2 loop !!');
        NavigationRouter.switchToServiceProviderBottomBar(context);
      } else {
        if (userLoggedOut != null && userLoggedOut) {
          NavigationRouter.switchToUserLogin(context);
        } else if (providerLoggedOut != null && providerLoggedOut) {
          NavigationRouter.switchToProviderLogin(context);
        } else if (userRegistered != null && userRegistered) {
          print('Entering 3 loop !!');
          NavigationRouter.switchToServiceUserBottomBar(context);
        } else if (providerRegistered != null && providerRegistered) {
          print('Entering 4 loop !!');
          NavigationRouter.switchToServiceProviderBottomBar(context);
        } else if (userLoggedIn == null ||
            !userLoggedIn && providerLoggedIn == null ||
            !providerLoggedIn && userRegistered == null ||
            !userRegistered && providerRegistered == null ||
            !providerRegistered && userLoggedOut != null ||
            !userLoggedOut) {
          print('Entering last loop !!');
          NavigationRouter.switchToTermsAndConditions(context);
        }
      }
    });
  }
}
