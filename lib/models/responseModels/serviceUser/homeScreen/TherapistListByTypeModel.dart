// To parse this JSON data, do
//
//     final listOfTherapistModel = listOfTherapistModelFromJson(jsonString);

import 'dart:convert';

TherapistsByTypeModel listOfTherapistModelFromJson(String str) => TherapistsByTypeModel.fromJson(json.decode(str));

String listOfTherapistModelToJson(TherapistsByTypeModel data) => json.encode(data.toJson());

class TherapistsByTypeModel {
  TherapistsByTypeModel({
    this.status,
    this.therapistData,
  });

  String status;
  TherapistData therapistData;

  factory TherapistsByTypeModel.fromJson(Map<String, dynamic> json) => TherapistsByTypeModel(
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
    this.userList,
    this.totalPages,
    this.pageNumber,
  });

  int count;
  List<UserList> userList;
  int totalPages;
  int pageNumber;

  factory TherapistData.fromJson(Map<String, dynamic> json) => TherapistData(
    count: json["count"],
    userList: List<UserList>.from(json["userList"].map((x) => UserList.fromJson(x))),
    totalPages: json["totalPages"],
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "userList": List<dynamic>.from(userList.map((x) => x.toJson())),
    "totalPages": totalPages,
    "pageNumber": pageNumber,
  };
}

