// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) =>
    LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) =>
    json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.accessToken,
    this.data,
  });

  String status;
  String accessToken;
  Data data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        status: json["status"],
        accessToken: json["accessToken"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "accessToken": accessToken,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.id,
    this.email,
    this.phoneNumber,
    this.userName,
    this.gender,
    this.dob,
    this.age,
    this.isTherapist,
    this.isVerified,
    this.userOccupation,
    this.uploadProfileImgUrl,
    this.userSearchRadiusDistance,
    this.addresses,
  });

  int id;
  String email;
  int phoneNumber;
  String userName;
  String gender;
  DateTime dob;
  int age;
  bool isTherapist;
  bool isVerified;
  String userOccupation;
  dynamic uploadProfileImgUrl;
  dynamic userSearchRadiusDistance;
  List<Address> addresses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        userName: json["userName"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        age: json["age"],
        isTherapist: json["isTherapist"],
        isVerified: json["isVerified"],
        userOccupation: json["userOccupation"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        userSearchRadiusDistance: json["userSearchRadiusDistance"],
        addresses: List<Address>.from(
            json["addresses"].map((x) => Address.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "phoneNumber": phoneNumber,
        "userName": userName,
        "gender": gender,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "age": age,
        "isTherapist": isTherapist,
        "isVerified": isVerified,
        "userOccupation": userOccupation,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "userSearchRadiusDistance": userSearchRadiusDistance,
        "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
      };
}

class Address {
  Address({
    this.id,
    this.userId,
    this.addressTypeSelection,
    this.address,
    this.userRoomNumber,
    this.userPlaceForMassage,
    this.otherAddressType,
    this.capitalAndPrefecture,
    this.capitalAndPrefectureId,
    this.cityName,
    this.citiesId,
    this.area,
    this.buildingName,
    this.postalCode,
    this.lat,
    this.lon,
    this.userSearchRadiusDistance,
    this.createdUser,
    this.updatedUser,
    this.isDefault,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String addressTypeSelection;
  String address;
  String userRoomNumber;
  String userPlaceForMassage;
  dynamic otherAddressType;
  String capitalAndPrefecture;
  dynamic capitalAndPrefectureId;
  String cityName;
  dynamic citiesId;
  String area;
  String buildingName;
  dynamic postalCode;
  double lat;
  dynamic lon;
  dynamic userSearchRadiusDistance;
  String createdUser;
  String updatedUser;
  bool isDefault;
  DateTime createdAt;
  DateTime updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json["id"],
        userId: json["userId"],
        addressTypeSelection: json["addressTypeSelection"],
        address: json["address"],
        userRoomNumber:
            json["userRoomNumber"] == null ? null : json["userRoomNumber"],
        userPlaceForMassage: json["userPlaceForMassage"] == null
            ? null
            : json["userPlaceForMassage"],
        otherAddressType: json["otherAddressType"],
        capitalAndPrefecture: json["capitalAndPrefecture"],
        capitalAndPrefectureId: json["capitalAndPrefectureId"],
        cityName: json["cityName"],
        citiesId: json["citiesId"],
        area: json["area"] == null ? null : json["area"],
        buildingName:
            json["buildingName"] == null ? null : json["buildingName"],
        postalCode: json["postalCode"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        lon: json["lon"],
        userSearchRadiusDistance: json["userSearchRadiusDistance"],
        createdUser: json["createdUser"] == null ? null : json["createdUser"],
        updatedUser: json["updatedUser"] == null ? null : json["updatedUser"],
        isDefault: json["isDefault"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userId": userId,
        "addressTypeSelection": addressTypeSelection,
        "address": address,
        "userRoomNumber": userRoomNumber == null ? null : userRoomNumber,
        "userPlaceForMassage":
            userPlaceForMassage == null ? null : userPlaceForMassage,
        "otherAddressType": otherAddressType,
        "capitalAndPrefecture": capitalAndPrefecture,
        "capitalAndPrefectureId": capitalAndPrefectureId,
        "cityName": cityName,
        "citiesId": citiesId,
        "area": area == null ? null : area,
        "buildingName": buildingName == null ? null : buildingName,
        "postalCode": postalCode,
        "lat": lat == null ? null : lat,
        "lon": lon,
        "userSearchRadiusDistance": userSearchRadiusDistance,
        "createdUser": createdUser == null ? null : createdUser,
        "updatedUser": updatedUser == null ? null : updatedUser,
        "isDefault": isDefault,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
