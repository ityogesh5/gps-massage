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
    this.therapistList,
    this.totalPages,
    this.pageNumber,
  });

  int count;
  List<TherapistList> therapistList;
  int totalPages;
  int pageNumber;

  factory TherapistData.fromJson(Map<String, dynamic> json) => TherapistData(
    count: json["count"],
    therapistList: List<TherapistList>.from(json["therapistList"].map((x) => TherapistList.fromJson(x))),
    totalPages: json["totalPages"],
    pageNumber: json["pageNumber"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "therapistList": List<dynamic>.from(therapistList.map((x) => x.toJson())),
    "totalPages": totalPages,
    "pageNumber": pageNumber,
  };
}

class TherapistList {
  TherapistList({
    this.id,
    this.userId,
    this.categoryId,
    this.subCategoryId,
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
  int categoryId;
  int subCategoryId;
  String name;
  int sixtyMin;
  int nintyMin;
  int oneTwentyMin;
  int oneFifityMin;
  int oneEightyMin;
  DateTime createdAt;
  DateTime updatedAt;
  User user;

  factory TherapistList.fromJson(Map<String, dynamic> json) => TherapistList(
    id: json["id"],
    userId: json["userId"],
    categoryId: json["categoryId"],
    subCategoryId: json["subCategoryId"],
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
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
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
  dynamic uploadProfileImgUrl;
  String proofOfIdentityType;
  dynamic proofOfIdentityImgUrl;
  dynamic qulaificationCertImgUrl;
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
  List<CertificationUpload> certificationUploads;
  List<Banner> banners;
  List<Review> reviews;

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
    storePhone: json["storePhone"],
    storeDescription: json["storeDescription"],
    userOccupation: json["userOccupation"],
    genderOfService: json["genderOfService"],
    childrenMeasure: json["childrenMeasure"],
    customerId: json["customerId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    certificationUploads: List<CertificationUpload>.from(json["certification_uploads"].map((x) => CertificationUpload.fromJson(x))),
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
    "certification_uploads": List<dynamic>.from(certificationUploads.map((x) => x.toJson())),
    "banners": List<dynamic>.from(banners.map((x) => x.toJson())),
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
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
  dynamic acupuncturist;
  dynamic moxibutionist;
  dynamic acupuncturistAndMoxibustion;
  dynamic anmaMassageShiatsushi;
  dynamic judoRehabilitationTeacher;
  dynamic physicalTherapist;
  dynamic acquireNationalQualifications;
  dynamic privateQualification1;
  dynamic privateQualification2;
  dynamic privateQualification3;
  dynamic privateQualification4;
  dynamic privateQualification5;
  DateTime createdAt;
  DateTime updatedAt;

  factory CertificationUpload.fromJson(Map<String, dynamic> json) => CertificationUpload(
    id: json["id"],
    userId: json["userId"],
    acupuncturist: json["acupuncturist"],
    moxibutionist: json["moxibutionist"],
    acupuncturistAndMoxibustion: json["acupuncturistAndMoxibustion"],
    anmaMassageShiatsushi: json["anmaMassageShiatsushi"],
    judoRehabilitationTeacher: json["judoRehabilitationTeacher"],
    physicalTherapist: json["physicalTherapist"],
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
    "physicalTherapist": physicalTherapist,
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

class Review {
  Review({
    this.id,
    this.userId,
    this.therapistId,
    this.ratingsId,
    this.isReviewStatus,
    this.ratingsCount,
    this.reviewComment,
    this.createdUser,
    this.updatedUser,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int userId;
  int therapistId;
  dynamic ratingsId;
  bool isReviewStatus;
  int ratingsCount;
  String reviewComment;
  String createdUser;
  String updatedUser;
  DateTime createdAt;
  DateTime updatedAt;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    id: json["id"],
    userId: json["userId"],
    therapistId: json["therapistId"],
    ratingsId: json["ratingsId"],
    isReviewStatus: json["isReviewStatus"],
    ratingsCount: json["ratingsCount"],
    reviewComment: json["reviewComment"],
    createdUser: json["createdUser"],
    updatedUser: json["updatedUser"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "therapistId": therapistId,
    "ratingsId": ratingsId,
    "isReviewStatus": isReviewStatus,
    "ratingsCount": ratingsCount,
    "reviewComment": reviewComment,
    "createdUser": createdUser,
    "updatedUser": updatedUser,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}
