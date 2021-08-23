import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/networkHelper/socketExceptionHandler.dart';
import 'package:gps_massageapp/customLibraryClasses/PaymentAnimations/PaymentFailedPage.dart';
import 'package:gps_massageapp/customLibraryClasses/PaymentAnimations/PaymentProcessingPage.dart';
import 'package:gps_massageapp/customLibraryClasses/PaymentAnimations/PaymentSuccessPage.dart';
import 'package:gps_massageapp/initialScreens/StripeRedirectPage.dart';
import 'package:gps_massageapp/initialScreens/notificationPopup.dart';
import 'package:gps_massageapp/initialScreens/providerTutorial.dart';
import 'package:gps_massageapp/initialScreens/termsAndConditions.dart';
import 'package:gps_massageapp/initialScreens/userDefineScreen.dart';
import 'package:gps_massageapp/initialScreens/userTutorial.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/firebaseNotificationTherapistListModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/therapistBookingHistoryResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/booking/BookingCompletedList.dart'
    as userBooking;
import 'package:gps_massageapp/models/responseModels/serviceUser/notification/firebaseNotificationUserListModel.dart'
    as userNotification;
import 'package:gps_massageapp/serviceProvider/homeScreens/ProviderBottomBar.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/calendar/providerCalendar.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/AcceptBookingNotification.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/AdminNotification.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferCancel.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferConfirmed.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderReceiveBooking.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/ProviderEditProfile.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/ProviderTutorial.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/TermsAndConditions.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/ChangePassword.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/ForgetPassword.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/LoginScreen.dart';
import 'package:gps_massageapp/serviceProvider/ratingsReview/givenRatingViewScreen.dart';
import 'package:gps_massageapp/serviceProvider/ratingsReview/providerRatingsReviewScreen.dart';
import 'package:gps_massageapp/serviceProvider/ratingsReview/selfReviewScreen.dart';
import 'package:gps_massageapp/serviceProvider/ratingsReview/userRatingReviewScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/ChooseServiceScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/RegisterFirstScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/RegisterSecondScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/RegisterSuccessOTPScreen.dart';
import 'package:gps_massageapp/serviceProvider/weeklySchedule/WeeklyScheduleScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/BottomBarUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/NearByProviderAndShop.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/Recommended.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingApprovedScreens/BookingApprovedFirstScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingApprovedScreens/BookingApprovedSecondScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingApprovedScreens/BookingApprovedThirdScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingCancelScreens/BookingCancelScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingCancelScreens/BookingCancelTherapistReason.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingCancelScreens/BookingCancelTherapistResponseScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingCancelScreens/BookingCancelTimerScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingConfirmationScreens/BookingConfirmation.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingConfirmationScreens/FinalBookingConfirmationScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/ApprovalWaitingScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/BookingDetailsApprovedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/BookingDetailsCompletedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/BookingDetailsConfirmedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/ConditionsAppliedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/bookingDetailHomePage.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/chooseDate.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/sampleBookingScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/ReservationScreens/CalendarEventPopup.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/bookingCancelScreens/CancelDetailsScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/calendar.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/NoticeScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/NotificationPopups/bookingCancelPopup.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/NotificationPopups/therapistAcceptNotification.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/SearchResult.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/SearchScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/addAddress.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/detailPageSearch.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/searchScreenWithoutRegister.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/UserChangePassword.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/UserForgetPassword.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/UserLoginScreen.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/EditUpdateUserprofile.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/ReportBlockUser/UserBlockReportScreen.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/TermsAndConditions.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/UserTutorial.dart';
import 'package:gps_massageapp/serviceUser/ratingsAndReviewScreen/DisplayUserReviewScreen.dart';
import 'package:gps_massageapp/serviceUser/ratingsAndReviewScreen/RatingsAndReviewUser.dart';
import 'package:gps_massageapp/serviceUser/ratingsAndReviewScreen/givenRatingViewScreen.dart';
import 'package:gps_massageapp/serviceUser/register/RegisterOTPScreen.dart';
import 'package:gps_massageapp/serviceUser/register/RegisterUserScreen.dart';

class NavigationRouter {
  // Network dis connect handler class
  static void switchToNetworkHandler(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SocketExceptionHandler()));
  }

  static void switchToNetworkHandlerReplace(BuildContext context) {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => SocketExceptionHandler()));
  }

  static void switchToServiceUserRegistration(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return RegisterServiceUserScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

//Provider WeeklySchedule
  static void switchToWeeklySchedule(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return WeeklySchedule();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider WeeklySchedule
  static void refreshWeeklySchedule(BuildContext context) {
    Navigator.of(context).pushReplacement(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return WeeklySchedule();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

// Terms and conditions screen
  static void switchToTermsAndConditions(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return IntroTermsAndPolicy();
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[2], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }

  //NotificationPopup
  static void switchToNotificationPopup(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return NotificationPopup();
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[2], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }

// User define screen
  static void switchToUserDefineScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return UserDefineScreen();
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[2], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }

  // Provider login screen

  static void switchToProviderLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
            pageBuilder: (context, animation, anotherAnimation) {
              return ProviderLogin();
            },
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: HealingMatchConstants.curveList[2], parent: animation);
              return Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                  axisAlignment: 0.0,
                ),
              );
            }),
        (Route<dynamic> route) => false);
  }

