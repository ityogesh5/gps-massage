// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  LoginResponseModel({
    this.status,
    this.accessToken,
    this.data,
  });

  String status;
  String accessToken;
  Data data;

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
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
    this.storePhone,
    this.userOccupation,
    this.childrenMeasure,
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
  dynamic storePhone;
  String userOccupation;
  dynamic childrenMeasure;
  DateTime createdAt;
  DateTime updatedAt;
  List<dynamic> addresses;

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
    storePhone: json["storePhone"],
    userOccupation: json["userOccupation"],
    childrenMeasure: json["childrenMeasure"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    addresses: List<dynamic>.from(json["addresses"].map((x) => x)),
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
    "storePhone": storePhone,
    "userOccupation": userOccupation,
    "childrenMeasure": childrenMeasure,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "addresses": List<dynamic>.from(addresses.map((x) => x)),
  };
}
