import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:http/http.dart' as http;

class ServiceUserAPIProvider {
  static Response response;
  static TherapistUsersModel listOfTherapistModel = new TherapistUsersModel();

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
}
