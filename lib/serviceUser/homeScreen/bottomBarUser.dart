import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreenUser.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/viewProfileScreen.dart';

import 'bookingScreenUser.dart';
import 'chatScreenUser.dart';
import 'homeScreenUser.dart';

class BottomBarUser extends StatefulWidget {
  @override
  _BottomBarUserState createState() => _BottomBarUserState();
}

class _BottomBarUserState extends State<BottomBarUser> {
  int selectedpage = 0; //initial value

  final _pageOptions = [
    ServiceUserHomeScreen(),
    SearchScreenUser(),
    BookingScreenUser(),
    ViewUserProfile(),
    ChatScreenUser(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[
          selectedpage], // initial value is 0 so HomePage will be shown
      bottomNavigationBar: CurvedNavigationBar(
        height: 40,
        buttonBackgroundColor: Colors.limeAccent,
        backgroundColor: Colors.white,
        color: Colors.blueAccent,
        animationCurve: Curves.decelerate,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.library_books,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.account_box,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedpage =
                index; // changing selected page as per bar index selected by the user
          });
        },
      ),
    );
  }
}
