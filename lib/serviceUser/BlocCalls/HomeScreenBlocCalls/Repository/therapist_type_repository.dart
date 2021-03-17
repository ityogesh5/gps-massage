import 'dart:convert';

import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistUsersModel.dart';
import 'package:http/http.dart' as http;

abstract class GetTherapistTypeRepository {
  String accessToken = HealingMatchConstants.accessToken;
  String massageTypeValue = HealingMatchConstants.serviceTypeValue.toString();

  Future<List<UserList>> getTherapistProfilesByType(
      String accessToken, String massageTypeValue);
}

class GetTherapistTypeRepositoryImpl implements GetTherapistTypeRepository {
  @override
  String accessToken;

  @override
  Future<List<UserList>> getTherapistProfilesByType(
      String accessToken, String massageTypeValue) async {
    try {
      final url = HealingMatchConstants.THERAPIST_LIST_BY_TYPE;
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '$accessToken'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "type": massageTypeValue,
          }));
      print('Therapist repo token : $accessToken : Massage type : $massageTypeValue');
      if (response.statusCode == 200) {
        var therapistData = json.decode(response.body);
        List<UserList> therapistUsers =
            TherapistsByTypeModel.fromJson(therapistData)
                .therapistData
                .userList;
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
  String massageTypeValue;
}
