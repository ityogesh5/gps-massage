import 'dart:convert';
import 'dart:io';

import 'package:flutter/src/widgets/framework.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/event.dart';
import 'package:gps_massageapp/models/responseModels/guestUserModel/GuestUserResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/paymentModels/CustomerCreation.dart';
import 'package:gps_massageapp/models/responseModels/paymentModels/PaymentCustomerCharge.dart';
import 'package:gps_massageapp/models/responseModels/paymentModels/PaymentSuccessModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/booking/createBooking.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/favouriteTherapist/FavouriteList.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/favouriteTherapist/FavouriteTherapistModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/favouriteTherapist/UnFavouriteTherapistModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/RecommendTherapistModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/UserBannerImagesModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/profile/DeleteSubAddressModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/profile/EditUserSubAddressModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/ratings/ratingList.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/searchModels/SearchTherapistByTypeModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/searchModels/SearchTherapistResultsModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetUserDetails.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;

class ServiceUserAPIProvider {
  static const _scopes = const [CalendarApi.calendarScope];

  static TherapistUsersModel listOfTherapistModel = new TherapistUsersModel();
  static UserBannerImagesModel _bannerModel = new UserBannerImagesModel();
  static TherapistsByTypeModel _therapistsByTypeModel =
      new TherapistsByTypeModel();

  static TherapistByIdModel _therapisyByIdModel = new TherapistByIdModel();
  static GetUserDetailsByIdModel _getUserDetailsByIdModel =
      new GetUserDetailsByIdModel();

  static SearchTherapistResultsModel _searchTherapistResultsModel =
      new SearchTherapistResultsModel();

  static SearchTherapistByTypeModel _searchTherapistByTypeModel =
      new SearchTherapistByTypeModel();

  // DeleteSubAddressModel
  static DeleteSubAddressModel _deleteSubAddressModel =
      new DeleteSubAddressModel();

  //Edit user sub address

  static EditUserSubAddressModel _editUserSubAddressModel =
      new EditUserSubAddressModel();

  static RecommendedTherapistModel _recommendedTherapistModel =
      new RecommendedTherapistModel();

  static UserReviewListById _userReviewListById = new UserReviewListById();

  static CreateBookingModel _bookingTherapistModel = new CreateBookingModel();

  static FavouriteTherapist _favouriteTherapist = new FavouriteTherapist();

  static UnFavouriteTherapist _unFavouriteTherapist =
      new UnFavouriteTherapist();

  static FavouriteListModel _favouriteListModel = new FavouriteListModel();

  static GuestUserModel _guestUserModel = new GuestUserModel();

  // payment models
  static PaymentCustomerCreation _customerCreation =
      new PaymentCustomerCreation();
  static PaymentCustomerCharge _paymentCustomerCharge =
      new PaymentCustomerCharge();
  static PaymentSuccessModel _paymentSuccessModel = new PaymentSuccessModel();

  // get all therapist users
  static Future<TherapistUsersModel> getAllTherapistUsers(
      BuildContext context) async {
    try {
      final url = HealingMatchConstants.THERAPIST_LIST_URL;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url, headers: headers);
      final getTherapists = json.decode(response.body);
      listOfTherapistModel = TherapistUsersModel.fromJson(getTherapists);
      print('Response body : ${response.body}');
    } catch (e) {
      print(e.toString());
      ProgressDialogBuilder.hideLoader(context);
    }

