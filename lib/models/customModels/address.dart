// To parse this JSON data, do
//
//     final updateAddress = updateAddressFromJson(jsonString);

import 'dart:convert';

List<UpdateAddress> updateAddressFromJson(String str) =>
    List<UpdateAddress>.from(
        json.decode(str).map((x) => UpdateAddress.fromJson(x)));

String updateAddressToJson(List<UpdateAddress> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UpdateAddress {
  UpdateAddress({
    this.id,
    this.userId,
    this.addressTypeSelection,
    this.address,
    this.userRoomNumber,
    this.userPlaceForMassage,
    this.cityName,
    this.citiesId,
    this.area,
    this.buildingName,
    this.postalCode,
    this.lat,
    this.lon,
  });

  String id;
  String userId;
  String addressTypeSelection;
  String address;
  String userRoomNumber;
  String userPlaceForMassage;
  String cityName;
  String citiesId;
  String area;
  String buildingName;
  String postalCode;
  double lat;
  double lon;

  factory UpdateAddress.fromJson(Map<String, dynamic> json) => UpdateAddress(
        id: json["id"],
        userId: json["userId"],
        addressTypeSelection: json["addressTypeSelection"],
        address: json["address"],
        userRoomNumber: json["userRoomNumber"],
        userPlaceForMassage: json["userPlaceForMassage"],
        cityName: json["cityName"],
        citiesId: json["citiesId"],
        area: json["area"],
        buildingName: json["buildingName"],
        postalCode: json["postalCode"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "addressTypeSelection": addressTypeSelection,
        "address": address,
        "userRoomNumber": userRoomNumber,
        "userPlaceForMassage": userPlaceForMassage,
        "cityName": cityName,
        "citiesId": citiesId,
        "area": area,
        "buildingName": buildingName,
        "postalCode": postalCode,
        "lat": lat,
        "lon": lon,
      };
}
