import 'dart:convert';

import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceProvider/userReviewandRatingsResponseModel.dart';
import 'package:http/http.dart' as http;

abstract class GetUserReviewRepository {
  String accessToken = HealingMatchConstants.accessToken;
  int userId = HealingMatchConstants.serviceUserId;

  Future<List<UserReviewList>> getUserReviewById(
      String accessToken, int userId, int pageNumber, int pageSize);
}

class GetUserReviewRepositoryImpl implements GetUserReviewRepository {
  @override
  String accessToken;

  @override
  Future<List<UserReviewList>> getUserReviewById(
      String accessToken, int userId, int pageNumber, int pageSize) async {
    try {
      final url =
          'http://106.51.49.160:9094/api/review/userReviewMobileListbyId?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '$accessToken'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "userId": userId,
          }));
      print('Therapist repo token : $accessToken : UserId  : $userId');
      if (response.statusCode == 200) {
        var userData = json.decode(response.body);
        List<UserReviewList> usersReview =
            UserReviewandRatingsViewResponseModel.fromJson(userData)
                .userData
                .userReviewList;
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

  @override
  int userId;
}
