// To parse this JSON data, do
//
//     final listOfUserModel = listOfUserModelFromJson(jsonString);

import 'dart:convert';

ListOfUserModel listOfUserModelFromJson(String str) => ListOfUserModel.fromJson(json.decode(str));

String listOfUserModelToJson(ListOfUserModel data) => json.encode(data.toJson());

class ListOfUserModel {
  ListOfUserModel({
    this.status,
    this.userData,
  });

  String status;
  List<UserDatum> userData;

  factory ListOfUserModel.fromJson(Map<String, dynamic> json) => ListOfUserModel(
    status: json["status"],
    userData: List<UserDatum>.from(json["userData"].map((x) => UserDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "userData": List<dynamic>.from(userData.map((x) => x.toJson())),
  };
}

class UserDatum {
  UserDatum({
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
  Gender gender;
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
  int storePhone;
  dynamic storeDescription;
  String userOccupation;
  dynamic genderOfService;
  dynamic childrenMeasure;
  dynamic customerId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Address> addresses;

  factory UserDatum.fromJson(Map<String, dynamic> json) => UserDatum(
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
    gender: genderValues.map[json["gender"]],
    isTherapist: json["isTherapist"],
    isVerified: json["isVerified"],
    isActive: json["isActive"] == null ? null : json["isActive"],
    isAccepted: json["isAccepted"] == null ? null : json["isAccepted"],
    rejectReason: json["rejectReason"],
    updatedUser: json["updatedUser"],
    uploadProfileImgUrl: json["uploadProfileImgUrl"] == null ? null : json["uploadProfileImgUrl"],
    proofOfIdentityType: json["proofOfIdentityType"],
    proofOfIdentityImgUrl: json["proofOfIdentityImgUrl"],
    qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
    businessForm: json["businessForm"],
    numberOfEmp: json["numberOfEmp"],
    businessTrip: json["businessTrip"],
    coronaMeasure: json["coronaMeasure"],
    storeName: json["storeName"],
    storeType: json["storeType"],
    storePhone: json["storePhone"] == null ? null : json["storePhone"],
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
    "gender": genderValues.reverse[gender],
    "isTherapist": isTherapist,
    "isVerified": isVerified,
    "isActive": isActive == null ? null : isActive,
    "isAccepted": isAccepted == null ? null : isAccepted,
    "rejectReason": rejectReason,
    "updatedUser": updatedUser,
    "uploadProfileImgUrl": uploadProfileImgUrl == null ? null : uploadProfileImgUrl,
    "proofOfIdentityType": proofOfIdentityType,
    "proofOfIdentityImgUrl": proofOfIdentityImgUrl,
    "qulaificationCertImgUrl": qulaificationCertImgUrl,
    "businessForm": businessForm,
    "numberOfEmp": numberOfEmp,
    "businessTrip": businessTrip,
    "coronaMeasure": coronaMeasure,
    "storeName": storeName,
    "storeType": storeType,
    "storePhone": storePhone == null ? null : storePhone,
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
  AddressTypeSelection addressTypeSelection;
  String address;
  String userRoomNumber;
  UserPlaceForMassage userPlaceForMassage;
  dynamic otherAddressType;
  String capitalAndPrefecture;
  int capitalAndPrefectureId;
  String cityName;
  dynamic citiesId;
  String area;
  String buildingName;
  int postalCode;
  double lat;
  double lon;
  double userSearchRadiusDistance;
  String createdUser;
  String updatedUser;
  bool isDefault;
  DateTime createdAt;
  DateTime updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    userId: json["userId"],
    addressTypeSelection: addressTypeSelectionValues.map[json["addressTypeSelection"]],
    address: json["address"],
    userRoomNumber: json["userRoomNumber"] == null ? null : json["userRoomNumber"],
    userPlaceForMassage: json["userPlaceForMassage"] == null ? null : userPlaceForMassageValues.map[json["userPlaceForMassage"]],
    otherAddressType: json["otherAddressType"],
    capitalAndPrefecture: json["capitalAndPrefecture"] == null ? null : json["capitalAndPrefecture"],
    capitalAndPrefectureId: json["capitalAndPrefectureId"] == null ? null : json["capitalAndPrefectureId"],
    cityName: json["cityName"] == null ? null : json["cityName"],
    citiesId: json["citiesId"],
    area: json["area"] == null ? null : json["area"],
    buildingName: json["buildingName"] == null ? null : json["buildingName"],
    postalCode: json["postalCode"] == null ? null : json["postalCode"],
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lon: json["lon"] == null ? null : json["lon"].toDouble(),
    userSearchRadiusDistance: json["userSearchRadiusDistance"] == null ? null : json["userSearchRadiusDistance"].toDouble(),
    createdUser: json["createdUser"] == null ? null : json["createdUser"],
    updatedUser: json["updatedUser"] == null ? null : json["updatedUser"],
    isDefault: json["isDefault"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "addressTypeSelection": addressTypeSelectionValues.reverse[addressTypeSelection],
    "address": address,
    "userRoomNumber": userRoomNumber == null ? null : userRoomNumber,
    "userPlaceForMassage": userPlaceForMassage == null ? null : userPlaceForMassageValues.reverse[userPlaceForMassage],
    "otherAddressType": otherAddressType,
    "capitalAndPrefecture": capitalAndPrefecture == null ? null : capitalAndPrefecture,
    "capitalAndPrefectureId": capitalAndPrefectureId == null ? null : capitalAndPrefectureId,
    "cityName": cityName == null ? null : cityName,
    "citiesId": citiesId,
    "area": area == null ? null : area,
    "buildingName": buildingName == null ? null : buildingName,
    "postalCode": postalCode == null ? null : postalCode,
    "lat": lat == null ? null : lat,
    "lon": lon == null ? null : lon,
    "userSearchRadiusDistance": userSearchRadiusDistance == null ? null : userSearchRadiusDistance,
    "createdUser": createdUser == null ? null : createdUser,
    "updatedUser": updatedUser == null ? null : updatedUser,
    "isDefault": isDefault,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

enum AddressTypeSelection { MANUAL, EMPTY, ADDRESS_TYPE_SELECTION, GPS }

final addressTypeSelectionValues = EnumValues({
  "直接入力する": AddressTypeSelection.ADDRESS_TYPE_SELECTION,
  "現在地を取得する": AddressTypeSelection.EMPTY,
  "GPS": AddressTypeSelection.GPS,
  "manual": AddressTypeSelection.MANUAL
});

enum UserPlaceForMassage { HOME, EMPTY, USER_PLACE_FOR_MASSAGE, PURPLE, FLUFFY, MODERAN_HOUSE, BIG_ROCK_HOUSE }

final userPlaceForMassageValues = EnumValues({
  "Big rock house": UserPlaceForMassage.BIG_ROCK_HOUSE,
  "自宅": UserPlaceForMassage.EMPTY,
  "実家": UserPlaceForMassage.FLUFFY,
  "Home": UserPlaceForMassage.HOME,
  "moderanHouse": UserPlaceForMassage.MODERAN_HOUSE,
  "その他（直接入力）": UserPlaceForMassage.PURPLE,
  "オフィス": UserPlaceForMassage.USER_PLACE_FOR_MASSAGE
});

enum Gender { M, EMPTY, GENDER, PURPLE }

final genderValues = EnumValues({
  "男性": Gender.EMPTY,
  "女性": Gender.GENDER,
  "M": Gender.M,
  "どちらでもない": Gender.PURPLE
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
