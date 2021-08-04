import 'dart:convert';

import 'package:gps_massageapp/constantUtils/constantsUtils.dart';
import 'package:gps_massageapp/models/responseModels/serviceUser/searchModels/SearchTherapistResultsModel.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

abstract class GetSearchResultsRepository {
  Future<List<SearchList>> getSearchResultsByType(int pageNumber, int pageSize);

  Future<List<SearchList>> getSearchResultsBySortType(
      int pageNumber, int pageSize, int searchType);
}

class GetSearchResultsRepositoryImpl implements GetSearchResultsRepository {
  @override
  Future<List<SearchList>> getSearchResultsByType(
      int pageNumber, int pageSize) async {
    List<SearchList> searchResults;
    String dateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(HealingMatchConstants.dateTime);
    try {
      final url =
          '${HealingMatchConstants.FETCH_THERAPIST_SEARCH_RESULTS}?page=$pageNumber&size=$pageSize';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: HealingMatchConstants.searchType == 1
              ? json.encode({
                  "keyword": HealingMatchConstants.searchKeyWordValue,
                  "latitude": HealingMatchConstants.searchAddressLatitude,
                  "longitude": HealingMatchConstants.searchAddressLongitude,
                })
              : HealingMatchConstants.serviceType != 0
                  ? json.encode({
                      "userAddress": HealingMatchConstants.searchUserAddress,
                      "serviceType": HealingMatchConstants.serviceType,
                      "serviceLocationCriteria":
                          HealingMatchConstants.isLocationCriteria,
                      "serviceTimeCriteria":
                          HealingMatchConstants.isTimeCriteria,
                      "selectedTime": dateTime,
                      "searchDistanceRadius":
                          HealingMatchConstants.searchDistanceRadius,
                      "latitude": HealingMatchConstants.searchAddressLatitude,
                      "longitude": HealingMatchConstants.searchAddressLongitude,
                    })
                  : json.encode({
                      "userAddress": HealingMatchConstants.searchUserAddress,
                      "serviceLocationCriteria":
                          HealingMatchConstants.isLocationCriteria,
                      "serviceTimeCriteria":
                          HealingMatchConstants.isTimeCriteria,
                      "selectedTime": dateTime,
                      "searchDistanceRadius":
                          HealingMatchConstants.searchDistanceRadius,
                      "latitude": HealingMatchConstants.searchAddressLatitude,
                      "longitude": HealingMatchConstants.searchAddressLongitude,
                    }));
      print('Search results Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        var searchResultData = json.decode(response.body);
        searchResults = SearchTherapistResultsModel.fromJson(searchResultData)
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
    return searchResults;
  }

  @override
  Future<List<SearchList>> getSearchResultsBySortType(
      int pageNumber, int pageSize, int searchType) async {
    List<SearchList> searchResults;
    String dateTime = DateFormat('yyyy-MM-dd HH:mm:ss')
        .format(HealingMatchConstants.dateTime);
    try {
      final url =
          '${HealingMatchConstants.FETCH_THERAPIST_SEARCH_RESULTS}?page=$pageNumber&size=$pageSize';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: HealingMatchConstants.searchType == 1
              ? json.encode({
                  "keyword": HealingMatchConstants.searchKeyWordValue,
                  "latitude": HealingMatchConstants.searchAddressLatitude,
                  "longitude": HealingMatchConstants.searchAddressLongitude,
                  "type": searchType
                })
              : HealingMatchConstants.serviceType != 0
                  ? json.encode({
                      "userAddress": HealingMatchConstants.searchUserAddress,
                      "serviceType": HealingMatchConstants.serviceType,
                      "serviceLocationCriteria":
                          HealingMatchConstants.isLocationCriteria,
                      "serviceTimeCriteria":
                          HealingMatchConstants.isTimeCriteria,
                      "selectedTime": dateTime,
                      "searchDistanceRadius":
                          HealingMatchConstants.searchDistanceRadius,
                      "latitude": HealingMatchConstants.searchAddressLatitude,
                      "longitude": HealingMatchConstants.searchAddressLongitude,
                      "type": searchType
                    })
                  : json.encode({
                      "userAddress": HealingMatchConstants.searchUserAddress,
                      "serviceLocationCriteria":
                          HealingMatchConstants.isLocationCriteria,
                      "serviceTimeCriteria":
                          HealingMatchConstants.isTimeCriteria,
                      "selectedTime": dateTime,
                      "searchDistanceRadius":
                          HealingMatchConstants.searchDistanceRadius,
                      "latitude": HealingMatchConstants.searchAddressLatitude,
                      "longitude": HealingMatchConstants.searchAddressLongitude,
                      "type": searchType
                    }));
      print('Search results Type Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        var searchResultData = json.decode(response.body);
        searchResults = SearchTherapistResultsModel.fromJson(searchResultData)
            .data
            .searchList;
        print('Search Type Results list:  $searchResults');
      } else {
        print('Error occurred!!! Search type response');
        throw Exception();
      }
    } catch (e) {
      print('Search type exception : ${e.toString()}');
    }
    return searchResults;
  }

/*  @override
  Future<List<SearchTherapistTypeList>> getSearchResultsBySortType(
      int pageNumber, int pageSize, int searchType) async {
    List<SearchTherapistTypeList> searchResults;
    try {
      final url =
          '${HealingMatchConstants.FETCH_SORTED_THERAPIST_SEARCH_RESULTS}?page=$pageNumber&size=$pageSize';
      final response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "x-access-token": HealingMatchConstants.accessToken
          },
          body: json.encode({
            "type": searchType,
          }));
      print('Search results Type Body : ${response.body}');
      print('statusCode : ${response.statusCode}');
      if (response.statusCode == 200) {
        var searchResultData = json.decode(response.body);
        searchResults = SearchTherapistByTypeModel.fromJson(searchResultData)
            .data
            .searchList;
        print('Search Type Results list:  $searchResults');
      } else {
        print('Error occurred!!! Search type response');
        throw Exception();
      }
    } catch (e) {
      print('Search type exception : ${e.toString()}');
    }
    return searchResults;
  } */
}
