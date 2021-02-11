import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/alertDialogHelper/dialogHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/bottomNavigationBar/curved_Naviagtion_Bar.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/SearchScreenUser.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/ViewProfileScreen.dart';

import 'bookingScreensUser/BookingScreenUser.dart';
import 'chatScreensUser/ChatScreenUser.dart';
import 'HomeScreenUser.dart';

final pageController = PageController();

class BottomBarUser extends StatefulWidget {
  @override
  _BottomBarUserState createState() => _BottomBarUserState();
}

class _BottomBarUserState extends State<BottomBarUser> {
  static int selectedPage = 0; //initial value
  static int returnPage = 0;
  ScrollController _hideBottomNavController;

  final _pageOptions = [
    ServiceUserHomeScreen(),
    SearchScreenUser(),
    BookingScreenUser(),
    ViewUserProfile(),
    ChatScreenUser(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
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
      bottomNavigationBar: HealingMatchConstants.isUserRegistrationSkipped &&
              HealingMatchConstants.isUserVerified == false
          ? Visibility(
              visible: HealingMatchConstants.isBottomBarVisible,
              child: CurvedNavigationBar(
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
                    switch (index) {
                      case 0:
                        pageController.jumpToPage(index);
                        break;
                      case 1:
                        //Navigator.pushNamed(context, "/second");
                        NavigationRouter.switchToServiceUserSearchScreen(
                            context);
                        break;
                      case 2:
                        //DialogHelper.showUserLoginOrRegisterDialog(context);
                        NavigationRouter.switchToServiceUserBookingConfirmationScreen(context);
                        break;
                      case 3:
                        DialogHelper.showUserLoginOrRegisterDialog(context);
                        break;
                      case 4:
                        DialogHelper.showUserLoginOrRegisterDialog(context);
                        //NavigationRouter.switchToServiceUserNoticeScreen(context);
                        break;
                    }
                  });
                },
                //index: selectedPage,
              ),
            )
          : Visibility(
              visible: HealingMatchConstants.isBottomBarVisible,
              child: CurvedNavigationBar(
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
                    selectedPage = index;
                    setState(() {
                      switch (index) {
                        case 0:
                          pageController.jumpToPage(index);
                          break;
                        case 1:
                          NavigationRouter.switchToServiceUserSearchScreen(
                              context);
                          break;
                        case 2:
                          NavigationRouter.switchToServiceUserBookingScreen(
                              context);

                          break;
                        case 3:
                          NavigationRouter.switchToServiceUserViewProfileScreen(
                              context);
                          break;
                        case 4:
                          NavigationRouter.switchToServiceUserNoticeScreen(
                              context);
                          break;
                      }
                    }); // changing selected page as per bar index selected by the user
                    //pageController.jumpToPage(index);
                  });
                },
                index: selectedPage,
              ),
            ),
    );
  }
}
