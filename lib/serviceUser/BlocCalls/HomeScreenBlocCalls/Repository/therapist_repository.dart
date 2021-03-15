import 'dart:convert';

import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListsModel.dart';
import 'package:http/http.dart' as http;

abstract class GetTherapistRepository {
  String accessToken = HealingMatchConstants.accessToken;

  Future<List<TherapistDatum>> getTherapistProfiles(String accessToken);
}

class GetTherapistRepositoryImpl implements GetTherapistRepository {
  @override
  String accessToken;

  @override
  Future<List<TherapistDatum>> getTherapistProfiles(String accessToken) async {
    try {
      final url = HealingMatchConstants.THERAPIST_LIST_URL;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '$accessToken'
      };
      final response = await http.post(url, headers: headers);
      print('Therapist repo token : $accessToken');
      if (response.statusCode == 200) {
        var therapistData = json.decode(response.body);
        List<TherapistDatum> therapistUsers =
            ListOfTherapistModel.fromJson(therapistData).therapistData;
        print(therapistData);
        return therapistUsers;
      } else {
        print('Error occurred!!! in response');
        throw Exception();
      }
    } catch (e) {
      print('Exception : ${e.toString()}');
    }
  }
}
