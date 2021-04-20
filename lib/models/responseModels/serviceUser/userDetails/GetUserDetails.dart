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
    this.userId,
    this.email,
    this.phoneNumber,
    this.fcmToken,
    this.lineBotUserId,
    this.appleUserId,
    this.userName,
    this.dob,
    this.age,
    this.gender,
    this.isTherapist,
    this.isVerified,
    this.isActive,
    this.isAccepted,
    this.rejectReason,
    this.updatedUser,
    this.uploadProfileImgUrl,
    this.proofOfIdentityType,
    this.proofOfIdentityImgUrl,
    this.qulaificationCertImgUrl,
    this.businessForm,
    this.numberOfEmp,
    this.businessTrip,
    this.coronaMeasure,
    this.storeName,
    this.storeType,
    this.storePhone,
    this.storeDescription,
    this.userOccupation,
    this.genderOfService,
    this.childrenMeasure,
    this.customerId,
    this.createdAt,
    this.updatedAt,
    this.addresses,
  });

  int id;
  String userId;
  String email;
  int phoneNumber;
  dynamic fcmToken;
  dynamic lineBotUserId;
  dynamic appleUserId;
  String userName;
  DateTime dob;
  int age;
  String gender;
  bool isTherapist;
  bool isVerified;
  bool isActive;
  int isAccepted;
  dynamic rejectReason;
  dynamic updatedUser;
  String uploadProfileImgUrl;
  dynamic proofOfIdentityType;
  dynamic proofOfIdentityImgUrl;
  dynamic qulaificationCertImgUrl;
  dynamic businessForm;
  dynamic numberOfEmp;
  dynamic businessTrip;
  bool coronaMeasure;
  dynamic storeName;
  dynamic storeType;
  dynamic storePhone;
  dynamic storeDescription;
  String userOccupation;
  dynamic genderOfService;
  dynamic childrenMeasure;
  dynamic customerId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Address> addresses;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    userId: json["userId"],
    email: json["email"],
    phoneNumber: json["phoneNumber"],
    fcmToken: json["fcmToken"],
    lineBotUserId: json["lineBotUserId"],
    appleUserId: json["appleUserId"],
    userName: json["userName"],
    dob: DateTime.parse(json["dob"]),
    age: json["age"],
    gender: json["gender"],
    isTherapist: json["isTherapist"],
    isVerified: json["isVerified"],
    isActive: json["isActive"],
    isAccepted: json["isAccepted"],
    rejectReason: json["rejectReason"],
    updatedUser: json["updatedUser"],
    uploadProfileImgUrl: json["uploadProfileImgUrl"],
    proofOfIdentityType: json["proofOfIdentityType"],
    proofOfIdentityImgUrl: json["proofOfIdentityImgUrl"],
    qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
    businessForm: json["businessForm"],
    numberOfEmp: json["numberOfEmp"],
    businessTrip: json["businessTrip"],
    coronaMeasure: json["coronaMeasure"],
    storeName: json["storeName"],
    storeType: json["storeType"],
    storePhone: json["storePhone"],
    storeDescription: json["storeDescription"],
    userOccupation: json["userOccupation"],
    genderOfService: json["genderOfService"],
    childrenMeasure: json["childrenMeasure"],
    customerId: json["customerId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "email": email,
    "phoneNumber": phoneNumber,
    "fcmToken": fcmToken,
    "lineBotUserId": lineBotUserId,
    "appleUserId": appleUserId,
    "userName": userName,
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "age": age,
    "gender": gender,
    "isTherapist": isTherapist,
    "isVerified": isVerified,
    "isActive": isActive,
    "isAccepted": isAccepted,
    "rejectReason": rejectReason,
    "updatedUser": updatedUser,
    "uploadProfileImgUrl": uploadProfileImgUrl,
    "proofOfIdentityType": proofOfIdentityType,
    "proofOfIdentityImgUrl": proofOfIdentityImgUrl,
    "qulaificationCertImgUrl": qulaificationCertImgUrl,
    "businessForm": businessForm,
    "numberOfEmp": numberOfEmp,
    "businessTrip": businessTrip,
    "coronaMeasure": coronaMeasure,
    "storeName": storeName,
    "storeType": storeType,
    "storePhone": storePhone,
    "storeDescription": storeDescription,
    "userOccupation": userOccupation,
    "genderOfService": genderOfService,
    "childrenMeasure": childrenMeasure,
    "customerId": customerId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
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
  String otherAddressType;
  String capitalAndPrefecture;
  dynamic capitalAndPrefectureId;
  String cityName;
  dynamic citiesId;
  String area;
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
