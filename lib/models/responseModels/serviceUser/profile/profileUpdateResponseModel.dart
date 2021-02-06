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
    this.addressDataOne,
    this.addressDataTwo,
    this.addressDataThree,
  });

  String status;
  Data data;
  AddressData addressDataOne;
  AddressData addressDataTwo;
  AddressData addressDataThree;

  factory ProfileUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      ProfileUpdateResponseModel(
        status: json["status"],
        data: Data.fromJson(json["data"]),
        addressDataOne: AddressData.fromJson(json["AddressDataOne"]),
        addressDataTwo: AddressData.fromJson(json["AddressDataTwo"]),
        addressDataThree: AddressData.fromJson(json["AddressDataThree"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
        "AddressDataOne": addressDataOne.toJson(),
        "AddressDataTwo": addressDataTwo.toJson(),
        "AddressDataThree": addressDataThree.toJson(),
      };
}

class AddressData {
  AddressData({
    this.subAddressOne,
    this.addressTypeSelection,
    this.capitalAndPrefecture,
    this.userRoomNumber,
    this.cityName,
    this.area,
    this.lat,
    this.lon,
    this.subAddressThree,
    this.subAddressTwo,
  });

  String subAddressOne;
  String addressTypeSelection;
  String capitalAndPrefecture;
  String userRoomNumber;
  String cityName;
  String area;
  double lat;
  double lon;
  String subAddressThree;
  String subAddressTwo;

  factory AddressData.fromJson(Map<String, dynamic> json) => AddressData(
        subAddressOne:
            json["SubAddressOne"] == null ? null : json["SubAddressOne"],
        addressTypeSelection: json["addressTypeSelection"] == null
            ? null
            : json["addressTypeSelection"],
        capitalAndPrefecture: json["capitalAndPrefecture"],
        userRoomNumber: json["userRoomNumber"],
        cityName: json["cityName"],
        area: json["area"],
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
        subAddressThree:
            json["SubAddressThree"] == null ? null : json["SubAddressThree"],
        subAddressTwo:
            json["SubAddressTwo"] == null ? null : json["SubAddressTwo"],
      );

  Map<String, dynamic> toJson() => {
        "SubAddressOne": subAddressOne == null ? null : subAddressOne,
        "addressTypeSelection":
            addressTypeSelection == null ? null : addressTypeSelection,
        "capitalAndPrefecture": capitalAndPrefecture,
        "userRoomNumber": userRoomNumber,
        "cityName": cityName,
        "area": area,
        "lat": lat,
        "lon": lon,
        "SubAddressThree": subAddressThree == null ? null : subAddressThree,
        "SubAddressTwo": subAddressTwo == null ? null : subAddressTwo,
      };
}

class Data {
  Data({
    this.email,
    this.phoneNumber,
    this.userName,
    this.gender,
    this.dob,
    this.age,
    this.isTherapist,
    this.userOccupation,
    this.uploadProfileImgUrl,
    this.userSearchRadiusDistance,
  });

  String email;
  int phoneNumber;
  String userName;
  String gender;
  DateTime dob;
  int age;
  bool isTherapist;
  String userOccupation;
  String uploadProfileImgUrl;
  dynamic userSearchRadiusDistance;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        email: json["email"],
        phoneNumber: json["phoneNumber"],
        userName: json["userName"],
        gender: json["gender"],
        dob: DateTime.parse(json["dob"]),
        age: json["age"],
        isTherapist: json["isTherapist"],
        userOccupation: json["userOccupation"],
        uploadProfileImgUrl: json["uploadProfileImgUrl"],
        userSearchRadiusDistance: json["userSearchRadiusDistance"],
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
        "userSearchRadiusDistance": userSearchRadiusDistance,
      };
}
