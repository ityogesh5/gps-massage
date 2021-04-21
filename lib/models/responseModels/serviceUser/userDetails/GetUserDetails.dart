// To parse this JSON data, do
//
//     final getUserDetailsByIdModel = getUserDetailsByIdModelFromJson(jsonString);

import 'dart:convert';

GetUserDetailsByIdModel getUserDetailsByIdModelFromJson(String str) => GetUserDetailsByIdModel.fromJson(json.decode(str));

String getUserDetailsByIdModelToJson(GetUserDetailsByIdModel data) => json.encode(data.toJson());

class GetUserDetailsByIdModel {
  GetUserDetailsByIdModel({
    this.status,
    this.data,
  });

  String status;
  Data data;

  factory GetUserDetailsByIdModel.fromJson(Map<String, dynamic> json) => GetUserDetailsByIdModel(
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
  String uploadProfileImgUrl;
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
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "phoneNumber": phoneNumber,
    "userName": userName,
    "gender": gender,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
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
  String otherAddressType;
  String capitalAndPrefecture;
  dynamic capitalAndPrefectureId;
  String cityName;
  dynamic citiesId;
  String area;
  String buildingName;
  dynamic postalCode;
  double lat;
  double lon;
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
    userRoomNumber: json["userRoomNumber"],
    userPlaceForMassage: json["userPlaceForMassage"],
    otherAddressType: json["otherAddressType"],
    capitalAndPrefecture: json["capitalAndPrefecture"],
    capitalAndPrefectureId: json["capitalAndPrefectureId"],
    cityName: json["cityName"],
    citiesId: json["citiesId"],
    area: json["area"],
    buildingName: json["buildingName"],
    postalCode: json["postalCode"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
    createdUser: json["createdUser"],
    updatedUser: json["updatedUser"],
    isDefault: json["isDefault"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
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
    "capitalAndPrefectureId": capitalAndPrefectureId,
    "cityName": cityName,
    "citiesId": citiesId,
    "area": area,
    "buildingName": buildingName,
    "postalCode": postalCode,
    "lat": lat,
    "lon": lon,
    "createdUser": createdUser,
    "updatedUser": updatedUser,
    "isDefault": isDefault,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
