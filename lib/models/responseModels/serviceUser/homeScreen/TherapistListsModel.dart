// To parse this JSON data, do
//
//     final listOfTherapistModel = listOfTherapistModelFromJson(jsonString);

import 'dart:convert';

ListOfTherapistModel listOfTherapistModelFromJson(String str) => ListOfTherapistModel.fromJson(json.decode(str));

String listOfTherapistModelToJson(ListOfTherapistModel data) => json.encode(data.toJson());

class ListOfTherapistModel {
  ListOfTherapistModel({
    this.status,
    this.therapistData,
  });

  String status;
  List<TherapistDatum> therapistData;

  factory ListOfTherapistModel.fromJson(Map<String, dynamic> json) => ListOfTherapistModel(
    status: json["status"],
    therapistData: List<TherapistDatum>.from(json["therapistData"].map((x) => TherapistDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "therapistData": List<dynamic>.from(therapistData.map((x) => x.toJson())),
  };
}

class TherapistDatum {
  TherapistDatum({
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
  String rejectReason;
  String updatedUser;
  String uploadProfileImgUrl;
  String proofOfIdentityType;
  String proofOfIdentityImgUrl;
  String qulaificationCertImgUrl;
  BusinessForm businessForm;
  int numberOfEmp;
  bool businessTrip;
  bool coronaMeasure;
  String storeName;
  String storeType;
  int storePhone;
  String storeDescription;
  dynamic userOccupation;
  GenderOfService genderOfService;
  String childrenMeasure;
  dynamic customerId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Address> addresses;

  factory TherapistDatum.fromJson(Map<String, dynamic> json) => TherapistDatum(
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
    rejectReason: json["rejectReason"] == null ? null : json["rejectReason"],
    updatedUser: json["updatedUser"] == null ? null : json["updatedUser"],
    uploadProfileImgUrl: json["uploadProfileImgUrl"] == null ? null : json["uploadProfileImgUrl"],
    proofOfIdentityType: json["proofOfIdentityType"],
    proofOfIdentityImgUrl: json["proofOfIdentityImgUrl"] == null ? null : json["proofOfIdentityImgUrl"],
    qulaificationCertImgUrl: json["qulaificationCertImgUrl"] == null ? null : json["qulaificationCertImgUrl"],
    businessForm: businessFormValues.map[json["businessForm"]],
    numberOfEmp: json["numberOfEmp"] == null ? null : json["numberOfEmp"],
    businessTrip: json["businessTrip"],
    coronaMeasure: json["coronaMeasure"],
    storeName: json["storeName"] == null ? null : json["storeName"],
    storeType: json["storeType"],
    storePhone: json["storePhone"] == null ? null : json["storePhone"],
    storeDescription: json["storeDescription"] == null ? null : json["storeDescription"],
    userOccupation: json["userOccupation"],
    genderOfService: json["genderOfService"] == null ? null : genderOfServiceValues.map[json["genderOfService"]],
    childrenMeasure: json["childrenMeasure"] == null ? null : json["childrenMeasure"],
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
    "rejectReason": rejectReason == null ? null : rejectReason,
    "updatedUser": updatedUser == null ? null : updatedUser,
    "uploadProfileImgUrl": uploadProfileImgUrl == null ? null : uploadProfileImgUrl,
    "proofOfIdentityType": proofOfIdentityType,
    "proofOfIdentityImgUrl": proofOfIdentityImgUrl == null ? null : proofOfIdentityImgUrl,
    "qulaificationCertImgUrl": qulaificationCertImgUrl == null ? null : qulaificationCertImgUrl,
    "businessForm": businessFormValues.reverse[businessForm],
    "numberOfEmp": numberOfEmp == null ? null : numberOfEmp,
    "businessTrip": businessTrip,
    "coronaMeasure": coronaMeasure,
    "storeName": storeName == null ? null : storeName,
    "storeType": storeType,
    "storePhone": storePhone == null ? null : storePhone,
    "storeDescription": storeDescription == null ? null : storeDescription,
    "userOccupation": userOccupation,
    "genderOfService": genderOfService == null ? null : genderOfServiceValues.reverse[genderOfService],
    "childrenMeasure": childrenMeasure == null ? null : childrenMeasure,
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
  dynamic userPlaceForMassage;
  dynamic otherAddressType;
  String capitalAndPrefecture;
  int capitalAndPrefectureId;
  String cityName;
  int citiesId;
  String area;
  String buildingName;
  int postalCode;
  double lat;
  double lon;
  dynamic userSearchRadiusDistance;
  String createdUser;
  String updatedUser;
  bool isDefault;
  DateTime createdAt;
  DateTime updatedAt;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    id: json["id"],
    userId: json["userId"],
    addressTypeSelection: json["addressTypeSelection"] == null ? null : addressTypeSelectionValues.map[json["addressTypeSelection"]],
    address: json["address"],
    userRoomNumber: json["userRoomNumber"],
    userPlaceForMassage: json["userPlaceForMassage"],
    otherAddressType: json["otherAddressType"],
    capitalAndPrefecture: json["capitalAndPrefecture"] == null ? null : json["capitalAndPrefecture"],
    capitalAndPrefectureId: json["capitalAndPrefectureId"] == null ? null : json["capitalAndPrefectureId"],
    cityName: json["cityName"] == null ? null : json["cityName"],
    citiesId: json["citiesId"] == null ? null : json["citiesId"],
    area: json["area"],
    buildingName: json["buildingName"],
    postalCode: json["postalCode"] == null ? null : json["postalCode"],
    lat: json["lat"].toDouble(),
    lon: json["lon"].toDouble(),
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
    "addressTypeSelection": addressTypeSelection == null ? null : addressTypeSelectionValues.reverse[addressTypeSelection],
    "address": address,
    "userRoomNumber": userRoomNumber,
    "userPlaceForMassage": userPlaceForMassage,
    "otherAddressType": otherAddressType,
    "capitalAndPrefecture": capitalAndPrefecture == null ? null : capitalAndPrefecture,
    "capitalAndPrefectureId": capitalAndPrefectureId == null ? null : capitalAndPrefectureId,
    "cityName": cityName == null ? null : cityName,
    "citiesId": citiesId == null ? null : citiesId,
    "area": area,
    "buildingName": buildingName,
    "postalCode": postalCode == null ? null : postalCode,
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

enum AddressTypeSelection { EMPTY, ADDRESS_TYPE_SELECTION, GPS }

final addressTypeSelectionValues = EnumValues({
  "直接入力": AddressTypeSelection.ADDRESS_TYPE_SELECTION,
  "現在地を取得する": AddressTypeSelection.EMPTY,
  "GPS": AddressTypeSelection.GPS
});

enum BusinessForm { EMPTY, BUSINESS_FORM, PURPLE, ABCD_COMPANY, FLUFFY }

final businessFormValues = EnumValues({
  "abcd company": BusinessForm.ABCD_COMPANY,
  "施術店舗なし 施術従業員なし（個人)": BusinessForm.BUSINESS_FORM,
  "施術店舗あり 施術従業員あり": BusinessForm.EMPTY,
  "施術店舗なし 施術従業員あり（出張のみ)": BusinessForm.FLUFFY,
  "施術店舗あり 施術従業員なし（個人経営）": BusinessForm.PURPLE
});

enum Gender { EMPTY, GENDER, PURPLE, M }

final genderValues = EnumValues({
  "男性": Gender.EMPTY,
  "女性": Gender.GENDER,
  "M": Gender.M,
  "どちらでもない": Gender.PURPLE
});

enum GenderOfService { EMPTY, GENDER_OF_SERVICE, PURPLE, M }

final genderOfServiceValues = EnumValues({
  "": GenderOfService.EMPTY,
  "男性女性両方": GenderOfService.GENDER_OF_SERVICE,
  "M": GenderOfService.M,
  "女性のみ": GenderOfService.PURPLE
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
