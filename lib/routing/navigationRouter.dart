import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/networkHelper/socketExceptionHandler.dart';
import 'package:gps_massageapp/initialScreens/notificationPopup.dart';
import 'package:gps_massageapp/initialScreens/termsAndConditions.dart';
import 'package:gps_massageapp/initialScreens/userDefineScreen.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/providerBottomBar.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/providerEditProfile.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/termsandConditions.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/changePassword.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/forgetPassword.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/loginScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/chooseServiceScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerFirstScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerSecondScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/registerSuccessOtpScreen.dart';
import 'package:gps_massageapp/serviceProvider/weeklySchedule/weeklyScheduleScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/bookingScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bottomBarUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/ChatListScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/NoticeScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/chatScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/homeScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/nearByProviderAndShop.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/searchScreenUser.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/userChangePassword.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/userForgetPassword.dart';
import 'package:gps_massageapp/serviceUser/loginScreens/userLoginScreen.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/editUpdateUserprofile.dart';
import 'package:gps_massageapp/serviceUser/profileScreens/viewProfileScreen.dart';
import 'package:gps_massageapp/serviceUser/ratingsAndReviewScreen/DisplayUserReviewScreen.dart';
import 'package:gps_massageapp/serviceUser/ratingsAndReviewScreen/RatingsAndReviewUser.dart';
import 'package:gps_massageapp/serviceUser/register/registerOtpScreen.dart';
import 'package:gps_massageapp/serviceUser/register/registerUserScreen.dart';
import 'package:gps_massageapp/serviceUser/searchScreens/searchResult.dart';

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
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => BottomBarUser()));
  }

  //User NearByProviderAndShop
  static void switchToNearByProviderAndShop(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NearByProviderAndShop()));
  }

  //UserSearchScreen
  static void switchToServiceUserSearchScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => SearchScreenUser()));
  }

  //User Search Result
  static void switchToUserSearchResult(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => SearchResult()));
  }

  static void switchToServiceProviderTCScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProviderTermsAndConditions()));
  }

// Provider bottom bar homescreen
  static void switchToServiceProviderBottomBar(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BottomBarProvider()));
  }

  /*static void switchToServiceProviderBottomBar(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  }*/

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

  // User define screen
  static void switchToUserAddAddressScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => AddAddress()));
  }

  // Service User Edit Profile Screen
  static void switchToServiceUserEditProfileScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UpdateServiceUserDetails()));
  }

  // Service User View Profile Screen
  static void switchToServiceUserViewProfileScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => ViewUserProfile()),
        (Route<dynamic> route) => false);
  }

  // Service User Ratings And Review Screen
  static void switchToServiceUserRatingsAndReviewScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => RatingsAndReviewUser()));
  }

  // Service Display User Ratings And Review Screen
  static void switchToServiceUserDisplayReviewScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DisplayUserReview()));
  }

  // Service User Booking Screen
  static void switchToServiceUserBookingScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookingScreenUser()));
  }

  // Service User Chat Screen
  static void switchToServiceUserChatScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => ChatScreenUser()));
  }

  // Service User Notifications Screen
  static void switchToServiceUserNoticeScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NoticeScreenUser()));
  }

  //ChatList User Screen
  static void switchToServiceUserChatListScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ChatListUserScreen()));
  }

// Service User Home Screen
  static void switchToServiceUserHomeScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ServiceUserHomeScreen()));
  }
}
