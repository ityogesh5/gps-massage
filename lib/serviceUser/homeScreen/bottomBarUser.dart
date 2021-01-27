import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/bottomNavigationBar/curved_Naviagtion_Bar.dart';
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
  static int selectedPage = 0; //initial value
  static int returnPage = 0;

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
            returnPage = index;
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
      bottomNavigationBar: HealingMatchConstants.isUserRegistrationSkipped
          ? CurvedNavigationBar(
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
                  if (index == 0) {
                    pageController.jumpToPage(index);
                  }
                  if (index == 1) {
                    pageController.jumpToPage(index);
                  }
                  if (index == 2) {
                    DialogHelper.showUserLoginOrRegisterDialog(context);
                  }
                  if (index == 3) {
                    DialogHelper.showUserLoginOrRegisterDialog(context);
                  }
                  if (index == 4) {
                    DialogHelper.showUserLoginOrRegisterDialog(context);
                  }
                });
              },
              //index: selectedPage,
            )
          : CurvedNavigationBar(
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
                  color: selectedPage == 0 ? Colors.white : Colors.black,
                ),
                Icon(
                  Icons.search,
                  size: 30,
                  color: selectedPage == 1 ? Colors.white : Colors.black,
                ),
                Icon(
                  Icons.library_books,
                  size: 30,
                  color: selectedPage == 2 ? Colors.white : Colors.black,
                ),
                Icon(
                  Icons.account_box,
                  size: 30,
                  color: selectedPage == 3 ? Colors.white : Colors.black,
                ),
                Icon(
                  Icons.chat,
                  size: 30,
                  color: selectedPage == 4 ? Colors.white : Colors.black,
                ),
              ],
              onTap: (index) {
                setState(() {
                  selectedPage =
                      index; // changing selected page as per bar index selected by the user
                  pageController.jumpToPage(index);
                });
              },
              index: selectedPage,
            ),
    );
  }
}
