import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreenUser.dart';

import 'bookingScreenUser.dart';
import 'chatScreenUser.dart';
import 'homeScreenUser.dart';
import 'myAccountScreenUser.dart';

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
    MyAccountScreenUser(),
    ChatScreenUser(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pageOptions[
          selectedpage], // initial value is 0 so HomePage will be shown
      bottomNavigationBar: CurvedNavigationBar(
        height: 40,
        buttonBackgroundColor: Colors.lightGreenAccent,
        backgroundColor: Colors.white,
        color: Colors.white,
        animationCurve: Curves.decelerate,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.library_books,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.account_box,
            size: 30,
            color: Colors.black,
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: Colors.black,
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
