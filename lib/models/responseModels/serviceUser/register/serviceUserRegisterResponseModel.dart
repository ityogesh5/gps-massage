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
    this.smsSentstatus,
  });

  String token;
  UserResponse userResponse;
  AddressResponse addressResponse;
  SmsSentstatus smsSentstatus;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        userResponse: UserResponse.fromJson(json["userResponse"]),
        addressResponse: AddressResponse.fromJson(json["addressResponse"]),
        smsSentstatus: SmsSentstatus.fromJson(json["SmsSentstatus"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "userResponse": userResponse.toJson(),
        "addressResponse": addressResponse.toJson(),
        "SmsSentstatus": smsSentstatus.toJson(),
      };
}

class AddressResponse {
  AddressResponse({
    this.id,
    this.buildingName,
    this.address,
    this.cityName,
    this.area,
    this.lat,
    this.lon,
    this.userPlaceForMassage,
    this.userRoomNumber,
    this.addressTypeSelection,
    this.capitalAndPrefecture,
    this.userId,
    this.createdUser,
    this.updatedUser,
    this.updatedAt,
    this.createdAt,
  });

  int id;
  String buildingName;
  String address;
  String cityName;
  String area;
  String lat;
  String lon;
  String userPlaceForMassage;
  String userRoomNumber;
  String addressTypeSelection;
  String capitalAndPrefecture;
  int userId;
  String createdUser;
  String updatedUser;
  DateTime updatedAt;
  DateTime createdAt;

  factory AddressResponse.fromJson(Map<String, dynamic> json) =>
      AddressResponse(
        id: json["id"],
        buildingName: json["buildingName"],
        address: json["address"],
        cityName: json["cityName"],
        area: json["area"],
        lat: json["lat"],
        lon: json["lon"],
        userPlaceForMassage: json["userPlaceForMassage"],
        userRoomNumber: json["userRoomNumber"],
        addressTypeSelection: json["addressTypeSelection"],
        capitalAndPrefecture: json["capitalAndPrefecture"],
        userId: json["userId"],
        createdUser: json["createdUser"],
        updatedUser: json["updatedUser"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        createdAt: DateTime.parse(json["createdAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "buildingName": buildingName,
        "address": address,
        "cityName": cityName,
        "area": area,
        "lat": lat,
        "lon": lon,
        "userPlaceForMassage": userPlaceForMassage,
        "userRoomNumber": userRoomNumber,
        "addressTypeSelection": addressTypeSelection,
        "capitalAndPrefecture": capitalAndPrefecture,
        "userId": userId,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "updatedAt": updatedAt.toIso8601String(),
        "createdAt": createdAt.toIso8601String(),
      };
}

class SmsSentstatus {
  SmsSentstatus({
    this.isFulfilled,
    this.isRejected,
  });

  bool isFulfilled;
  bool isRejected;

  factory SmsSentstatus.fromJson(Map<String, dynamic> json) => SmsSentstatus(
        isFulfilled: json["isFulfilled"],
        isRejected: json["isRejected"],
      );

  Map<String, dynamic> toJson() => {
        "isFulfilled": isFulfilled,
        "isRejected": isRejected,
      };
}

class UserResponse {
  UserResponse({
    this.email,
    this.phoneNumber,
    this.userName,
    this.gender,
    this.dob,
    this.age,
    this.isTherapist,
    this.userOccupation,
    this.uploadProfileImgUrl,
  });

  String email;
  String phoneNumber;
  String userName;
  String gender;
  DateTime dob;
  String age;
  String isTherapist;
  String userOccupation;
  String uploadProfileImgUrl;

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        userName: json["userName"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        age: json["age"],
        isTherapist: json["isTherapist"],
        userOccupation: json["userOccupation"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phoneNumber": phoneNumber,
        "userName": userName,
        "gender": gender,
        "dob":
            "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
        "age": age,
        "isTherapist": isTherapist,
        "userOccupation": userOccupation,
        "uploadProfileImgUrl": uploadProfileImgUrl,
      };
}
