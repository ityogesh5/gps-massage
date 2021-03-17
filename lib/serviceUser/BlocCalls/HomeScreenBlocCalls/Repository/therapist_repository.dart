import 'dart:convert';

import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:http/http.dart' as http;

abstract class GetTherapistUsersRepository {
  String accessToken = HealingMatchConstants.accessToken;

  Future<List<TherapistDatum>> getTherapistUsersProfiles(String accessToken);
}

class GetTherapistUsersRepositoryImpl implements GetTherapistUsersRepository {
  @override
  String accessToken;

  @override
  Future<List<TherapistDatum>> getTherapistUsersProfiles(
      String accessToken) async {
    try {
      final url = HealingMatchConstants.THERAPIST_LIST_URL;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '$accessToken'
      };
      final response = await http.post(url, headers: headers);
      if (response.statusCode == 200) {
        var therapistData = json.decode(response.body);
        List<TherapistDatum> therapistUsers =
            TherapistUsersModel.fromJson(therapistData).therapistData;

        print('Users list:  $therapistData');
        return therapistUsers;
      } else {
        print('Error occurred!!! Users response');
        throw Exception();
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }
}
