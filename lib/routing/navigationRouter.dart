import 'package:flutter/material.dart';
import 'package:gps_massageapp/initialScreens/termsAndConditions.dart';
import 'package:gps_massageapp/initialScreens/userDefineScreen.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/loginScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/chooseServiceScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerFirstScreen.dart';
import 'package:gps_massageapp/serviceUser/register/registerUserScreen.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/bottomBar.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/changePassword.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/forgetPassword.dart';

class NavigationRouter {
  static void switchToRegistration(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => RegisterServiceUserScreen()),
        (Route<dynamic> route) => false);
  }

  static void switchToTermsandConditions(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IntroTermsAndPolicy()));
  }

  static void switchToUserDefineScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => UserDefineScreen()));
  }

  static void switchToLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Login()),
        (Route<dynamic> route) => false);
  }

  static void switchToProviderHome(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => MyHomePage()),
        (Route<dynamic> route) => false);
  }

  static void switchToChooseServiceScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChooseServiceScreen()));
  }

 static void switchToRegisterFirstScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterFirstScreen()));
  }

  static void switchToProviderForgetPasswordScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ForgetPassword()));
  }

  static void switchToProviderChangePasswordScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChangePassword()));
  }
}
