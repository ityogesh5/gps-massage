// To parse this JSON data, do
//
//     final profileUpdateResponseModel = profileUpdateResponseModelFromJson(jsonString);

import 'dart:convert';

ProfileUpdateResponseModel profileUpdateResponseModelFromJson(String str) =>
    ProfileUpdateResponseModel.fromJson(json.decode(str));

String profileUpdateResponseModelToJson(ProfileUpdateResponseModel data) =>
    json.encode(data.toJson());

class ProfileUpdateResponseModel {
  ProfileUpdateResponseModel({
    this.status,
    this.data,
    this.address,
    this.subAddress,
  });

  String status;
  Data data;
  Address address;
  List<dynamic> subAddress;

  factory ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponseModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        address: Address.fromJson(json["address"]),
        subAddress: List<dynamic>.from(json["subAddress"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "address": address.toJson(),
        "subAddress": List<dynamic>.from(subAddress.map((x) => x)),
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
  dynamic area;
  String buildingName;
  dynamic postalCode;
  dynamic lat;
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
        lat: json["lat"],
        lon: json["lon"],
        userSearchRadiusDistance: json["userSearchRadiusDistance"],
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
        "userSearchRadiusDistance": userSearchRadiusDistance,
        "createdUser": createdUser,
        "updatedUser": updatedUser,
        "isDefault": isDefault,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
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
      };
}
