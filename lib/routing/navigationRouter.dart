import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/networkHelper/socketExceptionHandler.dart';
import 'package:gps_massageapp/initialScreens/notificationPopup.dart';
import 'package:gps_massageapp/initialScreens/providerTutorial.dart';
import 'package:gps_massageapp/initialScreens/termsAndConditions.dart';
import 'package:gps_massageapp/initialScreens/userDefineScreen.dart';
import 'package:gps_massageapp/initialScreens/userTutorial.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/ProviderBottomBar.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/AdminNotification.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferCancel.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferCancelTimerProvider.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferCancelTimerUser.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferConfirmed.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderReceiveBooking.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/chat.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/ProviderEditProfile.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/ProviderTutorial.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/TermsAndConditions.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/calendar/providerCalendar.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/ChangePassword.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/ForgetPassword.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/LoginScreen.dart';
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
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/BookingDetailsCompletedScreenOne.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/BookingDetailsConfirmedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/ConditionsAppliedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/chooseDate.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/ReservationScreens/reservationAndFavourites.dart';

import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/ReservationScreens/CalendarEventPopup.dart';

import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/bookingCancelScreens/CancelDetailsScreen.dart';

import 'package:gps_massageapp/serviceUser/homeScreen/calendar.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/ChatListScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/ChatScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/NoticeScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/SearchResult.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/SearchResult.dart';

import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/SearchScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/detailPageSearch.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/detailPageSearchOne.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/searchScreenWithoutRegister.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/UserChangePassword.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/UserForgetPassword.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/UserLoginScreen.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/EditUpdateUserprofile.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/TermsAndConditions.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/UserTutorial.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/ViewProfileScreen.dart';
import 'package:gps_massageapp/serviceUser/ratingsAndReviewScreen/DisplayUserReviewScreen.dart';
import 'package:gps_massageapp/serviceUser/ratingsAndReviewScreen/RatingsAndReviewUser.dart';
import 'package:gps_massageapp/serviceUser/register/RegisterOTPScreen.dart';
import 'package:gps_massageapp/serviceUser/register/RegisterUserScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/Recommended.dart';

class NavigationRouter {
  // Network dis connect handler class
  static void switchToNetworkHandler(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SocketExceptionHandler()));
  }

  static void switchToServiceUserRegistration(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterServiceUserScreen()));
  }

//Provider WeeklySchedule
  static void switchToWeeklySchedule(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => WeeklySchedule()));
  }

// Terms and conditions screen
  static void switchToTermsAndConditions(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => IntroTermsAndPolicy()));
  }

  //NotificationPopup
  static void switchToNotificationPopup(BuildContext context) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => NotificationPopup()));
  }

// User define screen
  static void switchToUserDefineScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => UserDefineScreen()));
  }

  // Provider login screen

  static void switchToProviderLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ProviderLogin()),
        (Route<dynamic> route) => false);
  }

//User Login screen
  static void switchToUserLogin(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => UserLogin()),
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
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => ChooseDate()));
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
          return DetailPageSearchOne(userID);
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
        MaterialPageRoute(
            builder: (BuildContext context) => ProviderTermsAndConditions()));
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
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider(0)),
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
  static void switchToServiceProviderMyAccount(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider(3)));
  }

  //Provider Choose service screen
  static void switchToChooseServiceScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ChooseServiceScreen()));
  }

  // Provider Register 1st screen
  static void switchToServiceProviderFirstScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterProviderFirstScreen()));
  }

  // Provider Register 2nd screen

  static void switchToServiceProviderSecondScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RegistrationProviderSecondScreen()));
  }

  //Provider Receive Booking Screen

  static void switchToReceiveBookingScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProviderReceiveBooking()));
  }

  //Provider Offer Cancel Screen

  static void switchToOfferCancelScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProviderOfferCancel()));
  }

  //Provider Offer Confirmed Screen

  static void switchToOfferConfirmedScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ProviderOfferConfirmed()));
  }

  //Provider Offer Cancel Timer User Screen

  static void switchToOfferCancelScreenTimerUser(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProviderOfferCancelTimerUser()));
  }

  //Provider Offer Cancel Timer Provider Screen

  static void switchToOfferCancelScreenTimerProvider(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ProviderOfferCancelTimerProvider()));
  }

  //Provider Admin Notification Provider Screen

  static void switchToAdminNotificationScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => AdminNotification()));
  }

  //Provider Phone number input Forget Password Screen

  static void switchToProviderForgetPasswordScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ForgetPassword()));
  }

  static void switchToUserForgetPasswordScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserForgetPassword()));
  }

  // Provider Change password screen
  static void switchToProviderChangePasswordScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChangePassword()));
  }

  // User Change password screen
  static void switchToUserChangePasswordScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => UserChangePassword()));
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RegisterOtpScreen()));
  }

  //Provider Edit Profile Screen
  static void switchToProviderEditProfileScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProviderEditProfile()));
  }

  //Provider Initial Tutorial Screen
  static void switchToProviderInitialTutorialScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProviderInitialTutorial()));
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
  static void switchToProviderSideUserReviewScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => UserRatingReviewScreen()));
  }

  //Provider Self Review Screen
  static void switchToProviderSelfReviewScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProviderSelfReviewScreen()));
  }

  //Provider Provider Review Screen
  static void switchToProviderReviewScreen(BuildContext context, int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ProviderRatingsAndReviewUser(index)));
  }

  //Provider Provider Review Screen
  static void switchToProviderReviewScreenSent(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => UserRatingReviewScreen()
            // ProviderRatingsAndReviewUser(1)
            ));
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

  // User calender screen
  static void switchToUserCalendarScreenScreen(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
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
          return DetailBloc(userID);
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

  // Service User View Profile Screen
  static void switchToServiceUserViewProfileScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        PageRouteBuilder(
            pageBuilder: (context, animation, anotherAnimation) {
              return ViewUserProfile();
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

  // Service User Ratings And Review Screen
  static void switchToServiceUserRatingsAndReviewScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return RatingsAndReviewUser();
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
  static void switchToServiceUserDisplayReviewScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return DisplayUserReview();
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
          return ReservationAndFavourite();
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

  // Service User Chat Screen
  static void switchToServiceUserChatHistoryScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ChatHistoryScreenUser();
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

  // Service Provider Chat Screen
  static void switchToServiceProviderChatHistoryScreen(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Chat()));
  }

  // Service User Notifications Screen
  static void switchToServiceUserNoticeScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return NoticeScreenUser();
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

  //ChatList User Screen
  static void switchToServiceUserChatScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return ChatUserScreen();
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
  static void switchToServiceUserBookingCancelScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingCancelScreen();
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
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => CancelDetailsScreen()));
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
  static void switchToUserBookingApprovedThirdScreen(BuildContext context) {
    Navigator.of(context).push(PageRouteBuilder(
        pageBuilder: (context, animation, anotherAnimation) {
          return BookingApproveThirdScreen();
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
}
