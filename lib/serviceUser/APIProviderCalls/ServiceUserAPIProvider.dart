import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/UserBannerImagesModel.dart';
import 'package:http/http.dart' as http;

class ServiceUserAPIProvider {
  static Response response;
  static TherapistUsersModel listOfTherapistModel = new TherapistUsersModel();
  static UserBannerImagesModel _bannerModel = new UserBannerImagesModel();

  // get all therapist users
  static Future<TherapistUsersModel> getAllTherapistUsers() async {
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
    }
    /*return (response.data).map((therapistUsers) {
      print('Inserting >>> $therapistUsers');
      //DBProvider.db.createTherapistUsers(therapistUsers);
    }).toList();*/
    return listOfTherapistModel;
  }

  // get limit of therapist users
  static Future<TherapistUsersModel> getAllTherapistsByLimit(
      int pageNumber, int sizeLimit) async {
    try {
      final url =
          'http://106.51.49.160:9094/api/user/therapistUserList?page=$pageNumber&size=$sizeLimit';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url, headers: headers);
      final getTherapists = json.decode(response.body);
      listOfTherapistModel = TherapistUsersModel.fromJson(getTherapists);
      print('More Response body : ${response.body}');
    } catch (e) {
      print(e.toString());
    }
    /*return (response.data).map((therapistUsers) {
      print('Inserting >>> $therapistUsers');
      //DBProvider.db.createTherapistUsers(therapistUsers);
    }).toList();*/
    return listOfTherapistModel;
  }

  // get more of therapist users
  static Future<TherapistUsersModel> getMoreTherapistsByLimit(
      int pageNumber, int sizeLimit) async {
    try {
      final url =
          'http://106.51.49.160:9094/api/user/therapistUserList?page=$pageNumber&size=$sizeLimit';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.post(url, headers: headers);
      final getTherapists = json.decode(response.body);
      listOfTherapistModel = TherapistUsersModel.fromJson(getTherapists);
      print('More Response body : ${response.body}');
    } catch (e) {
      print(e.toString());
    }
    /*return (response.data).map((therapistUsers) {
      print('Inserting >>> $therapistUsers');
      //DBProvider.db.createTherapistUsers(therapistUsers);
    }).toList();*/
    return listOfTherapistModel;
  }

  // get home screen user banner images
  static Future<UserBannerImagesModel> getAllBannerImages() async {
    try {
      final url = HealingMatchConstants.BANNER_IMAGES_URL;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '${HealingMatchConstants.accessToken}'
      };
      final response = await http.get(url, headers: headers);
      final getBannerImages = json.decode(response.body);
      print('Banner Response body : ${response.body}');
      _bannerModel = UserBannerImagesModel.fromJson(getBannerImages);
    } catch (e) {
      print('Banner Exception caught : ${e.toString()}');
      throw Exception(e);
    }
    return _bannerModel;
  }
}
