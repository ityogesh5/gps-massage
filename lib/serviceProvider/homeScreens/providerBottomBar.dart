import 'package:gps_massageapp/customLibraryClasses/bottomNavigationBar/curved_Naviagtion_Bar.dart';
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
      extendBody: true,
      body: _pageOptions[selectedpage],
      // initial value is 0 so HomePage will be shown
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        buttonBackgroundColor: Colors.limeAccent,
        backgroundColor: Colors.red.withOpacity(0), // Colors.red,
        color: Colors.white,
        animationCurve: Curves.decelerate,
        animationDuration: Duration(milliseconds: 200),
        items: <Widget>[
          Icon(
            Icons.home_outlined,
            size: 30,
            color: selectedpage == 0 ? Colors.white : Colors.black54,
          ),
          Icon(
            Icons.computer,
            size: 30,
            color: selectedpage == 1 ? Colors.white : Colors.black54,
          ),
          Icon(
            Icons.library_books,
            size: 30,
            color: selectedpage == 2 ? Colors.white : Colors.black54,
          ),
          Icon(
            Icons.account_circle_outlined,
            size: 30,
            color: selectedpage == 3 ? Colors.white : Colors.black54,
          ),
          Icon(
            Icons.chat,
            size: 30,
            color: selectedpage == 4 ? Colors.white : Colors.black54,
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
