import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/bottomNavigationBar/curved_Naviagtion_Bar.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/reservationAndFavourites.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/SearchScreenUser.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/ViewProfileScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/NoticeScreenUser.dart';
import 'HomeScreenUser.dart';
import 'chatScreensUser/ChatScreenUser.dart';

class BottomBarUser extends StatefulWidget {
  final int page;

  BottomBarUser(this.page);

  @override
  _BottomBarUserState createState() => _BottomBarUserState();
}

class _BottomBarUserState extends State<BottomBarUser> {
  int selectedpage; //

  final _pageOptions = [
    HomeScreen(),
    SearchScreenUser(),
    ReservationAndFavourite(),
    ViewUserProfile(),
    NoticeScreenUser(),
  ];

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
            "assets/images_gps/search.svg",
            height: 25.0,
            width: 25.0,
            color: selectedpage == 1 ? Colors.white : Colors.black,
          ),
          SvgPicture.asset(
            "assets/images_gps/status.svg",
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
