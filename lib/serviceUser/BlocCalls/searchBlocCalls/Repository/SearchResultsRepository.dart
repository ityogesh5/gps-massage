import 'dart:convert';

import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/searchModels/SearchTherapistResultsModel.dart';
import 'package:http/http.dart' as http;

abstract class GetSearchResultsRepository {
  Future<List<SearchList>> getSearchResultsByType(int pageNumber, int pageSize);
}

class GetSearchResultsRepositoryImpl implements GetSearchResultsRepository {
  @override
  Future<List<SearchList>> getSearchResultsByType(
      int pageNumber, int pageSize) async {
    try {
      final url =
          '${HealingMatchConstants.FETCH_THERAPIST_SEARCH_RESULTS}?page=$pageNumber&size=$pageSize';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "searchKeyword": HealingMatchConstants.searchKeyWordValue,
            "userAddress": HealingMatchConstants.searchUserAddress,
            "serviceType": HealingMatchConstants.serviceType,
            "serviceLocationCriteria": HealingMatchConstants.isLocationCriteria,
            "serviceTimeCriteria": HealingMatchConstants.isTimeCriteria,
            "selectedTime": HealingMatchConstants.dateTime.toIso8601String(),
            "searchDistanceRadius": HealingMatchConstants.searchDistanceRadius,
            "latitude": HealingMatchConstants.searchAddressLatitude,
            "longitude": HealingMatchConstants.searchAddressLongitude,
          }));
      print('Search results Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        var searchResultData = json.decode(response.body);
        List<SearchList> searchResults =
            SearchTherapistResultsModel.fromJson(searchResultData)
                .data
                .searchList;
        print('Search Results list:  $searchResults');
        return searchResults;
      } else {
        print('Error occurred!!! Search Results response');
        throw Exception();
      }
    } catch (e) {
      print('Exception Search Results : ${e.toString()}');
    }
  }
}