    return listOfTherapistModel;
  }

  // get limit of therapist users
  static Future<TherapistUsersModel> getAllTherapistsByLimit(
      BuildContext context, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.ON_PREMISE_USER_BASE_URL}/user/homeTherapistList?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.get(url, headers: headers);
      final getTherapists = json.decode(response.body);
      listOfTherapistModel = TherapistUsersModel.fromJson(getTherapists);
      print('More Response body : ${response.body}');
    } catch (e) {
      print(e.toString());
      ProgressDialogBuilder.hideLoader(context);
    }

    return listOfTherapistModel;
  }

  // get more of therapist users
  static Future<TherapistsByTypeModel> getTherapistsByTypeLimit(
      BuildContext context, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.ON_PREMISE_USER_BASE_URL}/user/homeTherapistListByType?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "type": HealingMatchConstants.serviceTypeValue,
          }));
      final getTherapistByType = json.decode(response.body);
      _therapistsByTypeModel =
          TherapistsByTypeModel.fromJson(getTherapistByType);
      print('Therapist Type Response body : ${response.body}');
    } catch (e) {
      print(e.toString());
      ProgressDialogBuilder.hideLoader(context);
    }
    return _therapistsByTypeModel;
  }

  //get Favourite List
  static Future<FavouriteListModel> getFavouriteList(
      int pageNumber, int pageSize) async {
    try {
      final url = HealingMatchConstants.ON_PREMISE_USER_BASE_URL +
          '/favourite/favouriteTherapistList?page=$pageNumber&size=$pageSize';
      // ?page=$pageNumber&size=$pageSize

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': HealingMatchConstants.accessToken
      };
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        print('response : ${response.body}');
        var getFavouriteResponse = json.decode(response.body);
        _favouriteListModel = FavouriteListModel.fromJson(getFavouriteResponse);
        print(
            'getFavouriteResponse : ${_favouriteListModel.data.favouriteUserList.length}');
      } else {
        print('Error occurred!!! TypeMassages response');
        throw Exception();
      }
    } catch (e) {
      print(e.toString());
      // ProgressDialogBuilder.hideLoader(context);
    }
    return _favouriteListModel;
  }

  // get all therapist ratings
  static Future<UserReviewListById> getAllTherapistsRatings(
      BuildContext context) async {
    ProgressDialogBuilder.showOverlayLoader(context);
    try {
      final url = HealingMatchConstants.RATING_PROVIDER_LIST_URL;
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "therapistId": "${HealingMatchConstants.therapistRatingID}",
          }));
      print(response.body);
      if (response.statusCode == 200) {
        _userReviewListById =
            UserReviewListById.fromJson(json.decode(response.body));
      }
      ProgressDialogBuilder.hideLoader(context);
      print('Status code : ${response.statusCode}');
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Ratings and review exception : ${e.toString()}');
    }

    return _userReviewListById;
  }

  // get limit of therapist ratings
  static Future<UserReviewListById> getAllTherapistsRatingsByLimit(
      BuildContext context, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.ON_PREMISE_USER_BASE_URL}/mobileReview/therapistReviewListById?page=$pageNumber&size=$pageSize';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "therapistId": "${HealingMatchConstants.therapistRatingID}",
          }));
      print(response.body);
      if (response.statusCode == 200) {
        _userReviewListById =
            UserReviewListById.fromJson(json.decode(response.body));
      }

      print('Status code : ${response.statusCode}');
    } catch (e) {
      print('Ratings and review exception : ${e.toString()}');
    }

    return _userReviewListById;
  }

  // get home screen user banner images
  static Future<UserBannerImagesModel> getAllBannerImages(
      BuildContext context) async {
    try {
      final url = HealingMatchConstants.BANNER_IMAGES_URL;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': HealingMatchConstants.accessToken
      };
      final response = await http.get(url, headers: headers);
      final getBannerImages = json.decode(response.body);
      print('Banner Response body : ${response.body}');
      _bannerModel = UserBannerImagesModel.fromJson(getBannerImages);
    } on SocketException catch (_) {
      //handle socket Exception
      print('Socket Exception...Occurred');
    } catch (e) {
      print('Banner Exception caught : ${e.toString()}');
      ProgressDialogBuilder.hideLoader(context);
      throw Exception(e);
    }
    return _bannerModel;
  }

  // get home screen user banner images
  static Future<GetUserDetailsByIdModel> getUserDetails(
      BuildContext context, String userID) async {
    try {
      final url = HealingMatchConstants.GET_USER_DETAILS;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "user_id": userID,
          }));
      final getUserDetails = json.decode(response.body);
      print('User Details Response : ${response.body}');
      _getUserDetailsByIdModel =
          GetUserDetailsByIdModel.fromJson(getUserDetails);
    } on SocketException catch (_) {
      //handle socket Exception
      print('Socket Exception...Occurred');
      ProgressDialogBuilder.hideLoader(context);
    } catch (e) {
      print('User Details Exception caught : ${e.toString()}');
      ProgressDialogBuilder.hideLoader(context);
    }
    return _getUserDetailsByIdModel;
  }

  // get therapist details by ID
  static Future<TherapistByIdModel> getTherapistDetails(
      BuildContext context, var userID) async {
    try {
      final url = HealingMatchConstants.GET_THERAPIST_DETAILS;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapistId": userID,
            "userId": 233,
          }));
      final getTherapistDetails = json.decode(response.body);
      print('Therapist Details Response : ${response.body}');
      TherapistByIdModel _therapisyByIdModel =
          TherapistByIdModel.fromJson(getTherapistDetails);
      ProgressDialogBuilder.hideLoader(context);
      return _therapisyByIdModel;
    } on SocketException catch (_) {
      //handle socket Exception
      print('Socket Exception...Occurred');
      ProgressDialogBuilder.hideLoader(context);
    } catch (e) {
      print('Therapist Details Exception caught : ${e.toString()}');
      ProgressDialogBuilder.hideLoader(context);
    }
  }

  // get home screen user banner images
  static Future<DeleteSubAddressModel> deleteUserSubAddress(
      BuildContext context, var addressID) async {
    try {
      final url = HealingMatchConstants.DELETE_SUB_ADDRESS_URL;
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "id": addressID,
          }));
      print('Delete Sub Address Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getDeletedResponse = json.decode(response.body);
        _deleteSubAddressModel =
            DeleteSubAddressModel.fromJson(getDeletedResponse);
      }

      print('Status code : ${response.statusCode}');
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Exception in delete !!');
    }
    return _deleteSubAddressModel;
  }

  // get home screen user banner images
  static Future<EditUserSubAddressModel> editUserSubAddress(
      BuildContext context,
      var addressID,
      String subAddress,
      var latitude,
      var longitude) async {
    try {
      final url = HealingMatchConstants.EDIT_SUB_ADDRESS_URL;
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "id": addressID,
            "address": subAddress,
            "lat": latitude,
            "lon": longitude
          }));
      print('Edit Sub Address Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getEditedAddressResponse = json.decode(response.body);
        _editUserSubAddressModel =
            EditUserSubAddressModel.fromJson(getEditedAddressResponse);
      }

      print('Status code : ${response.statusCode}');
    } catch (e) {
      ProgressDialogBuilder.hideLoader(context);
      print('Exception in delete !!');
    }
    return _editUserSubAddressModel;
  }

  // get search screen user therapist results
  static Future<SearchTherapistResultsModel> getTherapistSearchResults(
      BuildContext context, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.FETCH_THERAPIST_SEARCH_RESULTS}?page=$pageNumber&size=$pageSize';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "keyword": HealingMatchConstants.searchKeyWordValue,
            "userAddress": HealingMatchConstants.searchUserAddress,
            "serviceType": HealingMatchConstants.serviceType,
            "serviceLocationCriteria": HealingMatchConstants.isLocationCriteria,
            "serviceTimeCriteria": HealingMatchConstants.isTimeCriteria,
            "selectedTime": HealingMatchConstants.dateTime.toIso8601String(),
            "searchDistanceRadius": HealingMatchConstants.searchDistanceRadius,
            "latitude": HealingMatchConstants.searchAddressLatitude,
            "longitude": HealingMatchConstants.searchAddressLongitude,
          }));
      print('Search results Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getDeletedResponse = json.decode(response.body);
        _searchTherapistResultsModel =
            SearchTherapistResultsModel.fromJson(getDeletedResponse);
      }
    } catch (e) {
      print('Exception Search API : ${e.toString()}');
    }
    return _searchTherapistResultsModel;
  }

  // get search screen user therapist results
  static Future<SearchTherapistByTypeModel> getTherapistSearchResultsByType(
      BuildContext context, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.FETCH_THERAPIST_SEARCH_RESULTS}?page=$pageNumber&size=$pageSize';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "type": HealingMatchConstants.searchServiceType,
          }));
      print('Search results Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getDeletedResponse = json.decode(response.body);
        _searchTherapistByTypeModel =
            SearchTherapistByTypeModel.fromJson(getDeletedResponse);
      }
    } catch (e) {
      print('Exception Search API : ${e.toString()}');
    }
    return _searchTherapistByTypeModel;
  }

  // get recommended therapist results
  static Future<RecommendedTherapistModel> getRecommendedTherapists(
      BuildContext context, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.RECOMMENDED_THERAPISTS_LIST}?page=$pageNumber&size=$pageSize';
      final response = await http.get(url, headers: {
        "Content-Type": "application/json",
        "x-access-token": HealingMatchConstants.accessToken
      });
      print('Search results Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getRecommendedTherapistResponse = json.decode(response.body);
        _recommendedTherapistModel =
            RecommendedTherapistModel.fromJson(getRecommendedTherapistResponse);
      }
    } catch (e) {
      print('Exception Search API : ${e.toString()}');
    }
    return _recommendedTherapistModel;
  }

  //Create Booking
  static Future<CreateBookingModel> createBooking(
      BuildContext context,
      int therapistId,
      String startTime,
      String endTime,
      int paymentStatus,
      int subCategoryId,
      int categoryId,
      String nameOfService,
      int totalMinOfService,
      int priceOfService,
      int bookingStatus,
      String locationType,
      String location,
      int totalCost,
      int userReviewStatus,
      int therapistReviewStatus,
      String userCommands) async {
    try {
      final url = '${HealingMatchConstants.BOOKING_THERAPIST}';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "therapistId": therapistId,
            "startTime": startTime,
            "endTime": endTime,
            "paymentStatus": paymentStatus,
            "subCategoryId": subCategoryId,
            "categoryId": categoryId,
            "nameOfService": nameOfService,
            "totalMinOfService": totalMinOfService,
            "priceOfService": priceOfService,
            "bookingStatus": bookingStatus,
            "locationType": locationType,
            "location": location,
            "totalCost": totalCost,
            "userReviewStatus": userReviewStatus,
            "userCommands": userCommands,
          }));

      print('booking results Body : ${response.body}');
      if (response.statusCode == 200) {
        final bookingResponse = json.decode(response.body);
        _bookingTherapistModel = CreateBookingModel.fromJson(bookingResponse);
      }
    } catch (e) {
      print('Exception Search API : ${e.toString()}');
    }
    return _bookingTherapistModel;
  }

  // favourite therapist
  static Future<FavouriteTherapist> favouriteTherapist(var therapistID) async {
    try {
      final url = '${HealingMatchConstants.DO_FAVOURITE_THERAPIST}';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "therapistId": therapistID,
          }));
      print('FavouriteTherapist Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getResponse = json.decode(response.body);
        _favouriteTherapist = FavouriteTherapist.fromJson(getResponse);
      } else {
        print('Favourite API Request failed !!');
      }
    } catch (e) {
      print('Exception FavouriteTherapist API : ${e.toString()}');
    }
    return _favouriteTherapist;
  }

  // un-favourite therapist
  static Future<bool> unFavouriteTherapist(var therapistID) async {
    try {
      final url = '${HealingMatchConstants.UNDO_FAVOURITE_THERAPIST}';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "therapistId": therapistID,
          }));
      print('UnFavourite therapist response : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getResponse = json.decode(response.body);
        // _unFavouriteTherapist = UnFavouriteTherapist.fromJson(getResponse);
        return true;
      } else {
        print('Un Favourite API Request failed !!');
      }
    } catch (e) {
      print('Exception UnFavouriteTherapist API : ${e.toString()}');
    }
    return false;
  }

  // guest user api call
  static Future<GuestUserModel> handleGuestUser(var isTherapistValue) async {
    try {
      final url = '${HealingMatchConstants.HANDLE_GUEST_USER}';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "fcmToken": HealingMatchConstants.userDeviceToken,
            "isTherapist": isTherapistValue,
            "lat": HealingMatchConstants.currentLatitude,
            "lon": HealingMatchConstants.currentLongitude,
          }));
      print('GuestUser response : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getResponse = json.decode(response.body);
        _guestUserModel = GuestUserModel.fromJson(getResponse);
      } else {
        print('GuestUser API Request failed !!');
      }
    } catch (e) {
      print('Exception GuestUser API : ${e.toString()}');
    }
    return _guestUserModel;
  }

  // createCustomerForPayment
  static Future<PaymentCustomerCreation> createCustomerForPayment(
      BuildContext context, var userID) async {
    try {
      final url = '${HealingMatchConstants.CREATE_CUSTOMER_FOR_PAYMENT_URL}';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": '${HealingMatchConstants.accessToken}'
          },
          body: json.encode({
            "userId": userID,
          }));
      print('createCustomerForPayment response : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getResponse = json.decode(response.body);
        _customerCreation = PaymentCustomerCreation.fromJson(getResponse);
      } else {
        NavigationRouter.switchToPaymentFailedScreen(context);
        print('createCustomerForPayment API Request failed !!');
      }
    } catch (e) {
      NavigationRouter.switchToPaymentFailedScreen(context);
      print('createCustomerForPayment GuestUser API : ${e.toString()}');
    }
    return _customerCreation;
  }

  // chargePaymentForCustomer
  static Future<PaymentCustomerCharge> chargePaymentForCustomer(
      BuildContext context, var userID, var cardID, var amount) async {
    try {
      final url = '${HealingMatchConstants.CHARGE_CUSTOMER_URL}';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": '${HealingMatchConstants.accessToken}'
          },
          body: json.encode({
            "userId": userID,
            "amount": amount,
            "cardId": cardID,
          }));
      print('chargePaymentForCustomer response : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getResponse = json.decode(response.body);
        _paymentCustomerCharge = PaymentCustomerCharge.fromJson(getResponse);
      } else {
        NavigationRouter.switchToPaymentFailedScreen(context);
        print('chargePaymentForCustomer API Request failed !!');
      }
    } catch (e) {
      NavigationRouter.switchToPaymentFailedScreen(context);
      print('Exception chargePaymentForCustomer API : ${e.toString()}');
    }
    return _paymentCustomerCharge;
  }

  // paymentSuccess
  static Future<PaymentSuccessModel> paymentSuccess(
      BuildContext context, var paymentID, var cardID) async {
    try {
      final url = '${HealingMatchConstants.PAYMENT_SUCCESS_CALL_URL}';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": '${HealingMatchConstants.accessToken}'
          },
          body: json.encode({
            "paymentId": paymentID,
            "cardId": cardID,
          }));
      print('paymentSuccess response : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        final getResponse = json.decode(response.body);
        _paymentSuccessModel = PaymentSuccessModel.fromJson(getResponse);
      } else {
        print('paymentSuccess API Request failed !!');
        NavigationRouter.switchToPaymentFailedScreen(context);
      }
    } catch (e) {
      NavigationRouter.switchToPaymentFailedScreen(context);
      print('Exception paymentSuccess API : ${e.toString()}');
    }
    return _paymentSuccessModel;
  }

  // Get calendar events

  static Future<List<FlutterWeekViewEvent>> getCalEvents() async {
    List<FlutterWeekViewEvent> flutterEvents = List<FlutterWeekViewEvent>();
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "private_key_id": "cc971fe468280c2bb3c63dbdaffd886a5a781acd",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQChN1yuJiB8W4pp\ngMWBnglEBahi5BEo8i1BG3Lz7ANg1wrKK9VB2btT0KHXBQk3eT6qXiv4Mp0ScTWJ\n3xEaR2VKPzb07PPIUr4b9DL7XMfHEYg3Hyfr+oz7De1mwgbmuzEZD66MxFfbL54V\nkHUOgvbtq5QbafaOMBrzsA7GUu2GRSo50KZB1NEL4ffiUx40KmeoP6ZwlFGLlkCN\n+cu4KoVaouPbXNC52lSH+ma4ePlaCXbbDpkdDjvtvEXm8UMLp2+xJEvVsjLy7hAa\nk4R12uVuNhg1IQakAecIWFYIrKwFvbzBsP/yEWcTvds3vHOrJtLzFIppVm26ChBe\nLGC1ngc9AgMBAAECggEACdn09SRZzFeYrelDSHAkj05MM5zNqqOf3dBkViD4NOD3\nJRMIIVHBh3Xiid3iKgxj5qvCApTvMbsOwznJFQLDXwXdYRqgq/9YZCNoQSFyiMja\nusmR2jLxjf7UILkfDFbogWhKqYnu93MhtR4idQxONAhN0N4JBbfNUdJSmM5k+tUi\ns9IwrlsH+ngSBe8gKjO2EmwmVGJBWse4rbCcGStzA/0Li2IQ7Ez0q0Wy1rkcFfIq\nwTqOLt12m5BtZ/k0qzTCWnZ5yNB7Y5sSpqFFidUjD7pmiakJk8H+luwv+fwVPlRa\nvAHCgsj9iIb3BoVNGIQoCLIFl/UfXG0cV3FI2sg/4QKBgQDgVCsflWk9H0fVzS56\nJp3kD766F08aY/cbkgzCFmKY2YfGDr06gBlD/Gqmhi8PwHjYhdAbt8hfKegwfBxg\n/mSemzV6uQaKaqEtEKiToL2zb2T6H4y5kVOv4frU4nrrAnPbLaD6iTEWmB+9WjrI\nLjZQortcm5Iqyb+0PVbH/AQcYQKBgQC3+iQgqeni7zQw0Ro3AmsEK6SHYONM6y0z\n0fUS2eMkxwj1uTchmshesZrVocqm4CMORU6i5GR/7e+rNrnuDybAEVNGExS0XmaJ\nNmHDzqmYaQ+mdmM1SlJl8pXDnocT+dZqCIAswIg05gT3l3TxCHxS5EPfrIMmgVod\ns/asnfq4XQKBgATCBEAhPSAsv6tLNMcmdobVxqfPwr++iwksqdScAO9Y/cY3nc/V\n07NbcS+i/PCKloWRIP7VgQxzqRcOKtPr0VqD1DiMIBVjeZOpHMo0yJE7tZqQfL2a\n1XmPg3BsdUryvF5Ts2xc6IugIlwzw7dnM4O2T98A9bKuoMBD5MlNERFBAoGAbBhS\npcZvn2CAP7Z8Opn3Gsoxr0EkDAuZ0XqpDdxrcy5me0nJtLrmw4yCtsaK9SV4M2hR\nXa/nxKqeSPCsqczJLcyAKwoG/jsA79m983g3eU8xXNLuU19JrpCrofZA02HVsxMv\njBvLa5lCjd61XPFpaqKnpoILxNH3isA0TRO9PhkCgYEAq0nGMl0LtTPACOAHW8GS\nlBtntpcoxJShS99DHqe9UGxkp49ytpWDVXL71fL9aGGXumjg2esSVSkFRRWajcj3\n+DVXf0HJ+AA2U21GAIjtZ4wuOqJBK/aiCSEvE/pnDGnpUG72ouH9v0gKOxapm4UJ\nh9+CT/1T5O6d2bywzHMgI4Q=\n-----END PRIVATE KEY-----\n",
      "client_email":
          "sample-service-account-1@calendarapi-291906.iam.gserviceaccount.com",
      "client_id": "110731698305796155207",
      "type": "service_account"
    });
    final httpClient =
        await clientViaServiceAccount(accountCredentials, _scopes);
    var calendar = CalendarApi(httpClient);
    DateTime lastMonth = DateTime(2020, 09, 1);
    DateTime firstMonth = DateTime(2020, 09, 30);
    var calEvents = calendar.events.list(
      "aswin007arun@gmail.com",
      q: "SU30",
      /*  timeMax: lastMonth.toUtc(), timeMin: firstMonth.toUtc() */
    );
    Events events = await calEvents;
    List<Event> unavailableEvents = List<Event>();
    events.items.forEach((event) {
// {events.items.forEach((event) => print("EVENT ${event.summary}"))});
      if (event.description == "unavailable") {
        unavailableEvents.add(event);
      } else {
        flutterEvents.add(
          FlutterWeekViewEvent(
            events: event,
            start: event.start.dateTime.toLocal(),
            end: event.end.dateTime.toLocal(),
          ),
        );
      }
    });
    HealingMatchConstants.userEvents.clear();
    HealingMatchConstants.userEvents.addAll(flutterEvents);
    httpClient.close();
    return HealingMatchConstants.userEvents;
  }

  static Future<bool> saveFirebaseUserID(
      String firebaseID, BuildContext context, int id) async {
    try {
      final url = HealingMatchConstants.FIREBASE_UPDATE_USERID;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode(
              {"id": id, "isTherapist": 0, "firebaseUDID": firebaseID}));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return false;
    }
  }
}
