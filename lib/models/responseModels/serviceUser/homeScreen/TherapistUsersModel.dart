// To parse this JSON data, do
//
//     final therapistUsersModel = therapistUsersModelFromJson(jsonString);

import 'dart:convert';

TherapistUsersModel therapistUsersModelFromJson(String str) => TherapistUsersModel.fromJson(json.decode(str));

String therapistUsersModelToJson(TherapistUsersModel data) => json.encode(data.toJson());

class TherapistUsersModel {
  TherapistUsersModel({
    this.status,
    this.therapistData,
  });

  String status;
  TherapistData therapistData;

  factory TherapistUsersModel.fromJson(Map<String, dynamic> json) => TherapistUsersModel(
    status: json["status"],
    therapistData: TherapistData.fromJson(json["therapistData"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "therapistData": therapistData.toJson(),
  };
}

class TherapistData {
  TherapistData({
    this.count,
    this.therapistUserList,
    this.totalPages,
    this.pageNumber,
  });

  int count;
  List<TherapistUserList> therapistUserList;
  int totalPages;
  int pageNumber;

  factory TherapistData.fromJson(Map<String, dynamic> json) => TherapistData(
    count: json["count"],
    therapistUserList: List<TherapistUserList>.from(json["therapistUserList"].map((x) => TherapistUserList.fromJson(x))),
    totalPages: json["totalPages"],
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "therapistUserList": List<dynamic>.from(therapistUserList.map((x) => x.toJson())),
    "totalPages": totalPages,
    "pageNumber": pageNumber,
  };
}

class TherapistUserList {
  TherapistUserList({
    this.id,
    this.userId,
    this.orteopathicId,
    this.name,
    this.sixtyMin,
    this.nintyMin,
    this.oneTwentyMin,
    this.oneFifityMin,
    this.oneEightyMin,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.fitnessId,
    this.estheticId,
    this.relaxationId,
  });

  int id;
  int userId;
  int orteopathicId;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  DateTime createdAt;
  DateTime updatedAt;
  User user;
  int fitnessId;
  int estheticId;
  int relaxationId;

  factory TherapistUserList.fromJson(Map<String, dynamic> json) => TherapistUserList(
    id: json["id"],
    userId: json["userId"],
    orteopathicId: json["orteopathicId"] == null ? null : json["orteopathicId"],
    name: json["name"],
    sixtyMin: json["sixtyMin"],
    nintyMin: json["nintyMin"],
    oneTwentyMin: json["oneTwentyMin"],
    oneFifityMin: json["oneFifityMin"],
    oneEightyMin: json["oneEightyMin"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    user: User.fromJson(json["user"]),
    fitnessId: json["fitnessId"] == null ? null : json["fitnessId"],
    estheticId: json["estheticId"] == null ? null : json["estheticId"],
    relaxationId: json["relaxationId"] == null ? null : json["relaxationId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "orteopathicId": orteopathicId == null ? null : orteopathicId,
    "name": name,
    "sixtyMin": sixtyMin,
    "nintyMin": nintyMin,
    "oneTwentyMin": oneTwentyMin,
    "oneFifityMin": oneFifityMin,
    "oneEightyMin": oneEightyMin,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "user": user.toJson(),
    "fitnessId": fitnessId == null ? null : fitnessId,
    "estheticId": estheticId == null ? null : estheticId,
    "relaxationId": relaxationId == null ? null : relaxationId,
  };
}

class User {
  User({
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
    this.certificationUploads,
    this.bankDetails,
    this.banners,
    this.reviews,
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
  String proofOfIdentityType;
  String proofOfIdentityImgUrl;
  String qulaificationCertImgUrl;
  String businessForm;
  int numberOfEmp;
  bool businessTrip;
  bool coronaMeasure;
  String storeName;
  String storeType;
  int storePhone;
  dynamic storeDescription;
  dynamic userOccupation;
  String genderOfService;
  String childrenMeasure;
  dynamic customerId;
  DateTime createdAt;
  DateTime updatedAt;
  List<Address> addresses;
  List<CertificationTherapistUsers> certificationUploads;
  List<BankDetail> bankDetails;
  List<Banner> banners;
  List<dynamic> reviews;

  factory User.fromJson(Map<String, dynamic> json) => User(
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
    storePhone: json["storePhone"] == null ? null : json["storePhone"],
    storeDescription: json["storeDescription"],
    userOccupation: json["userOccupation"],
    genderOfService: json["genderOfService"],
    childrenMeasure: json["childrenMeasure"],
    customerId: json["customerId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
    certificationUploads: List<CertificationTherapistUsers>.from(json["certification_uploads"].map((x) => CertificationTherapistUsers.fromJson(x))),
    bankDetails: List<BankDetail>.from(json["bankDetails"].map((x) => BankDetail.fromJson(x))),
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    reviews: List<dynamic>.from(json["reviews"].map((x) => x)),
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
    "storePhone": storePhone == null ? null : storePhone,
    "storeDescription": storeDescription,
    "userOccupation": userOccupation,
    "genderOfService": genderOfService,
    "childrenMeasure": childrenMeasure,
    "customerId": customerId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "addresses": List<dynamic>.from(addresses.map((x) => x.toJson())),
    "certification_uploads": List<dynamic>.from(certificationUploads.map((x) => x.toJson())),
    "bankDetails": List<dynamic>.from(bankDetails.map((x) => x.toJson())),
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews.map((x) => x)),
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
  dynamic userPlaceForMassage;
  dynamic otherAddressType;
  String capitalAndPrefecture;
  dynamic capitalAndPrefectureId;
  String cityName;
  dynamic citiesId;
  String area;
  String buildingName;
  dynamic postalCode;
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

class BankDetail {
  BankDetail({
    this.id,
    this.userId,
    this.bankName,
    this.branchCode,
    this.branchNumber,
    this.accountNumber,
    this.accountType,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  String bankName;
  String branchCode;
  String branchNumber;
  String accountNumber;
  String accountType;
  DateTime createdAt;
  DateTime updatedAt;

  factory BankDetail.fromJson(Map<String, dynamic> json) => BankDetail(
    id: json["id"],
    userId: json["userId"],
    bankName: json["bankName"],
    branchCode: json["branchCode"],
    branchNumber: json["branchNumber"],
    accountNumber: json["accountNumber"],
    accountType: json["accountType"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "bankName": bankName,
    "branchCode": branchCode,
    "branchNumber": branchNumber,
    "accountNumber": accountNumber,
    "accountType": accountType,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Banner {
  Banner({
    this.id,
    this.userId,
    this.bannerImageUrl1,
    this.bannerImageUrl2,
    this.bannerImageUrl3,
    this.bannerImageUrl4,
    this.bannerImageUrl5,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  dynamic bannerImageUrl1;
  dynamic bannerImageUrl2;
  dynamic bannerImageUrl3;
  dynamic bannerImageUrl4;
  dynamic bannerImageUrl5;
  DateTime createdAt;
  DateTime updatedAt;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    userId: json["userId"],
    bannerImageUrl1: json["bannerImageUrl1"],
    bannerImageUrl2: json["bannerImageUrl2"],
    bannerImageUrl3: json["bannerImageUrl3"],
    bannerImageUrl4: json["bannerImageUrl4"],
    bannerImageUrl5: json["bannerImageUrl5"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "bannerImageUrl1": bannerImageUrl1,
    "bannerImageUrl2": bannerImageUrl2,
    "bannerImageUrl3": bannerImageUrl3,
    "bannerImageUrl4": bannerImageUrl4,
    "bannerImageUrl5": bannerImageUrl5,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class CertificationTherapistUsers {
  CertificationTherapistUsers({
    this.id,
    this.userId,
    this.acupuncturist,
    this.moxibutionist,
    this.acupuncturistAndMoxibustion,
    this.anmaMassageShiatsushi,
    this.judoRehabilitationTeacher,
    this.physicalTherapist,
    this.acquireNationalQualifications,
    this.privateQualification1,
    this.privateQualification2,
    this.privateQualification3,
    this.privateQualification4,
    this.privateQualification5,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  dynamic acupuncturist;
  dynamic moxibutionist;
  dynamic acupuncturistAndMoxibustion;
  dynamic anmaMassageShiatsushi;
  dynamic judoRehabilitationTeacher;
  String physicalTherapist;
  dynamic acquireNationalQualifications;
  dynamic privateQualification1;
  dynamic privateQualification2;
  dynamic privateQualification3;
  dynamic privateQualification4;
  dynamic privateQualification5;
  DateTime createdAt;
  DateTime updatedAt;

  factory CertificationTherapistUsers.fromJson(Map<String, dynamic> json) => CertificationTherapistUsers(
    id: json["id"],
    userId: json["userId"],
    acupuncturist: json["acupuncturist"],
    moxibutionist: json["moxibutionist"],
    acupuncturistAndMoxibustion: json["acupuncturistAndMoxibustion"],
    anmaMassageShiatsushi: json["anmaMassageShiatsushi"],
    judoRehabilitationTeacher: json["judoRehabilitationTeacher"],
    physicalTherapist: json["physicalTherapist"] == null ? null : json["physicalTherapist"],
    acquireNationalQualifications: json["acquireNationalQualifications"],
    privateQualification1: json["privateQualification1"],
    privateQualification2: json["privateQualification2"],
    privateQualification3: json["privateQualification3"],
    privateQualification4: json["privateQualification4"],
    privateQualification5: json["privateQualification5"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "acupuncturist": acupuncturist,
    "moxibutionist": moxibutionist,
    "acupuncturistAndMoxibustion": acupuncturistAndMoxibustion,
    "anmaMassageShiatsushi": anmaMassageShiatsushi,
    "judoRehabilitationTeacher": judoRehabilitationTeacher,
    "physicalTherapist": physicalTherapist == null ? null : physicalTherapist,
    "acquireNationalQualifications": acquireNationalQualifications,
    "privateQualification1": privateQualification1,
    "privateQualification2": privateQualification2,
    "privateQualification3": privateQualification3,
    "privateQualification4": privateQualification4,
    "privateQualification5": privateQualification5,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
