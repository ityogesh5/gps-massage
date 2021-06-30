import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/InternetConnectivityHelper.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';

class SplashScreen extends StatefulWidget {
  // ignore: non_constant_identifier_names
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  String result = '';
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
  bool userVerified = false;
  bool providerVerified = false;
  bool isGuestUser = false;

  startTime() async {
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    if (HealingMatchConstants.isInternetAvailable) {
      //HealingMatchConstants.initiatePayment(context);
      _navigateUser();
    } else {
      DialogHelper.showNoInternetConnectionDialog(context, SplashScreen());
    }

    //initConnectivity();
  }

  @override
  void initState() {
    CheckInternetConnection.checkConnectivity(context);
    super.initState();
    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(
        parent: animationController, curve: Curves.bounceInOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();
    startTime();
  }

  @override
  void dispose() {
    animationController.dispose();
    CheckInternetConnection.cancelSubscription();
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
                    width: animation.value * 250,
                    height: animation.value * 250,
                    fit: BoxFit.scaleDown),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _navigateUser() async {
    print('Entering loops !!');
    _sharedPreferences.then((value) {
      HealingMatchConstants.accessToken = value.getString("accessToken");
      HealingMatchConstants.serviceUserPhoneNumber =
          value.getString('userPhoneNumber');
      HealingMatchConstants.serviceProviderPhoneNumber =
          value.getString('providerPhoneNumer');
      userLoggedIn = value.getBool('isUserLoggedIn');
      providerLoggedIn = value.getBool('isProviderLoggedIn');
      userRegistered = value.getBool('isUserRegister');
      providerRegistered = value.getBool('isProviderRegister');
      userLoggedOut = value.getBool('isUserLoggedOut');
      providerLoggedOut = value.getBool('isProviderLoggedOut');
      isGuestUser = value.getBool('isGuest');
      userVerified = value.getBool('userVerifyStatus');
      providerVerified = value.getBool('providerVerifyStatus');
      print('User Register : $userRegistered');
      debugPrint('user verified : $userVerified');
      debugPrint('provider verified : $providerVerified');
      if (isGuestUser != null && isGuestUser) {
        NavigationRouter.switchToUserLogin(context);
        print('Is Guest User : $isGuestUser !!');
      } else if (userLoggedIn != null && userLoggedIn) {
        print('Entering 1 loop !!');
        NavigationRouter.switchToServiceUserBottomBar(context);
      } else if (providerLoggedIn != null && providerLoggedIn) {
        print('Entering 2 loop !!');
        NavigationRouter.switchToServiceProviderBottomBar(context);
      } else if (userVerified != null && !userVerified) {
        NavigationRouter.switchToUserOtpScreen(context);
      } else if (providerVerified != null && !providerVerified) {
        NavigationRouter.switchToProviderOtpScreen(context);
      } else {
        if (userRegistered != null && userRegistered) {
          print('Entering 3 loop !!');
          NavigationRouter.switchToServiceUserBottomBar(context);
        } else if (userLoggedOut != null && userLoggedOut) {
          NavigationRouter.switchToUserLogin(context);
        } else if (providerLoggedOut != null && providerLoggedOut) {
          NavigationRouter.switchToProviderLogin(context);
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
