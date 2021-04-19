import 'dart:convert';

import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/homeScreen/TherapistListByTypeModel.dart';
import 'package:http/http.dart' as http;

abstract class GetSearchResultsRepository {
  String accessToken = HealingMatchConstants.accessToken;
  int massageTypeValue = HealingMatchConstants.serviceTypeValue;

  Future<List<UserTypeList>> getTherapistProfilesByType(
      String accessToken, int massageTypeValue, int pageNumber, int pageSize);
}

class GetSearchResultsRepositoryImpl implements GetSearchResultsRepository {
  @override
  String accessToken;

  @override
  Future<List<UserTypeList>> getTherapistProfilesByType(String accessToken,
      int massageTypeValue, int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.ON_PREMISE_USER_BASE_URL}/user/therapistListByType?page=$pageNumber&size=$pageSize';
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'x-access-token': '$accessToken'
      };
      final response = await http.post(url,
          headers: headers,
          body: json.encode({
            "type": massageTypeValue,
          }));
      print(
          'Therapist repo token : $accessToken : Massage type : $massageTypeValue');
      if (response.statusCode == 200) {
        var therapistData = json.decode(response.body);
        List<UserTypeList> therapistUsers =
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
  int massageTypeValue;
}
