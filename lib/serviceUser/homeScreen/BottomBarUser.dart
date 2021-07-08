import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/bottomNavigationBar/curved_Naviagtion_Bar.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/ReservationScreens/reservationAndFavourites.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/NoticeScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/notificationScreenOnTap.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/SearchScreenUser.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/ViewProfileScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreenUser.dart';

Future<SharedPreferences> _sharedPreferences = SharedPreferences.getInstance();
var accessToken;

class BottomBarUser extends StatefulWidget {
  final int page;
  final int historyPage;

  BottomBarUser(this.page, {this.historyPage});

  @override
  _BottomBarUserState createState() => _BottomBarUserState();
}

class _BottomBarUserState extends State<BottomBarUser> {
  int selectedpage;
  int skippedPage;
  var _pageOptions;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static var fcmMessageid;

  @override
  void initState() {
    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
    _getNotificationStatus(context);
    selectedpage = widget.page; //initial Page
    skippedPage = widget.page;
    super.initState();
    _pageOptions = [
      HomeScreen(),
      SearchScreenUser(),
      ReservationAndFavourite(
          widget.historyPage == null ? 0 : widget.historyPage),
      ViewUserProfile(),
      NotifyScreenUser(),
    ];
    _sharedPreferences.then((value) {
      accessToken = value.getString('accessToken');
      if (accessToken != null) {
        print('Access token value : $accessToken');
        HealingMatchConstants.accessToken = accessToken;
      } else {
        print('No prefs value found !!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pageOptions[selectedpage],
      appBar: AppBar(
        brightness: Brightness.light,
        elevation: 0.0,
        toolbarHeight: 0.0,
      ),
      // initial value is 0 so HomePage will be shown
      bottomNavigationBar: CurvedNavigationBar(
        index: selectedpage,
        height: 60,
        buttonBackgroundColor: Colors.limeAccent,
        backgroundColor: Colors.red.withOpacity(0),
        // Colors.red,
        color: Colors.white,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        items: <Widget>[
          SvgPicture.asset(
            "assets/images_gps/provicer_home_black.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 0 && skippedPage == 0
                ? Colors.white
                : Colors.black,
          ),
          SvgPicture.asset(
            "assets/images_gps/search.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 1 && skippedPage == 1
                ? Colors.white
                : Colors.black,
          ),
          SvgPicture.asset(
            "assets/images_gps/status.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 2 || skippedPage == 2
                ? Colors.white
                : Colors.black,
          ),
          SvgPicture.asset(
            "assets/images_gps/provider_profile_black.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 3 || skippedPage == 3
                ? Colors.white
                : Colors.black,
          ),
          SvgPicture.asset(
            "assets/images_gps/provider_notification_chat_black.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 4 || skippedPage == 4
                ? Colors.white
                : Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            if (HealingMatchConstants.isUserRegistrationSkipped != null &&
                HealingMatchConstants.isUserRegistrationSkipped) {
              if (index == 0) {
                selectedpage = index;
                skippedPage = index;
              } else if (index == 1) {
                selectedpage = index;
                skippedPage = index;
              } else if (index == 2) {
                skippedPage = index;
                DialogHelper.showUserLoginOrRegisterDialog(context);
              } else if (index == 3) {
                skippedPage = index;
                DialogHelper.showUserLoginOrRegisterDialog(context);
              } else if (index == 4) {
                skippedPage = index;
                DialogHelper.showUserLoginOrRegisterDialog(context);
              }
            } else {
              selectedpage = index;
              skippedPage = index;

              // changing selected page as per bar index selected by the user
            }
          });
        },
      ),
    );
  }

  void _getNotificationStatus(BuildContext context) async {
    _firebaseMessaging.configure(
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        if (fcmMessageid != message["gcm.message_id"] && Platform.isIOS) {
          fcmMessageid = message["gcm.message_id"];
          navigateToProviderNotifications(context);
        } else if (fcmMessageid != message["data"]["notificaitonId"]) {
          fcmMessageid = message["data"]["notificaitonId"];
          navigateToProviderNotifications(context);
        }
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message \n ${message["gcm.message_id"]}");

        if (fcmMessageid != message["gcm.message_id"] && Platform.isIOS) {
          fcmMessageid = message["gcm.message_id"];
          navigateToProviderNotifications(context);
        } else if (fcmMessageid != message["data"]["notificaitonId"]) {
          fcmMessageid = message["data"]["notificaitonId"];
          navigateToProviderNotifications(context);
        }
      },
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
    );
  }

  void navigateToProviderNotifications(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NotificationHistoryUser()));
  }
}
