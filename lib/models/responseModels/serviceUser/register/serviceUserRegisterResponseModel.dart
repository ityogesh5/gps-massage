// To parse this JSON data, do
//
//     final serviceUserRegisterModel = serviceUserRegisterModelFromJson(jsonString);

import 'dart:convert';

ServiceUserRegisterModel serviceUserRegisterModelFromJson(String str) =>
    ServiceUserRegisterModel.fromJson(json.decode(str));

String serviceUserRegisterModelToJson(ServiceUserRegisterModel data) =>
    json.encode(data.toJson());

class ServiceUserRegisterModel {
  ServiceUserRegisterModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory ServiceUserRegisterModel.fromJson(Map<String, dynamic> json) =>
      ServiceUserRegisterModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    this.token,
    this.userResponse,
    this.addressResponse,
  });

  String token;
  UserResponse userResponse;
  AddressResponse addressResponse;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        userResponse: UserResponse.fromJson(json["userResponse"]),
        addressResponse: AddressResponse.fromJson(json["addressResponse"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "userResponse": userResponse.toJson(),
        "addressResponse": addressResponse.toJson(),
      };
}

class AddressResponse {
  AddressResponse({
    this.id,
    this.userPlaceForMassage,
    this.buildingName,
    this.area,
    this.userRoomNumber,
    this.address,
    this.cityName,
    this.capitalAndPrefecture,
    this.lat,
    this.lon,
    this.addressTypeSelection,
    this.userId,
    this.createdUser,
    this.updatedUser,
    this.updatedAt,
    this.createdAt,
  });

  int id;
  String userPlaceForMassage;
  String buildingName;
  String area;
  String userRoomNumber;
  String address;
  String cityName;
  String capitalAndPrefecture;
  String lat;
  String lon;
  String addressTypeSelection;
  int userId;
  String createdUser;
  String updatedUser;
  DateTime updatedAt;
  DateTime createdAt;

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        id: json["id"],
        userPlaceForMassage: json["userPlaceForMassage"],
        buildingName: json["buildingName"],
        area: json["area"],
        userRoomNumber: json["userRoomNumber"],
        address: json["address"],
        cityName: json["cityName"],
        capitalAndPrefecture: json["capitalAndPrefecture"],
        lat: json["lat"],
        lon: json["lon"],
        addressTypeSelection: json["addressTypeSelection"],
        userId: json["userId"],
        createdUser: json["createdUser"],
        updatedUser: json["updatedUser"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userPlaceForMassage": userPlaceForMassage,
        "buildingName": buildingName,
        "area": area,
        "userRoomNumber": userRoomNumber,
        "address": address,
        "cityName": cityName,
        "capitalAndPrefecture": capitalAndPrefecture,
        "lat": lat,
        "lon": lon,
        "addressTypeSelection": addressTypeSelection,
        "userId": userId,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}

class UserResponse {
  UserResponse({
    this.isVerified,
    this.coronaMeasure,
    this.id,
    this.userName,
    this.dob,
    this.age,
    this.userOccupation,
    this.phoneNumber,
    this.email,
    this.isTherapist,
    this.gender,
    this.isActive,
    this.isAccepted,
    this.uploadProfileImgUrl,
    this.userId,
    this.updatedAt,
    this.createdAt,
  });

  bool isVerified;
  bool coronaMeasure;
  int id;
  String userName;
  DateTime dob;
  String age;
  String userOccupation;
  String phoneNumber;
  String email;
  String isTherapist;
  String gender;
  bool isActive;
  bool isAccepted;
  String uploadProfileImgUrl;
  String userId;
  DateTime updatedAt;
  DateTime createdAt;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        isVerified: json["isVerified"],
        coronaMeasure: json["coronaMeasure"],
        id: json["id"],
        userName: json["userName"],
        dob: DateTime.parse(json["dob"]),
        age: json["age"],
        userOccupation: json["userOccupation"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        isTherapist: json["isTherapist"],
        gender: json["gender"],
        isActive: json["isActive"],
        isAccepted: json["isAccepted"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        userId: json["userId"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "isVerified": isVerified,
        "coronaMeasure": coronaMeasure,
        "id": id,
        "userName": userName,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "age": age,
        "userOccupation": userOccupation,
        "phoneNumber": phoneNumber,
        "email": email,
        "isTherapist": isTherapist,
        "gender": gender,
        "isActive": isActive,
        "isAccepted": isAccepted,
        "uploadProfileImgUrl": uploadProfileImgUrl,
        "userId": userId,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}
