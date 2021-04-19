import 'dart:convert';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewandRatingsResponseModel.dart';
import 'package:http/http.dart' as http;
import 'package:gps_massageapp/models/responseModels/serviceProvider/providerReviewandRatingsViewResponseModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewCreateResponseModel.dart';

class ServiceProviderApi {
  static Future<ProviderReviewandRatingsViewResponseModel>
      getTherapistReviewById(int pageNumber, int pageSize) async {
    try {
      final url =
          'http://103.92.19.158:9094/api/mobileReview/therapistReviewListById'; //?page=$pageNumber&size=$pageSize';
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
      final url =
          'http://103.92.19.158:9094/api/mobileReview/userReviewListById';
      // 'http://106.51.49.160:9094/api/review/userReviewMobileListbyId'; //?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "userId": '20', //HealingMatchConstants.serviceUserId,
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
      double rating, String review) async {
    try {
      final url =
          'http://103.92.19.158:9094/api/mobileReview/createUserReview'; /* 'http://106.51.49.160:9094/api/review/createUserReview'; */
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "userId": '20', //HealingMatchConstants.serviceUserId,
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
}
