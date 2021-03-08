import 'package:flutter/material.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/networkHelper/socketExceptionHandler.dart';
import 'package:gps_massageapp/initialScreens/notificationPopup.dart';
import 'package:gps_massageapp/initialScreens/providerTutorial.dart';
import 'package:gps_massageapp/initialScreens/termsAndConditions.dart';
import 'package:gps_massageapp/initialScreens/userDefineScreen.dart';
import 'package:gps_massageapp/initialScreens/userTutorial.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/ProviderTutorial.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/ProviderBottomBar.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/ProviderEditProfile.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/myAccount/TermsAndConditions.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/ChangePassword.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/ForgetPassword.dart';
import 'package:gps_massageapp/serviceProvider/loginScreens/LoginScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/ChooseServiceScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/RegisterFirstScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/RegisterSecondScreen.dart';
import 'package:gps_massageapp/serviceProvider/registerProvider/RegisterSuccessOTPScreen.dart';
import 'package:gps_massageapp/serviceProvider/weeklySchedule/WeeklyScheduleScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/BottomBarUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/HomeScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/NearByProviderAndShop.dart';
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
import 'file:///C:/Users/user1/Documents/HealingMatch%20App/gps-massage/lib/serviceUser/homeScreen/bookingScreensUser/ReservationScreens/reservationAndFavourites.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/ChatListScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/ChatScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/NoticeScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/SearchScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/detailPageSearchOne.dart';
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
import 'package:gps_massageapp/serviceUser/searchScreens/SearchResult.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/searchScreensUser/detailPageSearch.dart';

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
        MaterialPageRoute(builder: (BuildContext context) => BottomBarUser(0)),
        (Route<dynamic> route) => false);
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

  //User Search detail design page one
  static void switchToUserSearchDetailPageOne(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailPageSearchOne()));
  }

  static void switchToServiceProviderTCScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ProviderTermsAndConditions()));
  }

  static void switchToServiceUserTCScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => UserTermsAndConditions()));
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => UserInitialTutorial()));
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
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => UserTutorial()));
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

  static void switchToServiceUserReservationAndFavourite(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ReservationAndFavourite()));
  }

  // Service User Chat Screen
  static void switchToServiceUserChatHistoryScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ChatHistoryScreenUser()));
  }

  // Service User Notifications Screen
  static void switchToServiceUserNoticeScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => NoticeScreenUser()));
  }

  //ChatList User Screen
  static void switchToServiceUserChatScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => ChatUserScreen()));
  }

// Service User Home Screen
  /* static void switchToServiceUserHomeScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ServiceUserHomeScreen()));
  }*/
  // search detailScreen
  static void switchToServiceUserDetailScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => DetailPageSearch()));
  }

  // Service User Booking Confirmation Screen
  static void switchToServiceUserBookingConfirmationScreen(
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookingConfirmationScreen()));
  }

// Service User Confirm Booking Screen Screen
  static void switchToServiceUserFinalConfirmBookingScreen(
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ConfirmBookingScreen()));
  }

  //BookingCancelScreen
  static void switchToServiceUserBookingCancelScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookingCancelScreen()));
  }

  //Waiting for approval
  static void switchToServiceUserWaitingForApprovalScreen(
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ApprovalWaitingScreen()));
  }

  //Booking approved screen one
  static void switchToUserBookingApprovedFirstScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookingApproveFirstScreen()));
  }

//Booking approved screen two
  static void switchToUserBookingApprovedSecondScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookingApproveSecondScreen()));
  }

  //Booking approved screen three
  static void switchToUserBookingApprovedThirdScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookingApproveThirdScreen()));
  }

  //Booking cancel therapist reason screen
  static void switchToUserBookingCancelTherapistReasonScreen(
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                BookingCancelTherapistReasonScreen()));
  }

//Booking cancel therapist response screen
  static void switchToUserBookingCancelTherapistResponseScreen(
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                BookingCancelTherapistResponseScreen()));
  }

//Booking cancel timer screen
  static void switchToUserBookingCancelTimerUserScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookingCancelTimerUserScreen()));
  }
}
