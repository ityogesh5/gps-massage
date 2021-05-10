import 'dart:convert';

import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/RecommendTherapistModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';

import 'package:gps_massageapp/models/responseModels/serviceUser/userDetails/GetTherapistDetails.dart';
import 'package:http/http.dart' as http;

abstract class GetTherapistTypeRepository {
  String accessToken = HealingMatchConstants.accessToken;
  int massageTypeValue = HealingMatchConstants.serviceTypeValue;
  var pageNumber = 1;
  var pageSize = 10;

  Future<List<TypeTherapistData>> getTherapistProfilesByType(
      String accessToken, int massageTypeValue, int pageNumber, int pageSize);

  Future<List<InitialTherapistData>> getTherapistProfiles(
      String accessToken, int pageNumber, int pageSize);

  Future<TherapistByIdModel> getTherapistById(String accessToken, int userId);

  Future<List<RecommendTherapistList>> getRecommendedTherapists(
      String accessToken, int pageNumber, int pageSize);
}

class GetTherapistTypeRepositoryImpl implements GetTherapistTypeRepository {
  @override
  String accessToken;

  @override
  Future<List<TypeTherapistData>> getTherapistProfilesByType(String accessToken,
      int massageTypeValue, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.THERAPIST_LIST_BY_TYPE}?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '$accessToken'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "type": massageTypeValue.toString(),
          }));
      print(
          'Therapist request : ${response.request} : Massage type : $massageTypeValue');
      if (response.statusCode == 200) {
        var therapistData = json.decode(response.body);
        List<TypeTherapistData> therapistUsers =
            TherapistsByTypeModel.fromJson(therapistData)
                .homeTherapistData
                .typeTherapistData;
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

  @override
  int massageTypeValue;

  @override
  Future<List<InitialTherapistData>> getTherapistProfiles(
      String accessToken, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.THERAPIST_LIST_URL}?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.get(url, headers: headers);
      final getTherapists = json.decode(response.body);
      List<InitialTherapistData> getTherapistUsers =
          TherapistUsersModel.fromJson(getTherapists)
              .homeTherapistData
              .therapistData;
      print('More Response body : ${response.body}');
      return getTherapistUsers;
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  int pageNumber;

  @override
  int pageSize;

  @override
  Future<TherapistByIdModel> getTherapistById(
      String accessToken, var userId) async {
    try {
      final url = HealingMatchConstants.THERAPIST_USER_BY_ID_URL;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '$accessToken'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "therapist_id": userId,
          }));
      if (response.statusCode == 200) {
        var therpistDataById = json.decode(response.body);
        TherapistByIdModel getTherapistByIdModel =
            TherapistByIdModel.fromJson(therpistDataById);
        print('TherapistById : ${response.body}');
        return getTherapistByIdModel;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<List<RecommendTherapistList>> getRecommendedTherapists(
      String accessToken, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.RECOMMENDED_THERAPISTS_LIST}?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '$accessToken'
      };
      final response = await http.get(url, headers: headers);
      if (response.statusCode == 200) {
        final recommendedTherapists = json.decode(response.body);
        List<RecommendTherapistList> getRecommendedTherapists =
            RecommendedTherapistModel.fromJson(recommendedTherapists)
                .homeTherapistData
                .recommendedTherapistData;
        print('RecommendedTherapistData : ${response.body}');
        return getRecommendedTherapists;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
