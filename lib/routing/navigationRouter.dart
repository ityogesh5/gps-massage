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

import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/BookingDetailsApprovedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/BookingDetailsCompletedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/BookingDetailsConfirmedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/BookingDetailScreens/ConditionsAppliedScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/bookingScreensUser/ReservationScreens/reservationAndFavourites.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/calendar.dart';

import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/ChatListScreen.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/ChatScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/chatScreensUser/NoticeScreenUser.dart';
import 'package:gps_massageapp/serviceUser/homeScreen/recommended.dart';
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
import 'package:gps_massageapp/serviceProvider/weeklySchedule/WeeklyScheduleScreen.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderReceiveBooking.dart';

import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferConfirmed.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferCancelTimerUser.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferCancelTimerProvider.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/ProviderOfferCancel.dart';
import 'package:gps_massageapp/serviceProvider/homeScreens/chat/NotificationPopups/AdminNotification.dart';
import 'package:gps_massageapp/serviceProvider/ratingsReview/userRatingReviewScreen.dart';
import 'package:gps_massageapp/serviceProvider/ratingsReview/selfReviewScreen.dart';

import 'package:gps_massageapp/serviceProvider/ratingsReview/providerRatingsReviewScreen.dart';

import 'package:gps_massageapp/serviceProvider/homeScreens/chat/chat.dart';

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

  //User Recommended
  static void switchToRecommended(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Recommend()));
  }

  //User CalendarScreen
  static void switchToCalendarScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => CalendarScreen()));
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
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                ProviderRatingsAndReviewUser(1)));
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

  //User BookingDetailsConfirmedScreen
  static void switchToServiceUserBookingDetailsConfirmedScreen(
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookingDetailsConfirmedScreen()));
  }

  //User BookingDetailsCompletedScreen
  static void switchToServiceUserBookingDetailsCompletedScreen(
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BookingDetailsCompletedScreen()));
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

  // Service Provider Chat Screen
  static void switchToServiceProviderChatHistoryScreen(BuildContext context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => Chat()));
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

  //User BookingDetailsApprovedScreen
  static void switchToServiceUserBookingDetailsApprovedScreen(
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => BookingDetailsApprovedScreen()));
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

  //ConditionsApplyBookingScreen
  static void switchToServiceUserConditionsApplyBookingScreen(
      BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => ConditionsApplyBookingScreen()));
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
