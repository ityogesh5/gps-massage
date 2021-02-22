import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gps_massageapp/customLibraryClasses/bottomNavigationBar/curved_Naviagtion_Bar.dart';

import 'BookingStatus.dart';
import 'Chat.dart';
import 'HomeScreen.dart';
import 'myAccount/MyAccount.dart';
import 'operationManagement/OperationManagement.dart';

class BottomBarProvider extends StatefulWidget {
  final int page;
  BottomBarProvider(this.page);
  @override
  _BottomBarProviderPageState createState() => _BottomBarProviderPageState();
}

class _BottomBarProviderPageState extends State<BottomBarProvider> {
  int selectedpage; //initial value

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
  void initState() {
    selectedpage = widget.page; //initial Page
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pageOptions[selectedpage],
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
          });
        },
      ),
    );
  }
}