//User Login screen
  static void switchToUserLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
            pageBuilder: (context, animation, anotherAnimation) {
              return UserLogin();
            },
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: HealingMatchConstants.curveList[2], parent: animation);
              return Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                  axisAlignment: 0.0,
                ),
              );
            }),
        (Route<dynamic> route) => false);
  }

  // User bottom bar homescreen
  static void switchToServiceUserBottomBar(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
            pageBuilder: (context, animation, anotherAnimation) {
              return BottomBarUser(0);
            },
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: HealingMatchConstants.curveList[2], parent: animation);
              return Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                  axisAlignment: 0.0,
                ),
              );
            }),
        (Route<dynamic> route) => false);
  }

  // User bottom bar Search
  static void switchToServiceUserBottomBarSearch(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => BottomBarUser(1)),
        (Route<dynamic> route) => false);
  }

  // User bottom bar homescreen
  static void switchToServiceUserBottomBarFavourite(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => BottomBarUser(2)),
        (Route<dynamic> route) => false);
  }

  // User bottom bar view profile screen
  static void switchToServiceUserBottomBarViewProfile(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
            pageBuilder: (context, animation, anotherAnimation) {
              return BottomBarUser(3);
            },
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: HealingMatchConstants.curveList[2], parent: animation);
              return Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                  axisAlignment: 0.0,
                ),
              );
            }),
        (Route<dynamic> route) => false);
  }

  //User NearByProviderAndShop
  static void switchToNearByProviderAndShop(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return NearByProviderAndShop();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Choose Date
  static void switchToChooseDate(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return ChooseDate();
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[2], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }

  //User Recommended
  static void switchToRecommended(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return Recommended();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //User CalendarScreen
  static void switchToCalendarScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return CalendarScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //UserSearchScreen
  static void switchToServiceUserSearchScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return SearchScreenUser();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //UserSearchScreen without Registration
  static void switchToServiceUserSearchScreenWithOutRegister(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return SearchWithoutRegister();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //User Search Result
  static void switchToUserSearchResult(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return SearchResultScreen();
        },
        transitionDuration: Duration(milliseconds: 100),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[10], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  static void switchToUserChooseDate(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ChooseDate();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //User Search detail design page one
  static void switchToUserSearchDetailPageOne(
      BuildContext context, var userID) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          // !TODO: Development Change
          return SampleBookingScreen(userID);
          //DetailPageSearchOne(userID);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  static void switchToServiceProviderTCScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return ProviderTermsAndConditions();
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[2], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }

  static void switchToServiceUserTCScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return UserTermsAndConditions();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

// Provider bottom bar homescreen
  static void switchToServiceProviderBottomBar(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
            pageBuilder: (context, animation, anotherAnimation) {
              return BottomBarProvider(0);
            },
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: HealingMatchConstants.curveList[11],
                  parent: animation);
              return Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                  axisAlignment: 0.0,
                ),
              );
            }),
        (Route<dynamic> route) => false);
  }

  // Provider bottom bar myAccount
  static void switchToServiceProviderShiftBanner(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider(1)));
  }

  // Provider bottom bar myAccount
  static void switchToServiceProviderServicePricePage(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider(
                  1,
                  opManagementPage: 2,
                )));
  }

  // Provider bottom bar shiftTiming
  static void switchToServiceProviderServiceTiming(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider(
                  1,
                  opManagementPage: 3,
                )));
  }

  static void switchToProviderCompletedHistoryScreen(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider(
                  2,
                  historyPage: 2,
                )));
  }

  static void switchToProviderApprovedHistoryScreen(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider(
                  2,
                  historyPage: 1,
                )));
  }

  static void switchToProviderCancelledHistoryScreen(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider(
                  2,
                  historyPage: 3,
                )));
  }

  // Provider bottom bar myAccount
  static void switchToServiceProviderMyAccount(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider(3)));
  }

  //Provider Choose service screen
  static void switchToChooseServiceScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return ChooseServiceScreen();
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[2], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }

  // Provider Register 1st screen
  static void switchToServiceProviderFirstScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return RegisterProviderFirstScreen();
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[2], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }

  // Provider Register 2nd screen

  static void switchToServiceProviderSecondScreen(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return RegistrationProviderSecondScreen();
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[2], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }

  //Provider Receive Booking Screen

  static void switchToReceiveBookingScreen(
      BuildContext context, BookingDetailsList bookingDetailsList) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProviderReceiveBooking(bookingDetailsList)));
  }

  //Provider Accept Booking Screen

  static void switchToAcceptBookingScreen(
      BuildContext context, NotificationList bookingDetailsList) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                AcceptBookingNotification(bookingDetailsList)));
  }

  //Provider Offer Cancel Screen

  static void switchToOfferCancelScreen(
      BuildContext context, NotificationList requestBookingDetailsList) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProviderOfferCancel(requestBookingDetailsList)));
  }

  //Provider Offer Confirmed Screen

  static void switchToOfferConfirmedScreen(
      BuildContext context, NotificationList requestBookingDetailsList) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                ProviderOfferConfirmed(requestBookingDetailsList)));
  }

  //Provider Admin Notification Provider Screen

  static void switchToAdminNotificationScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminNotification()));
  }

  //Provider Phone number input Forget Password Screen

  static void switchToProviderForgetPasswordScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ForgetPassword();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  static void switchToUserForgetPasswordScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return UserForgetPassword();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // Provider Change password screen
  static void switchToProviderChangePasswordScreen(BuildContext context) {
    Navigator.of(context).push/* Replacement */(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ChangePassword();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // User Change password screen
  static void switchToUserChangePasswordScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return UserChangePassword();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider OTP Enter screen after register
  static void switchToProviderOtpScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RegistrationSuccessOtpScreen()));
  }

  //User OTP Enter screen after register
  static void switchToUserOtpScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return RegisterOtpScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider Edit Profile Screen
  static void switchToProviderEditProfileScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ProviderEditProfile();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider Initial Tutorial Screen
  static void switchToProviderInitialTutorialScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ProviderInitialTutorial();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider Initial Tutorial Screen
  static void switchToUserInitialTutorialScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return UserInitialTutorial();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider MyAccount Tutorial Screen
  static void switchToProviderTutorialScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProviderTutorial()));
  }

  //Provider MyAccount Tutorial Screen
  static void switchToUserTutorialScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return UserTutorial();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider User Rating Screen
  static void switchToProviderSideUserReviewScreen(
      BuildContext context, int userId) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return UserRatingReviewScreen(userId);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider Self Review Screen
  static void switchToProviderSelfReviewScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ProviderSelfReviewScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider Provider Review Screen
  static void switchToProviderReviewScreen(BuildContext context, int index) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ProviderRatingsAndReviewUser(index);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Provider Provider Review Screen
  static void switchToProviderReviewScreenSent(
      BuildContext context, int userId) {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return GivenRatingReviewScreen();
            // ProviderRatingsAndReviewUser(1)
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[2], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }

  //Provider Calendar Screen
  static void switchToProviderCalendarScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProviderCalendar()));
  }

  // User define screen
  static void switchToUserAddAddressScreen(BuildContext context, var arg) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return AddAddress(arg);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[3], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // Serch Add Address Screen
  static void switchToUserAddSearchAddressScreen(
      BuildContext context, var arg, List<String> addressDropDownValues) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return SearchAddAddress(arg, addressDropDownValues);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[3], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // User calender screen
  static void switchToUserCalendarScreenScreen(BuildContext context) {
    //  Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, anotherAnimation) {
              return CalendarScreen();
            },
            transitionDuration: Duration(milliseconds: 2000),
            transitionsBuilder: (context, animation, anotherAnimation, child) {
              animation = CurvedAnimation(
                  curve: HealingMatchConstants.curveList[2], parent: animation);
              return Align(
                child: SizeTransition(
                  sizeFactor: animation,
                  child: child,
                  axisAlignment: 0.0,
                ),
              );
            }));
  }

  static void switchToUserEventPopup(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => EventPopupScreen()));
  }

  // Service User Edit Profile Screen
  static void switchToServiceUserEditProfileScreen(
      BuildContext context, String userProfileImage) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return UpdateServiceUserDetails(userProfileImage: userProfileImage);
        },
        transitionDuration: Duration(milliseconds: 3000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[3], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // Service User Edit Profile Screen Refresh
  static void switchToServiceUserEditProfileRefreshScreen(
      BuildContext context, String userProfileImage) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return UpdateServiceUserDetails(userProfileImage: userProfileImage);
        },
        transitionDuration: Duration(milliseconds: 3000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[3], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //User BookingDetailsConfirmedScreen
  static void switchToServiceUserBookingDetailsConfirmedScreen(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingDetailsConfirmedScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //User BookingDetailsCompletedScreen
  static void switchToServiceUserBookingDetailsCompletedScreen(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingDetailsCompletedScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //User BookingDetailsCompletedScreen one
  static void switchToServiceUserBookingDetailsCompletedScreenOne(
      BuildContext context, var userID) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return /* SampleBookingScreen(userID); // */ BookingDetailHomePage(
              userID);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // Service User Ratings And Review Screen
  static void switchToServiceUserRatingsAndReviewScreen(
      BuildContext context, userBooking.BookingDetailsList bookingDetail) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return RatingsAndReviewUser(bookingDetail);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // Service Display User Ratings And Review Screen
  static void switchToServiceUserDisplayReviewScreen(BuildContext context, id) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return DisplayUserReview(id);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // Switch to given Rating List
  static void switchToServiceUserGivenReviewScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return GivenRatingList();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  static void switchToServiceUserReservationAndFavourite(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BottomBarUser(2);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Reservation Completed Screen
  static void switchToUserCompletedHistoryScreen(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarUser(
                  2,
                  historyPage: 1,
                )));
  }

  // Service Provider Chat Screen
  /*  static void switchToServiceProviderChatHistoryScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Chat()));
  }
 */

  // Service User Notifications Screen
  static void switchToServiceUserNoticeScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return NotifyScreenUser();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // search detailScreen
  static void switchToServiceUserDetailScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return DetailPageSearch();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //User BookingDetailsApprovedScreen
  static void switchToServiceUserBookingDetailsApprovedScreen(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingDetailsApprovedScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // Service User Booking Confirmation Screen
  static void switchToServiceUserBookingConfirmationScreen(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingConfirmationScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

// Service User Confirm Booking Screen Screen
  static void switchToServiceUserFinalConfirmBookingScreen(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ConfirmBookingScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //BookingCancelScreen
  static void switchToServiceUserBookingCancelScreen(
      BuildContext context, int bookingId, int bookingStatus) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingCancelScreen(bookingId, bookingStatus);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //CancelPopupScreen
  static void switchToServiceUserBookingCancelScreenPopup(
      BuildContext context, int bookingId,int bookingStatus) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return CancelDetailsScreen(bookingId,bookingStatus);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Waiting for approval
  static void switchToServiceUserWaitingForApprovalScreen(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ApprovalWaitingScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //ConditionsApplyBookingScreen
  static void switchToServiceUserConditionsApplyBookingScreen(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ConditionsApplyBookingScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Booking approved screen one
  static void switchToUserBookingApprovedFirstScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingApproveFirstScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

//Booking approved screen two
  static void switchToUserBookingApprovedSecondScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingApproveSecondScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Booking approved screen three
  static void switchToUserBookingApprovedThirdScreen(
      BuildContext context, int id) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingApproveThirdScreen(id);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Booking approved screen three
  static void switchToUserTherapistAcceptNotification(BuildContext context,
      userNotification.NotificationList notificationList) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return TherapistAcceptNotification(notificationList);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Booking cancel screen three
  static void switchToUserTherapistCancelNotification(BuildContext context,
      userNotification.NotificationList notificationList) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingCancelPopup(notificationList);
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  //Booking cancel therapist reason screen
  static void switchToUserBookingCancelTherapistReasonScreen(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingCancelTherapistReasonScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

//Booking cancel therapist response screen
  static void switchToUserBookingCancelTherapistResponseScreen(
      BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingCancelTherapistResponseScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

//Booking cancel timer screen
  static void switchToUserBookingCancelTimerUserScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingCancelTimerUserScreen();
        },
        transitionDuration: Duration(milliseconds: 2000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[2], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  static void switchToReportUserScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ReportUserScreen();
        },
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[11], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // payment processing page
  static void switchToPaymentProcessingScreen(
      BuildContext context, var paymentID) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return PaymentProcessingPage(paymentID);
        },
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[11], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // payment success page
  static void switchToPaymentSuccessScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return PaymentSuccessPage();
        },
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[11], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // payment failure page
  static void switchToPaymentFailedScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return PaymentFailedPage();
        },
        transitionDuration: Duration(milliseconds: 1000),
        transitionsBuilder: (context, animation, anotherAnimation, child) {
          animation = CurvedAnimation(
              curve: HealingMatchConstants.curveList[11], parent: animation);
          return Align(
            child: SizeTransition(
              sizeFactor: animation,
              child: child,
              axisAlignment: 0.0,
            ),
          );
        }));
  }

  // payment failure page
  static void switchToStripeRegisterPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
          pageBuilder: (context, animation, anotherAnimation) {
            return StripeRegisterPage();
          },
          transitionDuration: Duration(milliseconds: 2000),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: HealingMatchConstants.curveList[15], parent: animation);
            return Align(
              child: SizeTransition(
                sizeFactor: animation,
                child: child,
                axisAlignment: 0.0,
              ),
            );
          }),
    );
  }
}
