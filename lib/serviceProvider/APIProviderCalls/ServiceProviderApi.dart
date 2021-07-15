import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import "package:googleapis/calendar/v3.dart";
import "package:googleapis_auth/auth_io.dart";
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/constantUtils/helperClasses/progressDialogsHelper.dart';
import 'package:gps_massageapp/customLibraryClasses/providerEventCalendar/src/event.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/ProviderDetailsResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/TherapistDetailsModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/currentBookingRatingResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/firebaseNotificationTherapistListModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/providerReviewandRatingsViewResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/therapistBookingHistoryResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewCreateResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewandRatingsResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/paymentModels/PayoutModel.dart';
import 'package:gps_massageapp/routing/navigationRouter.dart';
import 'package:http/http.dart' as http;

class ServiceProviderApi {
  static const _scopes = const [CalendarApi.calendarScope];

  static StripePayOutVerifyFieldsModel _stripePayoutModel =
      new StripePayOutVerifyFieldsModel();

  static TherapistDetailsModel _therapistDetailsModel =
      new TherapistDetailsModel();

  static Future<ProviderReviewandRatingsViewResponseModel>
      getTherapistReviewById(int pageNumber, int pageSize) async {
    try {
      final url = HealingMatchConstants.ON_PREMISE_USER_BASE_URL +
          '/mobileReview/therapistReviewListById?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapistId": HealingMatchConstants.userId,
          }));
      //  print('Therapist repo token : $accessToken : Tid  : $therapistId');
      if (response.statusCode == 200) {
        var therapistData = json.decode(response.body);
        ProviderReviewandRatingsViewResponseModel therapistUsers =
            ProviderReviewandRatingsViewResponseModel.fromJson(therapistData);
        print('Types list:  $therapistData');
        return therapistUsers;
      } else {
        print('Error occurred!!! TypeMassages response');
        throw Exception();
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  static Future<UserReviewandRatingsViewResponseModel> getUserReviewById(
      int pageNumber, int pageSize) async {
    try {
      final url = HealingMatchConstants.ON_PREMISE_USER_BASE_URL +
          '/mobileReview/userReviewListById?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "userId": HealingMatchConstants.serviceUserId, //'20',
          }));
      print(
          'Therapist repo token :${HealingMatchConstants.accessToken} : UserId  : ${HealingMatchConstants.serviceUserId}');
      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        UserReviewandRatingsViewResponseModel usersReview =
            UserReviewandRatingsViewResponseModel.fromJson(userData);
        print('Types list:  $userData');
        return usersReview;
      } else {
        print('Error occurred!!! TypeMassages response');
        throw Exception();
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  static Future<UserReviewCreateResponseModel> giveUserReview(
      double rating, String review, int bookingId) async {
    try {
      final url = HealingMatchConstants.ON_PREMISE_USER_BASE_URL +
          '/mobileReview/createUserReview';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "userId": HealingMatchConstants.serviceUserId,
            "bookingId": bookingId,
            "ratingsCount": rating,
            "reviewComment": review,
          }));
      print('$response');
      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        UserReviewCreateResponseModel usersReview =
            UserReviewCreateResponseModel.fromJson(userData);
        print('Types list:  $userData');
        return usersReview;
      } else {
        print('Error occurred!!! TypeMassages response');
        throw Exception();
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  static Future<CurrentOrderReviewResponseModel> getBookingOrderReviewDetail(
      int bookingId) async {
    try {
      final url = HealingMatchConstants.ON_PREMISE_USER_BASE_URL +
          '/mobileReview/bookingUserReviewById';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "bookingId": bookingId,
          }));
      print('$response');
      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        CurrentOrderReviewResponseModel usersReview =
            CurrentOrderReviewResponseModel.fromJson(userData);
        print('Types list:  $userData');
        return usersReview;
      } else {
        print('Error occurred!!! TypeMassages response');
        throw Exception();
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  static Future<List<FlutterWeekViewEvent>> getCalEvents() async {
    List<FlutterWeekViewEvent> flutterEvents = List<FlutterWeekViewEvent>();
    List<FlutterWeekViewEvent> unavailableCalendarEvents =
        List<FlutterWeekViewEvent>();
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "private_key_id": "ea91c6540fdc102720f699c56f692d25d4aefeec",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC916/Vmhw+wpgw\nYjtvKWWnoVFJqz4sXXu5DRWaB9dSxWhIebQv0n+UdTRz8MT3ipOMz8Z4u9ziw2/J\n6tLJTU82iCk7afMEjSGypAK7osXZW5JvLkAohtamTPYSSKc7oeRfNLLCBZFHoVqQ\nvoQLnBTZbk8HSAwUBu4LFTGdSj226R7VoPeFFcdybA7tKNdM4nk/GTdnJUabTWXQ\nISRgD4ZK2SxJDlWqCkyZ1+6x/d6DEYvZX9QgGczMu8rkReNBpN+AOwZjUQ1sByhA\nhzlQXS+UX7KvJW4kfUCTvRDOr952M5J4aAvGpQzy9B3Hhm91fMsPSrdPtklDceJj\n62JfhVztAgMBAAECggEAGPleXtXCwHjeB4NsuS9zeY1twai+6Zw0sf/oJxa/+1oP\n4XTtQNtKwE944oW6i6wVxBDzVZ+1K7m1I5V6PFQoxw47il7iQueEFtmfqGp95521\n0l19wDcY1tDKEFaxdVVTUzj+CSstVQSDgwYlHdffIEl0KQuP1zSgLSIRIFWLb9vZ\ntpKl0VFrbB6W9NRIzcupHIFdhzvTbZPv/Kd0fHh49zL6oAxfFq8kzRci/jhld/Wz\n1oWlvOne1NSMiZWbltr/iI+YsNMcQdEudWPsw1Wvbnj8YEn9bdFUVb5IS0bc7XP9\n3G6TwHpJMZutSvtlqSIJF7PfvwZJQXeTr+G3EMcGywKBgQD3rUBd9o2ad7W8aKZv\nvErKr1TX9C1rZpadnabGPo5CGSx/tUzwUTpf6FxtTqgvjMhUw8HWGM0iJpf2B7Gc\nef+1w5mMaPz9WV9XeC2//0S9f0QGkPiXDEC9raud6uJQ41hYW6yJp7nrahZ9dFog\nnL0w5HEJ/eSWYwlijtOi+AUZiwKBgQDEOOQR3Bz9rUlrlMJf5s7LlO80TUq12s6U\nRqBmiUiwGBSioQ7gUdedlWjL1Ukh6KMLCvFgwbIEYDsZnL/Uzbb/Qkp3yGuEmyRm\na15iMWJ6TYNGxEw7+6nw7LsVwV528/DRyZQVyJHLPAYG3Zytfi2nRRXSeAS7qIQF\nNyweaG8CZwKBgHAdCr/99Udw3OE2dfCqSSjKiRtgOpcdTxx12qJuerLM9mmwxe0a\nt9PmOMB6FIPBtIU6P6oMe/7zfWIvRWTRjMDYk88NT0fXhuLvUbZRdOpai451XTHy\np/O0g7TuOBfpcXo9tTJyrCQ2V4veeVW93Z4eKlUdirXQitUEViS1JInVAoGAXkb3\nTZ10UG3x2L6gpXM/6JCmXXrFapq2podIiftr8S+guoKnox+veQdQUp8nhCNCMwwO\n7W4jGfcibivh/1zXj81J+kNRZWUlGBB+SK9xoVGcwWOPPUKtZBRZzxoZSQ3rpuAz\nRkQXyI4OVz4jCTiWtsd6tKT1oTRWOitIB1QmAgECgYEAw8Q6oLV4Iq4oKTYJpmha\nvPb4BH+df8lvv9hCGviFBk48ZsY4ImRDb//KlknDmiTgGlW+kLWOFY8+a8NhAMB+\nb/AdpUK2tuYg09RM66bneCBU6wCaSBvUMxZHt469tWboam1i74BCQpDdIDd0A1uL\nb7GwDGIB8mLkOwQXOvKRqBY=\n-----END PRIVATE KEY-----\n",
      "client_email": "healing-match@appspot.gserviceaccount.com",
      "client_id": "109325874687014297008",
      "type": "service_account"
    });
    final httpClient =
        await clientViaServiceAccount(accountCredentials, _scopes);
    var calendar = CalendarApi(httpClient);
    var calEvents = calendar.events.list(
      "sugyo.sumihiko@gmail.com",
      q: "SP${HealingMatchConstants.userId}",
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
    unavailableEvents
        .sort((a, b) => a.start.dateTime.compareTo(b.start.dateTime));
    for (var unavailableEvent in unavailableEvents) {
      if (unavailableCalendarEvents.length == 0) {
        unavailableCalendarEvents.add(
          FlutterWeekViewEvent(
            events: unavailableEvent,
            start: unavailableEvent.start.dateTime.toLocal(),
            end: unavailableEvent.end.dateTime.toLocal(),
          ),
        );
      } else if (unavailableCalendarEvents[unavailableCalendarEvents.length - 1]
              .end ==
          unavailableEvent.start.dateTime.toLocal()) {
        unavailableCalendarEvents[unavailableCalendarEvents.length - 1].end =
            unavailableEvent.end.dateTime.toLocal();
      } else {
        unavailableCalendarEvents.add(
          FlutterWeekViewEvent(
            events: unavailableEvent,
            start: unavailableEvent.start.dateTime.toLocal(),
            end: unavailableEvent.end.dateTime.toLocal(),
          ),
        );
      }
    }
    HealingMatchConstants.calEvents.clear();
    HealingMatchConstants.calEvents.addAll(flutterEvents);
    if (unavailableCalendarEvents.length != 0) {
      flutterEvents.addAll(unavailableCalendarEvents);
    }
    HealingMatchConstants.events.clear();
    HealingMatchConstants.events.addAll(flutterEvents);
    httpClient.close();
    return HealingMatchConstants.events;
  }

  static Future<List<FlutterWeekViewEvent>> getCalXOEvents() async {
    List<FlutterWeekViewEvent> flutterEvents = List<FlutterWeekViewEvent>();
    List<FlutterWeekViewEvent> unavailableCalendarEvents =
        List<FlutterWeekViewEvent>();
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "private_key_id": "ea91c6540fdc102720f699c56f692d25d4aefeec",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC916/Vmhw+wpgw\nYjtvKWWnoVFJqz4sXXu5DRWaB9dSxWhIebQv0n+UdTRz8MT3ipOMz8Z4u9ziw2/J\n6tLJTU82iCk7afMEjSGypAK7osXZW5JvLkAohtamTPYSSKc7oeRfNLLCBZFHoVqQ\nvoQLnBTZbk8HSAwUBu4LFTGdSj226R7VoPeFFcdybA7tKNdM4nk/GTdnJUabTWXQ\nISRgD4ZK2SxJDlWqCkyZ1+6x/d6DEYvZX9QgGczMu8rkReNBpN+AOwZjUQ1sByhA\nhzlQXS+UX7KvJW4kfUCTvRDOr952M5J4aAvGpQzy9B3Hhm91fMsPSrdPtklDceJj\n62JfhVztAgMBAAECggEAGPleXtXCwHjeB4NsuS9zeY1twai+6Zw0sf/oJxa/+1oP\n4XTtQNtKwE944oW6i6wVxBDzVZ+1K7m1I5V6PFQoxw47il7iQueEFtmfqGp95521\n0l19wDcY1tDKEFaxdVVTUzj+CSstVQSDgwYlHdffIEl0KQuP1zSgLSIRIFWLb9vZ\ntpKl0VFrbB6W9NRIzcupHIFdhzvTbZPv/Kd0fHh49zL6oAxfFq8kzRci/jhld/Wz\n1oWlvOne1NSMiZWbltr/iI+YsNMcQdEudWPsw1Wvbnj8YEn9bdFUVb5IS0bc7XP9\n3G6TwHpJMZutSvtlqSIJF7PfvwZJQXeTr+G3EMcGywKBgQD3rUBd9o2ad7W8aKZv\nvErKr1TX9C1rZpadnabGPo5CGSx/tUzwUTpf6FxtTqgvjMhUw8HWGM0iJpf2B7Gc\nef+1w5mMaPz9WV9XeC2//0S9f0QGkPiXDEC9raud6uJQ41hYW6yJp7nrahZ9dFog\nnL0w5HEJ/eSWYwlijtOi+AUZiwKBgQDEOOQR3Bz9rUlrlMJf5s7LlO80TUq12s6U\nRqBmiUiwGBSioQ7gUdedlWjL1Ukh6KMLCvFgwbIEYDsZnL/Uzbb/Qkp3yGuEmyRm\na15iMWJ6TYNGxEw7+6nw7LsVwV528/DRyZQVyJHLPAYG3Zytfi2nRRXSeAS7qIQF\nNyweaG8CZwKBgHAdCr/99Udw3OE2dfCqSSjKiRtgOpcdTxx12qJuerLM9mmwxe0a\nt9PmOMB6FIPBtIU6P6oMe/7zfWIvRWTRjMDYk88NT0fXhuLvUbZRdOpai451XTHy\np/O0g7TuOBfpcXo9tTJyrCQ2V4veeVW93Z4eKlUdirXQitUEViS1JInVAoGAXkb3\nTZ10UG3x2L6gpXM/6JCmXXrFapq2podIiftr8S+guoKnox+veQdQUp8nhCNCMwwO\n7W4jGfcibivh/1zXj81J+kNRZWUlGBB+SK9xoVGcwWOPPUKtZBRZzxoZSQ3rpuAz\nRkQXyI4OVz4jCTiWtsd6tKT1oTRWOitIB1QmAgECgYEAw8Q6oLV4Iq4oKTYJpmha\nvPb4BH+df8lvv9hCGviFBk48ZsY4ImRDb//KlknDmiTgGlW+kLWOFY8+a8NhAMB+\nb/AdpUK2tuYg09RM66bneCBU6wCaSBvUMxZHt469tWboam1i74BCQpDdIDd0A1uL\nb7GwDGIB8mLkOwQXOvKRqBY=\n-----END PRIVATE KEY-----\n",
      "client_email": "healing-match@appspot.gserviceaccount.com",
      "client_id": "109325874687014297008",
      "type": "service_account"
    });
    final httpClient =
        await clientViaServiceAccount(accountCredentials, _scopes);
    var calendar = CalendarApi(httpClient);
    var calEvents = calendar.events.list(
      "sugyo.sumihiko@gmail.com",
      q: "SP${HealingMatchConstants.userId}",
      /*  timeMax: lastMonth.toUtc(), timeMin: firstMonth.toUtc() */
    );
    Events events = await calEvents;
    List<Event> unavailableEvents = List<Event>();
    events.items.forEach((event) {
      // {events.items.forEach((event) => print("EVENT ${event.summary}"))});
      if (event.description == "unavailable") {
        unavailableEvents.add(event);
      } else if (event.status == "confirmed") {
        flutterEvents.add(
          FlutterWeekViewEvent(
            events: event,
            start: event.start.dateTime.toLocal(),
            end: event.end.dateTime.toLocal(),
          ),
        );
      }
    });
    unavailableEvents
        .sort((a, b) => a.start.dateTime.compareTo(b.start.dateTime));
    for (var unavailableEvent in unavailableEvents) {
      if (unavailableCalendarEvents.length == 0) {
        unavailableCalendarEvents.add(
          FlutterWeekViewEvent(
            events: unavailableEvent,
            start: unavailableEvent.start.dateTime.toLocal(),
            end: unavailableEvent.end.dateTime.toLocal(),
          ),
        );
      } else if (unavailableCalendarEvents[unavailableCalendarEvents.length - 1]
              .end ==
          unavailableEvent.start.dateTime.toLocal()) {
        unavailableCalendarEvents[unavailableCalendarEvents.length - 1].end =
            unavailableEvent.end.dateTime.toLocal();
      } else {
        unavailableCalendarEvents.add(
          FlutterWeekViewEvent(
            events: unavailableEvent,
            start: unavailableEvent.start.dateTime.toLocal(),
            end: unavailableEvent.end.dateTime.toLocal(),
          ),
        );
      }
    }
    if (HealingMatchConstants.numberOfEmployeeRegistered > 1) {
      flutterEvents.clear();
    }
    if (unavailableCalendarEvents.length != 0) {
      flutterEvents.addAll(unavailableCalendarEvents);
    }
    HealingMatchConstants.events.clear();
    HealingMatchConstants.events.addAll(flutterEvents);
    httpClient.close();
    return HealingMatchConstants.events;
  }

  static Future<List<FlutterWeekViewEvent>> searchEventByTime(
      DateTime startTime, DateTime endTime) async {
    List<FlutterWeekViewEvent> flutterEvents = List<FlutterWeekViewEvent>();
    List<FlutterWeekViewEvent> unavailableCalendarEvents =
        List<FlutterWeekViewEvent>();
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "private_key_id": "ea91c6540fdc102720f699c56f692d25d4aefeec",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC916/Vmhw+wpgw\nYjtvKWWnoVFJqz4sXXu5DRWaB9dSxWhIebQv0n+UdTRz8MT3ipOMz8Z4u9ziw2/J\n6tLJTU82iCk7afMEjSGypAK7osXZW5JvLkAohtamTPYSSKc7oeRfNLLCBZFHoVqQ\nvoQLnBTZbk8HSAwUBu4LFTGdSj226R7VoPeFFcdybA7tKNdM4nk/GTdnJUabTWXQ\nISRgD4ZK2SxJDlWqCkyZ1+6x/d6DEYvZX9QgGczMu8rkReNBpN+AOwZjUQ1sByhA\nhzlQXS+UX7KvJW4kfUCTvRDOr952M5J4aAvGpQzy9B3Hhm91fMsPSrdPtklDceJj\n62JfhVztAgMBAAECggEAGPleXtXCwHjeB4NsuS9zeY1twai+6Zw0sf/oJxa/+1oP\n4XTtQNtKwE944oW6i6wVxBDzVZ+1K7m1I5V6PFQoxw47il7iQueEFtmfqGp95521\n0l19wDcY1tDKEFaxdVVTUzj+CSstVQSDgwYlHdffIEl0KQuP1zSgLSIRIFWLb9vZ\ntpKl0VFrbB6W9NRIzcupHIFdhzvTbZPv/Kd0fHh49zL6oAxfFq8kzRci/jhld/Wz\n1oWlvOne1NSMiZWbltr/iI+YsNMcQdEudWPsw1Wvbnj8YEn9bdFUVb5IS0bc7XP9\n3G6TwHpJMZutSvtlqSIJF7PfvwZJQXeTr+G3EMcGywKBgQD3rUBd9o2ad7W8aKZv\nvErKr1TX9C1rZpadnabGPo5CGSx/tUzwUTpf6FxtTqgvjMhUw8HWGM0iJpf2B7Gc\nef+1w5mMaPz9WV9XeC2//0S9f0QGkPiXDEC9raud6uJQ41hYW6yJp7nrahZ9dFog\nnL0w5HEJ/eSWYwlijtOi+AUZiwKBgQDEOOQR3Bz9rUlrlMJf5s7LlO80TUq12s6U\nRqBmiUiwGBSioQ7gUdedlWjL1Ukh6KMLCvFgwbIEYDsZnL/Uzbb/Qkp3yGuEmyRm\na15iMWJ6TYNGxEw7+6nw7LsVwV528/DRyZQVyJHLPAYG3Zytfi2nRRXSeAS7qIQF\nNyweaG8CZwKBgHAdCr/99Udw3OE2dfCqSSjKiRtgOpcdTxx12qJuerLM9mmwxe0a\nt9PmOMB6FIPBtIU6P6oMe/7zfWIvRWTRjMDYk88NT0fXhuLvUbZRdOpai451XTHy\np/O0g7TuOBfpcXo9tTJyrCQ2V4veeVW93Z4eKlUdirXQitUEViS1JInVAoGAXkb3\nTZ10UG3x2L6gpXM/6JCmXXrFapq2podIiftr8S+guoKnox+veQdQUp8nhCNCMwwO\n7W4jGfcibivh/1zXj81J+kNRZWUlGBB+SK9xoVGcwWOPPUKtZBRZzxoZSQ3rpuAz\nRkQXyI4OVz4jCTiWtsd6tKT1oTRWOitIB1QmAgECgYEAw8Q6oLV4Iq4oKTYJpmha\nvPb4BH+df8lvv9hCGviFBk48ZsY4ImRDb//KlknDmiTgGlW+kLWOFY8+a8NhAMB+\nb/AdpUK2tuYg09RM66bneCBU6wCaSBvUMxZHt469tWboam1i74BCQpDdIDd0A1uL\nb7GwDGIB8mLkOwQXOvKRqBY=\n-----END PRIVATE KEY-----\n",
      "client_email": "healing-match@appspot.gserviceaccount.com",
      "client_id": "109325874687014297008",
      "type": "service_account"
    });
    final httpClient =
        await clientViaServiceAccount(accountCredentials, _scopes);
    var calendar = CalendarApi(httpClient);
    var calEvents = calendar.events.list(
      "sugyo.sumihiko@gmail.com",
      q: "SP${HealingMatchConstants.userId}",
      singleEvents: true,
      timeMin: startTime.toUtc(),
      timeMax: endTime.toUtc(),
      //  timeZone: "GMT+05:30"
    );
    try {
      Events events = await calEvents;
      List<Event> unavailableEvents = List<Event>();
      events.items.forEach((event) {
        // {events.items.forEach((event) => print("EVENT ${event.summary}"))});
        if (event.description == "unavailable") {
          unavailableEvents.add(event);
        } else if (event.status == "confirmed") {
          flutterEvents.add(
            FlutterWeekViewEvent(
              events: event,
              start: event.start.dateTime.toLocal(),
              end: event.end.dateTime.toLocal(),
            ),
          );
        }
      });
      unavailableEvents
          .sort((a, b) => a.start.dateTime.compareTo(b.start.dateTime));
      for (var unavailableEvent in unavailableEvents) {
        if (unavailableCalendarEvents.length == 0) {
          unavailableCalendarEvents.add(
            FlutterWeekViewEvent(
              events: unavailableEvent,
              start: unavailableEvent.start.dateTime.toLocal(),
              end: unavailableEvent.end.dateTime.toLocal(),
            ),
          );
        } else if (unavailableCalendarEvents[
                    unavailableCalendarEvents.length - 1]
                .end ==
            unavailableEvent.start.dateTime.toLocal()) {
          unavailableCalendarEvents[unavailableCalendarEvents.length - 1].end =
              unavailableEvent.end.dateTime.toLocal();
        } else {
          unavailableCalendarEvents.add(
            FlutterWeekViewEvent(
              events: unavailableEvent,
              start: unavailableEvent.start.dateTime.toLocal(),
              end: unavailableEvent.end.dateTime.toLocal(),
            ),
          );
        }
      }
      if (HealingMatchConstants.numberOfEmployeeRegistered > 1) {
        flutterEvents.clear();
      }
      if (unavailableCalendarEvents.length != 0) {
        flutterEvents.addAll(unavailableCalendarEvents);
      }

      httpClient.close();
      return flutterEvents;
    } catch (e) {
      print("Calendar Event Check Exception: $e");
      return flutterEvents;
    }
  }

  //mark unavailable from xo calendar
  static Future<Event> createEvent(
      DateTime eventTime, BuildContext context) async {
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "private_key_id": "ea91c6540fdc102720f699c56f692d25d4aefeec",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC916/Vmhw+wpgw\nYjtvKWWnoVFJqz4sXXu5DRWaB9dSxWhIebQv0n+UdTRz8MT3ipOMz8Z4u9ziw2/J\n6tLJTU82iCk7afMEjSGypAK7osXZW5JvLkAohtamTPYSSKc7oeRfNLLCBZFHoVqQ\nvoQLnBTZbk8HSAwUBu4LFTGdSj226R7VoPeFFcdybA7tKNdM4nk/GTdnJUabTWXQ\nISRgD4ZK2SxJDlWqCkyZ1+6x/d6DEYvZX9QgGczMu8rkReNBpN+AOwZjUQ1sByhA\nhzlQXS+UX7KvJW4kfUCTvRDOr952M5J4aAvGpQzy9B3Hhm91fMsPSrdPtklDceJj\n62JfhVztAgMBAAECggEAGPleXtXCwHjeB4NsuS9zeY1twai+6Zw0sf/oJxa/+1oP\n4XTtQNtKwE944oW6i6wVxBDzVZ+1K7m1I5V6PFQoxw47il7iQueEFtmfqGp95521\n0l19wDcY1tDKEFaxdVVTUzj+CSstVQSDgwYlHdffIEl0KQuP1zSgLSIRIFWLb9vZ\ntpKl0VFrbB6W9NRIzcupHIFdhzvTbZPv/Kd0fHh49zL6oAxfFq8kzRci/jhld/Wz\n1oWlvOne1NSMiZWbltr/iI+YsNMcQdEudWPsw1Wvbnj8YEn9bdFUVb5IS0bc7XP9\n3G6TwHpJMZutSvtlqSIJF7PfvwZJQXeTr+G3EMcGywKBgQD3rUBd9o2ad7W8aKZv\nvErKr1TX9C1rZpadnabGPo5CGSx/tUzwUTpf6FxtTqgvjMhUw8HWGM0iJpf2B7Gc\nef+1w5mMaPz9WV9XeC2//0S9f0QGkPiXDEC9raud6uJQ41hYW6yJp7nrahZ9dFog\nnL0w5HEJ/eSWYwlijtOi+AUZiwKBgQDEOOQR3Bz9rUlrlMJf5s7LlO80TUq12s6U\nRqBmiUiwGBSioQ7gUdedlWjL1Ukh6KMLCvFgwbIEYDsZnL/Uzbb/Qkp3yGuEmyRm\na15iMWJ6TYNGxEw7+6nw7LsVwV528/DRyZQVyJHLPAYG3Zytfi2nRRXSeAS7qIQF\nNyweaG8CZwKBgHAdCr/99Udw3OE2dfCqSSjKiRtgOpcdTxx12qJuerLM9mmwxe0a\nt9PmOMB6FIPBtIU6P6oMe/7zfWIvRWTRjMDYk88NT0fXhuLvUbZRdOpai451XTHy\np/O0g7TuOBfpcXo9tTJyrCQ2V4veeVW93Z4eKlUdirXQitUEViS1JInVAoGAXkb3\nTZ10UG3x2L6gpXM/6JCmXXrFapq2podIiftr8S+guoKnox+veQdQUp8nhCNCMwwO\n7W4jGfcibivh/1zXj81J+kNRZWUlGBB+SK9xoVGcwWOPPUKtZBRZzxoZSQ3rpuAz\nRkQXyI4OVz4jCTiWtsd6tKT1oTRWOitIB1QmAgECgYEAw8Q6oLV4Iq4oKTYJpmha\nvPb4BH+df8lvv9hCGviFBk48ZsY4ImRDb//KlknDmiTgGlW+kLWOFY8+a8NhAMB+\nb/AdpUK2tuYg09RM66bneCBU6wCaSBvUMxZHt469tWboam1i74BCQpDdIDd0A1uL\nb7GwDGIB8mLkOwQXOvKRqBY=\n-----END PRIVATE KEY-----\n",
      "client_email": "healing-match@appspot.gserviceaccount.com",
      "client_id": "109325874687014297008",
      "type": "service_account"
    });
    final httpClient =
        await clientViaServiceAccount(accountCredentials, _scopes);

    var calendar = CalendarApi(httpClient);
    String calendarId = "sugyo.sumihiko@gmail.com";
    Event event = Event(); // Create object of event

    event.summary = "SP${HealingMatchConstants.userId}";
    event.description = "unavailable";
    event.location = "店舗,Thindal, Erode - 12";
    event.status = "confirmed";

    DateTime startTime = DateTime(eventTime.year, eventTime.month,
        eventTime.day, eventTime.hour, eventTime.minute, eventTime.second);

    EventDateTime start = new EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+05:30";
    event.start = start;

    DateTime endTime = startTime.add(Duration(minutes: 15));

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT+05:30";
    end.dateTime = endTime;
    event.end = end;

    try {
      Event addedEvent = await calendar.events.insert(event, calendarId);
      return addedEvent;
      /*  calendar.events.insert(event, calendarId).then((value) {
        print("ADDEDDD_________________${value.status}");
        return value;
        // ProgressDialogBuilder.hideCommonProgressDialog(context);
      }); */
    } catch (e) {
      log('Error creating event $e');
    }
  }

  static Future<bool> updateEvent(
      String eventID,
      bool isCancel,
      bool isPriceChanged,
      bool isDateChanged,
      BookingDetailsList bookingDetailsList) async {
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "private_key_id": "ea91c6540fdc102720f699c56f692d25d4aefeec",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC916/Vmhw+wpgw\nYjtvKWWnoVFJqz4sXXu5DRWaB9dSxWhIebQv0n+UdTRz8MT3ipOMz8Z4u9ziw2/J\n6tLJTU82iCk7afMEjSGypAK7osXZW5JvLkAohtamTPYSSKc7oeRfNLLCBZFHoVqQ\nvoQLnBTZbk8HSAwUBu4LFTGdSj226R7VoPeFFcdybA7tKNdM4nk/GTdnJUabTWXQ\nISRgD4ZK2SxJDlWqCkyZ1+6x/d6DEYvZX9QgGczMu8rkReNBpN+AOwZjUQ1sByhA\nhzlQXS+UX7KvJW4kfUCTvRDOr952M5J4aAvGpQzy9B3Hhm91fMsPSrdPtklDceJj\n62JfhVztAgMBAAECggEAGPleXtXCwHjeB4NsuS9zeY1twai+6Zw0sf/oJxa/+1oP\n4XTtQNtKwE944oW6i6wVxBDzVZ+1K7m1I5V6PFQoxw47il7iQueEFtmfqGp95521\n0l19wDcY1tDKEFaxdVVTUzj+CSstVQSDgwYlHdffIEl0KQuP1zSgLSIRIFWLb9vZ\ntpKl0VFrbB6W9NRIzcupHIFdhzvTbZPv/Kd0fHh49zL6oAxfFq8kzRci/jhld/Wz\n1oWlvOne1NSMiZWbltr/iI+YsNMcQdEudWPsw1Wvbnj8YEn9bdFUVb5IS0bc7XP9\n3G6TwHpJMZutSvtlqSIJF7PfvwZJQXeTr+G3EMcGywKBgQD3rUBd9o2ad7W8aKZv\nvErKr1TX9C1rZpadnabGPo5CGSx/tUzwUTpf6FxtTqgvjMhUw8HWGM0iJpf2B7Gc\nef+1w5mMaPz9WV9XeC2//0S9f0QGkPiXDEC9raud6uJQ41hYW6yJp7nrahZ9dFog\nnL0w5HEJ/eSWYwlijtOi+AUZiwKBgQDEOOQR3Bz9rUlrlMJf5s7LlO80TUq12s6U\nRqBmiUiwGBSioQ7gUdedlWjL1Ukh6KMLCvFgwbIEYDsZnL/Uzbb/Qkp3yGuEmyRm\na15iMWJ6TYNGxEw7+6nw7LsVwV528/DRyZQVyJHLPAYG3Zytfi2nRRXSeAS7qIQF\nNyweaG8CZwKBgHAdCr/99Udw3OE2dfCqSSjKiRtgOpcdTxx12qJuerLM9mmwxe0a\nt9PmOMB6FIPBtIU6P6oMe/7zfWIvRWTRjMDYk88NT0fXhuLvUbZRdOpai451XTHy\np/O0g7TuOBfpcXo9tTJyrCQ2V4veeVW93Z4eKlUdirXQitUEViS1JInVAoGAXkb3\nTZ10UG3x2L6gpXM/6JCmXXrFapq2podIiftr8S+guoKnox+veQdQUp8nhCNCMwwO\n7W4jGfcibivh/1zXj81J+kNRZWUlGBB+SK9xoVGcwWOPPUKtZBRZzxoZSQ3rpuAz\nRkQXyI4OVz4jCTiWtsd6tKT1oTRWOitIB1QmAgECgYEAw8Q6oLV4Iq4oKTYJpmha\nvPb4BH+df8lvv9hCGviFBk48ZsY4ImRDb//KlknDmiTgGlW+kLWOFY8+a8NhAMB+\nb/AdpUK2tuYg09RM66bneCBU6wCaSBvUMxZHt469tWboam1i74BCQpDdIDd0A1uL\nb7GwDGIB8mLkOwQXOvKRqBY=\n-----END PRIVATE KEY-----\n",
      "client_email": "healing-match@appspot.gserviceaccount.com",
      "client_id": "109325874687014297008",
      "type": "service_account"
    });
    final httpClient =
        await clientViaServiceAccount(accountCredentials, _scopes);

    var calendar = CalendarApi(httpClient);
    String calendarId = "sugyo.sumihiko@gmail.com";
    Event event = Event();

    event.status = isCancel ? "cancelled" : "confirmed";

    event.summary =
        "SP${bookingDetailsList.therapistId},${HealingMatchConstants.providerName},SU${bookingDetailsList.userId},${bookingDetailsList.bookingUserId.userName}(${bookingDetailsList.bookingUserId.gender})";
    event.description =
        "${bookingDetailsList.nameOfService},¥${bookingDetailsList.priceOfService + bookingDetailsList.travelAmount}";
    event.location =
        "${bookingDetailsList.locationType},${bookingDetailsList.location}";

    if (isDateChanged) {
      EventDateTime start = new EventDateTime();
      start.dateTime = bookingDetailsList.newStartTime;
      start.timeZone = "GMT+05:30";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+05:30";
      end.dateTime = bookingDetailsList.newEndTime;
      event.end = end;
    } else {
      EventDateTime start = new EventDateTime();
      start.dateTime = bookingDetailsList.startTime.toLocal();
      start.timeZone = "GMT+05:30";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+05:30";
      end.dateTime = bookingDetailsList.endTime.toLocal();
      event.end = end;
    }

    try {
      var eventValue = await calendar.events.update(event, calendarId, eventID);
      if (eventValue != null) {
        print("Updated event");
        return true;
      } else {
        return false;
      }

      /*  calendar.events.update(event, calendarId, eventID).then((value) {
        print("Updated event");
        return true;
      }); */
    } catch (e) {
      log('Error updating event $e');
      return false;
    }
  }

  static Future<bool> updateNotificationEvent(
      String eventID,
      bool isCancel,
      bool isPriceChanged,
      bool isDateChanged,
      NotificationList bookingDetailsList) async {
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "private_key_id": "ea91c6540fdc102720f699c56f692d25d4aefeec",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC916/Vmhw+wpgw\nYjtvKWWnoVFJqz4sXXu5DRWaB9dSxWhIebQv0n+UdTRz8MT3ipOMz8Z4u9ziw2/J\n6tLJTU82iCk7afMEjSGypAK7osXZW5JvLkAohtamTPYSSKc7oeRfNLLCBZFHoVqQ\nvoQLnBTZbk8HSAwUBu4LFTGdSj226R7VoPeFFcdybA7tKNdM4nk/GTdnJUabTWXQ\nISRgD4ZK2SxJDlWqCkyZ1+6x/d6DEYvZX9QgGczMu8rkReNBpN+AOwZjUQ1sByhA\nhzlQXS+UX7KvJW4kfUCTvRDOr952M5J4aAvGpQzy9B3Hhm91fMsPSrdPtklDceJj\n62JfhVztAgMBAAECggEAGPleXtXCwHjeB4NsuS9zeY1twai+6Zw0sf/oJxa/+1oP\n4XTtQNtKwE944oW6i6wVxBDzVZ+1K7m1I5V6PFQoxw47il7iQueEFtmfqGp95521\n0l19wDcY1tDKEFaxdVVTUzj+CSstVQSDgwYlHdffIEl0KQuP1zSgLSIRIFWLb9vZ\ntpKl0VFrbB6W9NRIzcupHIFdhzvTbZPv/Kd0fHh49zL6oAxfFq8kzRci/jhld/Wz\n1oWlvOne1NSMiZWbltr/iI+YsNMcQdEudWPsw1Wvbnj8YEn9bdFUVb5IS0bc7XP9\n3G6TwHpJMZutSvtlqSIJF7PfvwZJQXeTr+G3EMcGywKBgQD3rUBd9o2ad7W8aKZv\nvErKr1TX9C1rZpadnabGPo5CGSx/tUzwUTpf6FxtTqgvjMhUw8HWGM0iJpf2B7Gc\nef+1w5mMaPz9WV9XeC2//0S9f0QGkPiXDEC9raud6uJQ41hYW6yJp7nrahZ9dFog\nnL0w5HEJ/eSWYwlijtOi+AUZiwKBgQDEOOQR3Bz9rUlrlMJf5s7LlO80TUq12s6U\nRqBmiUiwGBSioQ7gUdedlWjL1Ukh6KMLCvFgwbIEYDsZnL/Uzbb/Qkp3yGuEmyRm\na15iMWJ6TYNGxEw7+6nw7LsVwV528/DRyZQVyJHLPAYG3Zytfi2nRRXSeAS7qIQF\nNyweaG8CZwKBgHAdCr/99Udw3OE2dfCqSSjKiRtgOpcdTxx12qJuerLM9mmwxe0a\nt9PmOMB6FIPBtIU6P6oMe/7zfWIvRWTRjMDYk88NT0fXhuLvUbZRdOpai451XTHy\np/O0g7TuOBfpcXo9tTJyrCQ2V4veeVW93Z4eKlUdirXQitUEViS1JInVAoGAXkb3\nTZ10UG3x2L6gpXM/6JCmXXrFapq2podIiftr8S+guoKnox+veQdQUp8nhCNCMwwO\n7W4jGfcibivh/1zXj81J+kNRZWUlGBB+SK9xoVGcwWOPPUKtZBRZzxoZSQ3rpuAz\nRkQXyI4OVz4jCTiWtsd6tKT1oTRWOitIB1QmAgECgYEAw8Q6oLV4Iq4oKTYJpmha\nvPb4BH+df8lvv9hCGviFBk48ZsY4ImRDb//KlknDmiTgGlW+kLWOFY8+a8NhAMB+\nb/AdpUK2tuYg09RM66bneCBU6wCaSBvUMxZHt469tWboam1i74BCQpDdIDd0A1uL\nb7GwDGIB8mLkOwQXOvKRqBY=\n-----END PRIVATE KEY-----\n",
      "client_email": "healing-match@appspot.gserviceaccount.com",
      "client_id": "109325874687014297008",
      "type": "service_account"
    });
    final httpClient =
        await clientViaServiceAccount(accountCredentials, _scopes);

    var calendar = CalendarApi(httpClient);
    String calendarId = "sugyo.sumihiko@gmail.com";
    Event event = Event();

    event.status = isCancel ? "cancelled" : "confirmed";

    event.summary =
        "SP${bookingDetailsList.bookingDetail.therapistId},${HealingMatchConstants.providerName},SU${bookingDetailsList.userId},${bookingDetailsList.bookingDetail.bookingUserId.userName}(${bookingDetailsList.bookingDetail.bookingUserId.gender})";
    event.description =
        "${bookingDetailsList.bookingDetail.nameOfService},¥${bookingDetailsList.bookingDetail.priceOfService + bookingDetailsList.bookingDetail.travelAmount}";
    event.location =
        "${bookingDetailsList.bookingDetail.locationType},${bookingDetailsList.bookingDetail.location}";

    if (isDateChanged) {
      EventDateTime start = new EventDateTime();
      start.dateTime = bookingDetailsList.bookingDetail.newStartTime;
      start.timeZone = "GMT+05:30";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+05:30";
      end.dateTime = bookingDetailsList.bookingDetail.newEndTime;
      event.end = end;
    } else {
      EventDateTime start = new EventDateTime();
      start.dateTime = bookingDetailsList.bookingDetail.startTime.toLocal();
      start.timeZone = "GMT+05:30";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+05:30";
      end.dateTime = bookingDetailsList.bookingDetail.endTime.toLocal();
      event.end = end;
    }

    try {
      var eventValue = await calendar.events.update(event, calendarId, eventID);
      if (eventValue != null) {
        print("Updated event");
        return true;
      } else {
        return false;
      }

      /*  calendar.events.update(event, calendarId, eventID).then((value) {
        print("Updated event");
        return true;
      }); */
    } catch (e) {
      log('Error creating event $e');
      return false;
    }
  }

  static Future<bool> removeEvent(String eventID, BuildContext context) async {
    var accountCredentials = ServiceAccountCredentials.fromJson({
      "private_key_id": "ea91c6540fdc102720f699c56f692d25d4aefeec",
      "private_key":
          "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQC916/Vmhw+wpgw\nYjtvKWWnoVFJqz4sXXu5DRWaB9dSxWhIebQv0n+UdTRz8MT3ipOMz8Z4u9ziw2/J\n6tLJTU82iCk7afMEjSGypAK7osXZW5JvLkAohtamTPYSSKc7oeRfNLLCBZFHoVqQ\nvoQLnBTZbk8HSAwUBu4LFTGdSj226R7VoPeFFcdybA7tKNdM4nk/GTdnJUabTWXQ\nISRgD4ZK2SxJDlWqCkyZ1+6x/d6DEYvZX9QgGczMu8rkReNBpN+AOwZjUQ1sByhA\nhzlQXS+UX7KvJW4kfUCTvRDOr952M5J4aAvGpQzy9B3Hhm91fMsPSrdPtklDceJj\n62JfhVztAgMBAAECggEAGPleXtXCwHjeB4NsuS9zeY1twai+6Zw0sf/oJxa/+1oP\n4XTtQNtKwE944oW6i6wVxBDzVZ+1K7m1I5V6PFQoxw47il7iQueEFtmfqGp95521\n0l19wDcY1tDKEFaxdVVTUzj+CSstVQSDgwYlHdffIEl0KQuP1zSgLSIRIFWLb9vZ\ntpKl0VFrbB6W9NRIzcupHIFdhzvTbZPv/Kd0fHh49zL6oAxfFq8kzRci/jhld/Wz\n1oWlvOne1NSMiZWbltr/iI+YsNMcQdEudWPsw1Wvbnj8YEn9bdFUVb5IS0bc7XP9\n3G6TwHpJMZutSvtlqSIJF7PfvwZJQXeTr+G3EMcGywKBgQD3rUBd9o2ad7W8aKZv\nvErKr1TX9C1rZpadnabGPo5CGSx/tUzwUTpf6FxtTqgvjMhUw8HWGM0iJpf2B7Gc\nef+1w5mMaPz9WV9XeC2//0S9f0QGkPiXDEC9raud6uJQ41hYW6yJp7nrahZ9dFog\nnL0w5HEJ/eSWYwlijtOi+AUZiwKBgQDEOOQR3Bz9rUlrlMJf5s7LlO80TUq12s6U\nRqBmiUiwGBSioQ7gUdedlWjL1Ukh6KMLCvFgwbIEYDsZnL/Uzbb/Qkp3yGuEmyRm\na15iMWJ6TYNGxEw7+6nw7LsVwV528/DRyZQVyJHLPAYG3Zytfi2nRRXSeAS7qIQF\nNyweaG8CZwKBgHAdCr/99Udw3OE2dfCqSSjKiRtgOpcdTxx12qJuerLM9mmwxe0a\nt9PmOMB6FIPBtIU6P6oMe/7zfWIvRWTRjMDYk88NT0fXhuLvUbZRdOpai451XTHy\np/O0g7TuOBfpcXo9tTJyrCQ2V4veeVW93Z4eKlUdirXQitUEViS1JInVAoGAXkb3\nTZ10UG3x2L6gpXM/6JCmXXrFapq2podIiftr8S+guoKnox+veQdQUp8nhCNCMwwO\n7W4jGfcibivh/1zXj81J+kNRZWUlGBB+SK9xoVGcwWOPPUKtZBRZzxoZSQ3rpuAz\nRkQXyI4OVz4jCTiWtsd6tKT1oTRWOitIB1QmAgECgYEAw8Q6oLV4Iq4oKTYJpmha\nvPb4BH+df8lvv9hCGviFBk48ZsY4ImRDb//KlknDmiTgGlW+kLWOFY8+a8NhAMB+\nb/AdpUK2tuYg09RM66bneCBU6wCaSBvUMxZHt469tWboam1i74BCQpDdIDd0A1uL\nb7GwDGIB8mLkOwQXOvKRqBY=\n-----END PRIVATE KEY-----\n",
      "client_email": "healing-match@appspot.gserviceaccount.com",
      "client_id": "109325874687014297008",
      "type": "service_account"
    });
    final httpClient =
        await clientViaServiceAccount(accountCredentials, _scopes);

    var calendar = CalendarApi(httpClient);
    String calendarId = "sugyo.sumihiko@gmail.com";

    try {
      var eventValue = await calendar.events.delete(calendarId, eventID);

      return true;

      /* calendar.events.delete(calendarId, eventID).then((value) {
        print("Removed______");
      }); */
    } catch (e) {
      print('Error creating event $e');
      ProgressDialogBuilder.hideCommonProgressDialog(context);
      return false;
    }
  }

  static Future<ProviderDetailsResponseModel> getProfitandRatingApi() async {
    //ProviderDetailsResponseModel therapistDetails;

    try {
      final url = HealingMatchConstants.THERAPIST_DETAILS_BY_ID;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapist_id": HealingMatchConstants.userId,
          }));
      if (response.statusCode == 200) {
        var therapistData = json.decode(response.body);
        ProviderDetailsResponseModel therapistDetails =
            ProviderDetailsResponseModel.fromJson(therapistData);
        print('a');
        HealingMatchConstants.therapistDetails =
            therapistDetails.data.storeServiceTimes;
        HealingMatchConstants.storeServiceTime =
            json.encode(therapistDetails.data.storeServiceTimes);
        return therapistDetails;
      } else {
        print('Error occurred!!! TypeMassages response');
        throw Exception();
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  static saveShiftServiceTime(
      List<StoreServiceTime> storeServiceTime, BuildContext context) async {
    try {
      final url = HealingMatchConstants.THERAPIST_SHIFT_TIME_SAVE;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      print(json.encode(storeServiceTime[0]));
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            //"storeServiceTime": json.encode(storeServiceTime)
            "monday": "[" + json.encode(storeServiceTime[0]) + "]",
            "tuesday": "[" + json.encode(storeServiceTime[1]) + "]",
            "wednesday": "[" + json.encode(storeServiceTime[2]) + "]",
            "thursday": "[" + json.encode(storeServiceTime[3]) + "]",
            "friday": "[" + json.encode(storeServiceTime[4]) + "]",
            "saturday": "[" + json.encode(storeServiceTime[5]) + "]",
            "sunday": "[" + json.encode(storeServiceTime[6]) + "]",
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        /*  shiftTimeUpdate.ShiftTimeUpdateResponse shiftTimeUpdateResponse =
            shiftTimeUpdate.ShiftTimeUpdateResponse.fromJson(data); */
        ProviderDetailsResponseModel therapistDetails =
            ProviderDetailsResponseModel.fromJson(data);
        HealingMatchConstants.therapistDetails.clear();
        HealingMatchConstants.therapistDetails =
            therapistDetails.data.storeServiceTimes;
        HealingMatchConstants.storeServiceTime =
            json.encode(therapistDetails.data.storeServiceTimes);
        ProgressDialogBuilder.hideCommonProgressDialog(context);
        /*  Navigator.pop(context);
        Navigator.pop(context); */
        NavigationRouter.switchToServiceProviderServiceTiming(context);
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }

  static Future<bool> saveFirebaseUserID(
      String firebaseID, BuildContext context) async {
    try {
      final url = HealingMatchConstants.FIREBASE_UPDATE_USERID;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "id": HealingMatchConstants.userId,
            "isTherapist": 1,
            "firebaseUDID": firebaseID
          }));
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

  static Future<TherapistBookingHistoryResponseModel> getBookingRequests(
      int pageNumber, int pageSize) async {
    TherapistBookingHistoryResponseModel therapistBookingHistoryResponseModel;
    try {
      final url = HealingMatchConstants.THERAPIST_BOOKING_REQUEST +
          "?page=$pageNumber&size=$pageSize";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapistId": HealingMatchConstants.userId,
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        therapistBookingHistoryResponseModel =
            TherapistBookingHistoryResponseModel.fromJson(data);
        return therapistBookingHistoryResponseModel;
      } else {
        return therapistBookingHistoryResponseModel;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return therapistBookingHistoryResponseModel;
    }
  }

  static Future<TherapistBookingHistoryResponseModel> getBookingApprovedDetails(
      int pageNumber, int pageSize) async {
    TherapistBookingHistoryResponseModel therapistBookingHistoryResponseModel;
    try {
      final url = HealingMatchConstants.THERAPIST_BOOKING_APPROVED +
          "?page=$pageNumber&size=$pageSize";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapistId": HealingMatchConstants.userId,
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        therapistBookingHistoryResponseModel =
            TherapistBookingHistoryResponseModel.fromJson(data);
        return therapistBookingHistoryResponseModel;
      } else {
        return therapistBookingHistoryResponseModel;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return therapistBookingHistoryResponseModel;
    }
  }

  static Future<TherapistBookingHistoryResponseModel>
      getConfirmedBookingDetails(int pageNumber, int pageSize) async {
    TherapistBookingHistoryResponseModel therapistBookingHistoryResponseModel;
    try {
      final url = HealingMatchConstants.THERAPIST_BOOKING_CONFIRMED +
          "?page=$pageNumber&size=$pageSize";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapistId": HealingMatchConstants.userId,
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        therapistBookingHistoryResponseModel =
            TherapistBookingHistoryResponseModel.fromJson(data);
        return therapistBookingHistoryResponseModel;
      } else {
        return therapistBookingHistoryResponseModel;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return therapistBookingHistoryResponseModel;
    }
  }

  static Future<TherapistBookingHistoryResponseModel> getCanceledBookingDetails(
      int pageNumber, int pageSize) async {
    TherapistBookingHistoryResponseModel therapistBookingHistoryResponseModel;
    try {
      final url = HealingMatchConstants.THERAPIST_CANCELLED_BOOKING +
          "?page=$pageNumber&size=$pageSize";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapistId": HealingMatchConstants.userId,
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        therapistBookingHistoryResponseModel =
            TherapistBookingHistoryResponseModel.fromJson(data);
        return therapistBookingHistoryResponseModel;
      } else {
        return therapistBookingHistoryResponseModel;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return therapistBookingHistoryResponseModel;
    }
  }

  static Future<bool> updateStatusUpdate(BookingDetailsList bookingDetail,
      bool isAddedPrice, bool isTimeChange, bool isCancel) async {
    try {
      final url = HealingMatchConstants.THERAPIST_BOOKING_STATUS_UPDATE;
      Map<String, dynamic> body;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      if (isCancel) {
        body = {
          "bookingId": bookingDetail.id.toString(),
          "cancellationReason": bookingDetail.cancellationReason,
          "bookingStatus": "4",
        };
      } else if (isAddedPrice && isTimeChange) {
        body = {
          "bookingId": bookingDetail.id.toString(),
          "bookingStatus": "2",
          "newStartTime": bookingDetail.newStartTime.toString(),
          "newEndTime": bookingDetail.newEndTime.toString(),
          "addedPrice": bookingDetail.addedPrice,
          "travelAmount": bookingDetail.travelAmount.toString(),
          "therapistComments": bookingDetail.therapistComments,
          "totalCost":
              bookingDetail.priceOfService + bookingDetail.travelAmount,
        };
      } else if (isAddedPrice) {
        body = {
          "bookingId": bookingDetail.id.toString(),
          "bookingStatus": "2",
          "addedPrice": bookingDetail.addedPrice,
          "travelAmount": bookingDetail.travelAmount.toString(),
          "therapistComments": bookingDetail.therapistComments,
          "totalCost":
              bookingDetail.priceOfService + bookingDetail.travelAmount,
        };
      } else if (isTimeChange) {
        body = {
          "bookingId": bookingDetail.id.toString(),
          "bookingStatus": "2",
          "newStartTime": bookingDetail.newStartTime.toString(),
          "newEndTime": bookingDetail.newEndTime.toString(),
          "therapistComments": bookingDetail.therapistComments,
        };
      } else {
        body = {
          "bookingId": bookingDetail.id.toString(),
          "bookingStatus": "1",
          "therapistComments": bookingDetail.therapistComments != null
              ? bookingDetail.therapistComments
              : '',
        };
      }

      final response =
          await http.post(url, headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return true;
    }
  }

  static Future<bool> updateStatusUpdateNotification(
      NotificationList bookingDetail,
      bool isAddedPrice,
      bool isTimeChange,
      bool isCancel) async {
    try {
      final url = HealingMatchConstants.THERAPIST_BOOKING_STATUS_UPDATE;
      Map<String, dynamic> body;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      if (isCancel) {
        body = {
          "bookingId": bookingDetail.bookingDetail.id.toString(),
          "cancellationReason": bookingDetail.bookingDetail.cancellationReason,
          "bookingStatus": "4",
        };
      } else if (isAddedPrice && isTimeChange) {
        body = {
          "bookingId": bookingDetail.bookingDetail.id.toString(),
          "bookingStatus": "2",
          "newStartTime": bookingDetail.bookingDetail.newStartTime.toString(),
          "newEndTime": bookingDetail.bookingDetail.newEndTime.toString(),
          "addedPrice": bookingDetail.bookingDetail.addedPrice,
          "travelAmount": bookingDetail.bookingDetail.travelAmount.toString(),
          "therapistComments": bookingDetail.bookingDetail.therapistComments,
          "totalCost": bookingDetail.bookingDetail.priceOfService +
              bookingDetail.bookingDetail.travelAmount,
        };
      } else if (isAddedPrice) {
        body = {
          "bookingId": bookingDetail.bookingDetail.id.toString(),
          "bookingStatus": "2",
          "addedPrice": bookingDetail.bookingDetail.addedPrice,
          "travelAmount": bookingDetail.bookingDetail.travelAmount.toString(),
          "therapistComments": bookingDetail.bookingDetail.therapistComments,
          "totalCost": bookingDetail.bookingDetail.priceOfService +
              bookingDetail.bookingDetail.travelAmount,
        };
      } else if (isTimeChange) {
        body = {
          "bookingId": bookingDetail.bookingDetail.id.toString(),
          "bookingStatus": "2",
          "newStartTime": bookingDetail.bookingDetail.newStartTime.toString(),
          "newEndTime": bookingDetail.bookingDetail.newEndTime.toString(),
          "therapistComments": bookingDetail.bookingDetail.therapistComments,
          "totalCost": bookingDetail.bookingDetail.priceOfService,
        };
      } else {
        body = {
          "bookingId": bookingDetail.bookingDetail.id.toString(),
          "bookingStatus": "1",
          "therapistComments":
              bookingDetail.bookingDetail.therapistComments != null
                  ? bookingDetail.bookingDetail.therapistComments
                  : '',
        };
      }

      final response =
          await http.post(url, headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return true;
    }
  }

  static Future<bool> updateBookingCompeted(
    BookingDetailsList bookingDetail,
  ) async {
    try {
      final url = HealingMatchConstants.THERAPIST_BOOKING_STATUS_UPDATE;
      Map<String, dynamic> body;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };

      body = {
        "bookingId": bookingDetail.id.toString(),
        "bookingStatus": "9",
      };

      final response =
          await http.post(url, headers: headers, body: json.encode(body));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return true;
    }
  }

  static Future<TherapistBookingHistoryResponseModel>
      getWeeklyBookingCardDetails(int pageNumber, int pageSize) async {
    TherapistBookingHistoryResponseModel therapistBookingHistoryResponseModel;
    try {
      final url = HealingMatchConstants.THERAPIST_WEEKLY_BOOKING +
          "?page=$pageNumber&size=$pageSize";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapistId": HealingMatchConstants.userId,
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        therapistBookingHistoryResponseModel =
            TherapistBookingHistoryResponseModel.fromJson(data);
        return therapistBookingHistoryResponseModel;
      } else {
        return therapistBookingHistoryResponseModel;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return therapistBookingHistoryResponseModel;
    }
  }

  static Future<FirebaseNotificationTherapistListModel>
      getProviderNotifications(int pageNumber, int pageSize) async {
    FirebaseNotificationTherapistListModel therapistBookingHistoryResponseModel;
    try {
      final url = HealingMatchConstants.PROVIDER_FIREBASE_NOTIFICATION_HISTORY +
          "?page=$pageNumber&size=$pageSize";
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.get(
        url,
        headers: headers,
      );
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        therapistBookingHistoryResponseModel =
            FirebaseNotificationTherapistListModel.fromJson(data);
        return therapistBookingHistoryResponseModel;
      } else {
        return therapistBookingHistoryResponseModel;
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      return therapistBookingHistoryResponseModel;
    }
  }

  static updateNotificationStatus(int notificationID) async {
    try {
      final url = HealingMatchConstants.UPDATE_FIREBASE_NOTIFICATION_READSTATUS;

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "notificationId": notificationID,
          }));
      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        /*  therapistBookingHistoryResponseModel =
            FirebaseNotificationTherapistListModel.fromJson(data);
        return therapistBookingHistoryResponseModel; */
      } else {
        /*  return therapistBookingHistoryResponseModel; */
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
      /* return therapistBookingHistoryResponseModel; */
    }
  }

  static Future<bool> logOutApi() async {
    try {
      final url = HealingMatchConstants.LOGOUT_API;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.get(
        url,
        headers: headers,
      );
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

  static Future<StripePayOutVerifyFieldsModel> getStripeRegisterURL(
      BuildContext context) async {
    ProgressDialogBuilder.showOverlayLoader(context);
    try {
      final url = '${HealingMatchConstants.STRIPE_ONBOARD_REGISTER_URL}';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "email": '${HealingMatchConstants.serviceProviderEmailAddress}',
            "refresh_url":
                'http://106.51.49.160:9094/api/user/returnpage', //returnpage
            "return_url": 'http://106.51.49.160:9094/api/user/successOnboard',
            "userId": '${HealingMatchConstants.userId}'
          }));
      final getTherapists = json.decode(response.body);
      print('More Response body : ${response.body}');
      _stripePayoutModel =
          StripePayOutVerifyFieldsModel.fromJson(getTherapists);
      print('Model objects Response body : ${_stripePayoutModel.toJson()}');
      if (response.statusCode == 200) {
        HealingMatchConstants.stripeRedirectURL =
            _stripePayoutModel.message.url;
        print('Entering.. : ${HealingMatchConstants.stripeRedirectURL}');
        ProgressDialogBuilder.hideLoader(context);
      }
    } catch (e) {
      print('Stripe redirect URL exception : ${e.toString()}');
      ProgressDialogBuilder.hideLoader(context);
    }

    return _stripePayoutModel;
  }

  //_therapistDetailsModel

  static Future<TherapistDetailsModel> getTherapistDetails(
      BuildContext context) async {
    ProgressDialogBuilder.showOverlayLoader(context);
    try {
      final url = '${HealingMatchConstants.GET_THERAPIST_DETAILS_URL}';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapistId": '${HealingMatchConstants.userId}'
          })); //'${HealingMatchConstants.userId}'}
      final getTherapists = json.decode(response.body);
      _therapistDetailsModel = TherapistDetailsModel.fromJson(getTherapists);
      print('More Response body : ${response.body}');
      if (response.statusCode == 200) {
        HealingMatchConstants.isStripeVerified =
            _therapistDetailsModel.data.isStripeVerified;
        ProgressDialogBuilder.hideLoader(context);
      } else {
        ProgressDialogBuilder.hideLoader(context);
      }
    } catch (e) {
      print('Stripe redirect URL exception : ${e.toString()}');
      ProgressDialogBuilder.hideLoader(context);
    }

    return _therapistDetailsModel;
  }
}
