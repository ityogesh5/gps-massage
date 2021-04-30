// To parse this JSON data, do
//
//     final editUserSubAddressModel = editUserSubAddressModelFromJson(jsonString);

import 'dart:convert';

EditUserSubAddressModel editUserSubAddressModelFromJson(String str) =>
    EditUserSubAddressModel.fromJson(json.decode(str));

String editUserSubAddressModelToJson(EditUserSubAddressModel data) =>
    json.encode(data.toJson());

class EditUserSubAddressModel {
  EditUserSubAddressModel({
    this.status,
    this.subAddress,
  });

  String status;
  SubAddress subAddress;

  factory EditUserSubAddressModel.fromJson(Map<String, dynamic> json) =>
      EditUserSubAddressModel(
        status: json["status"],
        subAddress: SubAddress.fromJson(json["subAddress"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "subAddress": subAddress.toJson(),
      };
}

class SubAddress {
  SubAddress({
    this.id,
    this.userId,
    this.addressTypeSelection,
    this.address,
    this.userRoomNumber,
    this.userPlaceForMassage,
    this.otherAddressType,
    this.capitalAndPrefecture,
    this.cityName,
    this.area,
    this.buildingName,
    this.geomet,
    this.lat,
    this.lon,
    this.isDefault,
  });

  int id;
  int userId;
  String addressTypeSelection;
  String address;
  String userRoomNumber;
  String userPlaceForMassage;
  dynamic otherAddressType;
  String capitalAndPrefecture;
  String cityName;
  String area;
  dynamic buildingName;
  Geomet geomet;
  double lat;
  double lon;
  bool isDefault;

  factory SubAddress.fromJson(Map<String, dynamic> json) => SubAddress(
        id: json["id"],
        userId: json["userId"],
        addressTypeSelection: json["addressTypeSelection"],
        address: json["address"],
        userRoomNumber: json["userRoomNumber"],
        userPlaceForMassage: json["userPlaceForMassage"],
        otherAddressType: json["otherAddressType"],
        capitalAndPrefecture: json["capitalAndPrefecture"],
        cityName: json["cityName"],
        area: json["area"],
        buildingName: json["buildingName"],
        geomet: Geomet.fromJson(json["geomet"]),
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        isDefault: json["isDefault"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "addressTypeSelection": addressTypeSelection,
        "address": address,
        "userRoomNumber": userRoomNumber,
        "userPlaceForMassage": userPlaceForMassage,
        "otherAddressType": otherAddressType,
        "capitalAndPrefecture": capitalAndPrefecture,
        "cityName": cityName,
        "area": area,
        "buildingName": buildingName,
        "geomet": geomet.toJson(),
        "lat": lat,
        "lon": lon,
        "isDefault": isDefault,
      };
}

class Geomet {
  Geomet({
    this.type,
    this.coordinates,
  });

  String type;
  List<double> coordinates;

  factory Geomet.fromJson(Map<String, dynamic> json) => Geomet(
        type: json["type"],
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
      };
}
