import 'package:flutter/material.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/notification.dart';

class NotificationHistoryProvider extends StatefulWidget {
  @override
  _NotificationHistoryProviderState createState() =>
      _NotificationHistoryProviderState();
}

class _NotificationHistoryProviderState
    extends State<NotificationHistoryProvider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        elevation: 2.0,
        automaticallyImplyLeading: false,
        leading: IconButton(
            padding:
                EdgeInsets.only(left: 4.0, top: 8.0, bottom: 8.0, right: 0.0),
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context)
            /*  NavigationRouter.switchToServiceProviderBottomBar(context), */
            ),
        title: Text(
          'メッセージ',
          style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontFamily: 'NotoSansJP',
              fontWeight: FontWeight.bold),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),

        // backgroundColor: Color.fromRGBO(243, 249, 250, 1),
        centerTitle: true,
      ),
      body: NotificationScreen(),
    );
  }
}
