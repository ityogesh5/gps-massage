import 'dart:convert';

import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:http/http.dart' as http;

abstract class GetTherapistRepository {
  String accessToken = HealingMatchConstants.accessToken;
  String massageTypeValue = HealingMatchConstants.serviceTypeValue.toString();

  Future<List<UserList>> getTherapistProfiles(
      String accessToken, String massageTypeValue);
}

class GetTherapistRepositoryImpl implements GetTherapistRepository {
  @override
  String accessToken;

  @override
  Future<List<UserList>> getTherapistProfiles(
      String accessToken, String massageTypeValue) async {
    try {
      final url = HealingMatchConstants.THERAPIST_LIST_URL;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '$accessToken'
      };
      final response = await http.post(url, headers: headers,body: json.encode({
        "type": massageTypeValue,
      }));
      print('Therapist repo token : $accessToken : Massage type : $massageTypeValue');
      if (response.statusCode == 200) {
        var therapistData = json.decode(response.body);
        List<UserList> therapistUsers =
            TherapistsByTypeModel.fromJson(therapistData).therapistData.userList;
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

  @override
  String massageTypeValue;
}
