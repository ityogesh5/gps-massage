import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/customLibraryClasses/bottomNavigationBar/curved_Naviagtion_Bar.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/ChatTabBar.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/notification.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/history/History.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/notificationOnResume.dart';

import 'HomeScreen.dart';
import 'myAccount/MyAccount.dart';
import 'operationManagement/OperationManagement.dart';

class BottomBarProvider extends StatefulWidget {
  final int page;
  final int opManagementPage;
  final int historyPage;

  BottomBarProvider(this.page, {this.opManagementPage, this.historyPage});

  @override
  _BottomBarProviderPageState createState() => _BottomBarProviderPageState();
}

class _BottomBarProviderPageState extends State<BottomBarProvider> {
  int selectedpage; //initial value

  var _pageOptions; // listing of all 3 pages index wise
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  static var fcmMessageid;
  /*final bgcolor = [
    Colors.orange,
    Colors.pink,
    Colors.greenAccent
  ];*/ // changing color as per active index value

  @override
  void initState() {
    _getNotificationStatus(context);

    FlutterStatusbarcolor.setStatusBarColor(Colors.grey[200]);
    selectedpage = widget.page; //initial Page
    _pageOptions = [
      ProviderHomeScreen(),
      OperationManagement(
          widget.opManagementPage == null ? 0 : widget.opManagementPage),
      History(widget.historyPage == null ? 0 : widget.historyPage),
      MyAccount(),
      ChatTabBar(),
    ];
    super.initState();
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
        animationCurve: Curves.decelerate,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          SvgPicture.asset(
            "assets/images_gps/provicer_home_black.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 0 ? Colors.white : Colors.black,
          ),
          SvgPicture.asset(
            "assets/images_gps/provider_shift_black.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 1 ? Colors.white : Colors.black,
          ),
          SvgPicture.asset(
            "assets/images_gps/provider_history_black.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 2 ? Colors.white : Colors.black,
          ),
          SvgPicture.asset(
            "assets/images_gps/provider_profile_black.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 3 ? Colors.white : Colors.black,
          ),
          SvgPicture.asset(
            "assets/images_gps/provider_notification_chat_black.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 4 ? Colors.white : Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedpage =
                index; // changing selected page as per bar index selected by the user
            _pageOptions[1] = OperationManagement(0);
            _pageOptions[2] = History(0);
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
      // onBackgroundMessage: myBackgroundMessageHandler,
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");

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

  /*  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
    }

    // Or do other work.
  } */

  void navigateToProviderNotifications(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => NotificationHistoryProvider()));
  }
}
