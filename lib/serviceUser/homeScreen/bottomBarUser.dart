import 'package:gps_massageapp/customLibraryClasses/bottomNavigationBar/curved_Naviagtion_Bar.dart';
import 'package:flutter/material.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreenUser.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/viewProfileScreen.dart';

import 'bookingScreenUser.dart';
import 'chatScreenUser.dart';
import 'homeScreenUser.dart';

final pageController = PageController();

class BottomBarUser extends StatefulWidget {
  @override
  _BottomBarUserState createState() => _BottomBarUserState();
}

class _BottomBarUserState extends State<BottomBarUser> {
  static int selectedpage = 0; //initial value

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
      extendBody: true,
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            selectedpage = index;
            pageController.jumpToPage(index);
          });
        },
        children: [
          ServiceUserHomeScreen(),
          SearchScreenUser(),
          BookingScreenUser(),
          ViewUserProfile(),
          ChatScreenUser(),
        ],
      ), // initial value is 0 so HomePage will be shown
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        buttonBackgroundColor: Colors.limeAccent,
        backgroundColor: Colors.white,
        color: Colors.white,
        animationCurve: Curves.decelerate,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          Icon(
            Icons.home,
            size: 30,
            color: selectedpage == 0 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.search,
            size: 30,
            color: selectedpage == 1 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.library_books,
            size: 30,
            color: selectedpage == 2 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.account_box,
            size: 30,
            color: selectedpage == 3 ? Colors.white : Colors.black,
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: selectedpage == 4 ? Colors.white : Colors.black,
          ),
        ],
        onTap: (index) {
          setState(() {
            selectedpage =
                index; // changing selected page as per bar index selected by the user
            pageController.jumpToPage(index);
          });
        },
        index: selectedpage,
      ),
    );
  }
}
