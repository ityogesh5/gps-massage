import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'bookingStatus.dart';
import 'chat.dart';
import 'homeScreen.dart';
import 'myAccount.dart';
import 'operationManagement.dart';

class BottomBarProvider extends StatefulWidget {
  @override
  _BottomBarProviderPageState createState() => _BottomBarProviderPageState();
}

class _BottomBarProviderPageState extends State<BottomBarProvider> {
  int selectedpage = 0; //initial value

  final _pageOptions = [
    ProviderHomeScreen(),
    OperationManagement(),
    BookingStatus(),
    MyAccount(),
    Chat(),
  ]; // listing of all 3 pages index wise

  /*final bgcolor = [
    Colors.orange,
    Colors.pink,
    Colors.greenAccent
  ];*/ // changing color as per active index value

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
            Icons.work,
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