class UserList {
  UserList({
    this.id,
    this.userId,
    this.estheticId,
    this.name,
    this.sixtyMin,
    this.nintyMin,
    this.oneTwentyMin,
    this.oneFifityMin,
    this.oneEightyMin,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  int id;
  int userId;
  int estheticId;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory UserList.fromJson(Map<String, dynamic> json) => UserList(
    id: json["id"],
    userId: json["userId"],
    estheticId: json["estheticId"],
    name: json["name"],
    sixtyMin: json["sixtyMin"],
    nintyMin: json["nintyMin"],
    oneTwentyMin: json["oneTwentyMin"],
    oneFifityMin: json["oneFifityMin"],
    oneEightyMin: json["oneEightyMin"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "estheticId": estheticId,
    "name": name,
    "sixtyMin": sixtyMin,
    "nintyMin": nintyMin,
    "oneTwentyMin": oneTwentyMin,
    "oneFifityMin": oneFifityMin,
    "oneEightyMin": oneEightyMin,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "user": user.toJson(),
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
    this.certificationUploads,
    this.banners,
  });

  int id;
  String userId;
  Email email;
  int phoneNumber;
  dynamic fcmToken;
  dynamic lineBotUserId;
  dynamic appleUserId;
  UserName userName;
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
  StoreName storeName;
  StoreType storeType;
  int storePhone;
  dynamic storeDescription;
  dynamic userOccupation;
  GenderOfService genderOfService;
  ChildrenMeasure childrenMeasure;
  dynamic customerId;
  DateTime createdAt;
  DateTime updatedAt;
  List<CertificationUpload> certificationUploads;
  List<Banner> banners;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userId: json["userId"],
    email: emailValues.map[json["email"]],
    phoneNumber: json["phoneNumber"],
    fcmToken: json["fcmToken"],
    lineBotUserId: json["lineBotUserId"],
    appleUserId: json["appleUserId"],
    userName: userNameValues.map[json["userName"]],
    dob: DateTime.parse(json["dob"]),
    age: json["age"],
    gender: genderValues.map[json["gender"]],
    isTherapist: json["isTherapist"],
    isVerified: json["isVerified"],
    isActive: json["isActive"],
    isAccepted: json["isAccepted"],
    rejectReason: json["rejectReason"] == null ? null : json["rejectReason"],
    updatedUser: json["updatedUser"] == null ? null : json["updatedUser"],
    uploadProfileImgUrl: json["uploadProfileImgUrl"],
    proofOfIdentityType: json["proofOfIdentityType"],
    proofOfIdentityImgUrl: json["proofOfIdentityImgUrl"],
    qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
    businessForm: businessFormValues.map[json["businessForm"]],
    numberOfEmp: json["numberOfEmp"],
    businessTrip: json["businessTrip"],
    coronaMeasure: json["coronaMeasure"],
    storeName: storeNameValues.map[json["storeName"]],
    storeType: storeTypeValues.map[json["storeType"]],
    storePhone: json["storePhone"],
    storeDescription: json["storeDescription"],
    userOccupation: json["userOccupation"],
    genderOfService: genderOfServiceValues.map[json["genderOfService"]],
    childrenMeasure: childrenMeasureValues.map[json["childrenMeasure"]],
    customerId: json["customerId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    certificationUploads: List<CertificationUpload>.from(json["certification_uploads"].map((x) => CertificationUpload.fromJson(x))),
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "email": emailValues.reverse[email],
    "phoneNumber": phoneNumber,
    "fcmToken": fcmToken,
    "lineBotUserId": lineBotUserId,
    "appleUserId": appleUserId,
    "userName": userNameValues.reverse[userName],
    "dob": "${dob.year.toString().padLeft(4, '0')}-${dob.month.toString().padLeft(2, '0')}-${dob.day.toString().padLeft(2, '0')}",
    "age": age,
    "gender": genderValues.reverse[gender],
    "isTherapist": isTherapist,
    "isVerified": isVerified,
    "isActive": isActive,
    "isAccepted": isAccepted,
    "rejectReason": rejectReason == null ? null : rejectReason,
    "updatedUser": updatedUser == null ? null : updatedUser,
    "uploadProfileImgUrl": uploadProfileImgUrl,
    "proofOfIdentityType": proofOfIdentityType,
    "proofOfIdentityImgUrl": proofOfIdentityImgUrl,
    "qulaificationCertImgUrl": qulaificationCertImgUrl,
    "businessForm": businessFormValues.reverse[businessForm],
    "numberOfEmp": numberOfEmp,
    "businessTrip": businessTrip,
    "coronaMeasure": coronaMeasure,
    "storeName": storeNameValues.reverse[storeName],
    "storeType": storeTypeValues.reverse[storeType],
    "storePhone": storePhone,
    "storeDescription": storeDescription,
    "userOccupation": userOccupation,
    "genderOfService": genderOfServiceValues.reverse[genderOfService],
    "childrenMeasure": childrenMeasureValues.reverse[childrenMeasure],
    "customerId": customerId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "certification_uploads": List<dynamic>.from(certificationUploads.map((x) => x.toJson())),
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
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
  String bannerImageUrl1;
  String bannerImageUrl2;
  String bannerImageUrl3;
  String bannerImageUrl4;
  String bannerImageUrl5;
  DateTime createdAt;
  DateTime updatedAt;

  factory Banner.fromJson(Map<String, dynamic> json) => Banner(
    id: json["id"],
    userId: json["userId"],
    bannerImageUrl1: json["bannerImageUrl1"] == null ? null : json["bannerImageUrl1"],
    bannerImageUrl2: json["bannerImageUrl2"] == null ? null : json["bannerImageUrl2"],
    bannerImageUrl3: json["bannerImageUrl3"] == null ? null : json["bannerImageUrl3"],
    bannerImageUrl4: json["bannerImageUrl4"] == null ? null : json["bannerImageUrl4"],
    bannerImageUrl5: json["bannerImageUrl5"] == null ? null : json["bannerImageUrl5"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "bannerImageUrl1": bannerImageUrl1 == null ? null : bannerImageUrl1,
    "bannerImageUrl2": bannerImageUrl2 == null ? null : bannerImageUrl2,
    "bannerImageUrl3": bannerImageUrl3 == null ? null : bannerImageUrl3,
    "bannerImageUrl4": bannerImageUrl4 == null ? null : bannerImageUrl4,
    "bannerImageUrl5": bannerImageUrl5 == null ? null : bannerImageUrl5,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

enum BusinessForm { EMPTY }

final businessFormValues = EnumValues({
  "施術店舗あり 施術従業員あり": BusinessForm.EMPTY
});

class CertificationUpload {
  CertificationUpload({
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
  String acupuncturist;
  String moxibutionist;
  String acupuncturistAndMoxibustion;
  String anmaMassageShiatsushi;
  String judoRehabilitationTeacher;
  String physicalTherapist;
  String acquireNationalQualifications;
  String privateQualification1;
  String privateQualification2;
  String privateQualification3;
  String privateQualification4;
  String privateQualification5;
  DateTime createdAt;
  DateTime updatedAt;

  factory CertificationUpload.fromJson(Map<String, dynamic> json) => CertificationUpload(
    id: json["id"],
    userId: json["userId"],
    acupuncturist: json["acupuncturist"] == null ? null : json["acupuncturist"],
    moxibutionist: json["moxibutionist"] == null ? null : json["moxibutionist"],
    acupuncturistAndMoxibustion: json["acupuncturistAndMoxibustion"] == null ? null : json["acupuncturistAndMoxibustion"],
    anmaMassageShiatsushi: json["anmaMassageShiatsushi"] == null ? null : json["anmaMassageShiatsushi"],
    judoRehabilitationTeacher: json["judoRehabilitationTeacher"] == null ? null : json["judoRehabilitationTeacher"],
    physicalTherapist: json["physicalTherapist"] == null ? null : json["physicalTherapist"],
    acquireNationalQualifications: json["acquireNationalQualifications"] == null ? null : json["acquireNationalQualifications"],
    privateQualification1: json["privateQualification1"] == null ? null : json["privateQualification1"],
    privateQualification2: json["privateQualification2"] == null ? null : json["privateQualification2"],
    privateQualification3: json["privateQualification3"] == null ? null : json["privateQualification3"],
    privateQualification4: json["privateQualification4"] == null ? null : json["privateQualification4"],
    privateQualification5: json["privateQualification5"] == null ? null : json["privateQualification5"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "acupuncturist": acupuncturist == null ? null : acupuncturist,
    "moxibutionist": moxibutionist == null ? null : moxibutionist,
    "acupuncturistAndMoxibustion": acupuncturistAndMoxibustion == null ? null : acupuncturistAndMoxibustion,
    "anmaMassageShiatsushi": anmaMassageShiatsushi == null ? null : anmaMassageShiatsushi,
    "judoRehabilitationTeacher": judoRehabilitationTeacher == null ? null : judoRehabilitationTeacher,
    "physicalTherapist": physicalTherapist == null ? null : physicalTherapist,
    "acquireNationalQualifications": acquireNationalQualifications == null ? null : acquireNationalQualifications,
    "privateQualification1": privateQualification1 == null ? null : privateQualification1,
    "privateQualification2": privateQualification2 == null ? null : privateQualification2,
    "privateQualification3": privateQualification3 == null ? null : privateQualification3,
    "privateQualification4": privateQualification4 == null ? null : privateQualification4,
    "privateQualification5": privateQualification5 == null ? null : privateQualification5,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

enum ChildrenMeasure { EMPTY, OK, CHILDREN_MEASURE_OK }

final childrenMeasureValues = EnumValues({
  "キッズスペースの完備,保育士の常駐,子供同伴OK": ChildrenMeasure.CHILDREN_MEASURE_OK,
  "保育士の常駐": ChildrenMeasure.EMPTY,
  "子供同伴OK,保育士の常駐": ChildrenMeasure.OK
});

enum Email { AAAA_IIIII_COM, AHAA_IHIIIII_COM, ASWIN_GMAIL_COM }

final emailValues = EnumValues({
  "aaaa@iiiii.com": Email.AAAA_IIIII_COM,
  "ahaa@ihiiiii.com": Email.AHAA_IHIIIII_COM,
  "aswin@gmail.com": Email.ASWIN_GMAIL_COM
});

enum Gender { EMPTY }

final genderValues = EnumValues({
  "男性": Gender.EMPTY
});

enum GenderOfService { EMPTY, GENDER_OF_SERVICE }

final genderOfServiceValues = EnumValues({
  "男性女性両方": GenderOfService.EMPTY,
  "女性のみ": GenderOfService.GENDER_OF_SERVICE
});

enum StoreName { EMPTY, STORE_NAME, NEX_WARE }

final storeNameValues = EnumValues({
  "店舗おおおお": StoreName.EMPTY,
  "NexWare": StoreName.NEX_WARE,
  "マイ店だよーー": StoreName.STORE_NAME
});

enum StoreType { EMPTY, STORE_TYPE, PURPLE }

final storeTypeValues = EnumValues({
  "エステ,フィットネス": StoreType.EMPTY,
  "エステ,整体,リラクゼーション,フィットネス": StoreType.PURPLE,
  "エステ,リラクゼーション,フィットネス": StoreType.STORE_TYPE
});

enum UserName { EMPTY, USER_NAME, ASWIN }

final userNameValues = EnumValues({
  "Aswin": UserName.ASWIN,
  "アーシック": UserName.EMPTY,
  "アーシック　アリ": UserName.USER_NAME
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
