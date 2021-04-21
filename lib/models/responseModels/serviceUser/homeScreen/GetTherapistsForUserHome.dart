// To parse this JSON data, do
//
//     final therapistUsersModel = therapistUsersModelFromJson(jsonString);

import 'dart:convert';

TherapistUsersModel therapistUsersModelFromJson(String str) => TherapistUsersModel.fromJson(json.decode(str));

String therapistUsersModelToJson(TherapistUsersModel data) => json.encode(data.toJson());

class TherapistUsersModel {
  TherapistUsersModel({
    this.status,
    this.homeTherapistData,
  });

  String status;
  List<HomeTherapistDatum> homeTherapistData;

  factory TherapistUsersModel.fromJson(Map<String, dynamic> json) => TherapistUsersModel(
    status: json["status"],
    homeTherapistData: List<HomeTherapistDatum>.from(json["homeTherapistData"].map((x) => HomeTherapistDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "homeTherapistData": List<dynamic>.from(homeTherapistData.map((x) => x.toJson())),
  };
}

class HomeTherapistDatum {
  HomeTherapistDatum({
    this.id,
    this.userId,
    this.categoryId,
    this.subCategoryId,
    this.name,
    this.user,
    this.nintyMins,
  });

  int id;
  int userId;
  int categoryId;
  int subCategoryId;
  String name;
  User user;
  int nintyMins;

  factory HomeTherapistDatum.fromJson(Map<String, dynamic> json) => HomeTherapistDatum(
    id: json["id"],
    userId: json["userId"],
    categoryId: json["categoryId"],
    subCategoryId: json["subCategoryId"],
    name: json["name"],
    user: User.fromJson(json["user"]),
    nintyMins: json["nintyMins"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "name": name,
    "user": user.toJson(),
    "nintyMins": nintyMins,
  };
}

class User {
  User({
    this.id,
    this.userId,
    this.userName,
    this.uploadProfileImgUrl,
    this.storeType,
    this.qulaificationCertImgUrl,
    this.businessForm,
    this.childrenMeasure,
    this.coronaMeasure,
    this.businessTrip,
    this.reviews,
    this.certificationUploads,
    this.banners,
  });

  int id;
  String userId;
  String userName;
  dynamic uploadProfileImgUrl;
  String storeType;
  dynamic qulaificationCertImgUrl;
  String businessForm;
  String childrenMeasure;
  bool coronaMeasure;
  bool businessTrip;
  List<Review> reviews;
  List<CertificationUpload> certificationUploads;
  List<Banner> banners;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    userId: json["userId"],
    userName: json["userName"],
    uploadProfileImgUrl: json["uploadProfileImgUrl"],
    storeType: json["storeType"],
    qulaificationCertImgUrl: json["qulaificationCertImgUrl"],
    businessForm: json["businessForm"],
    childrenMeasure: json["childrenMeasure"],
    coronaMeasure: json["coronaMeasure"],
    businessTrip: json["businessTrip"],
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    certificationUploads: List<CertificationUpload>.from(json["certification_uploads"].map((x) => CertificationUpload.fromJson(x))),
    banners: List<Banner>.from(json["banners"].map((x) => Banner.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "userId": userId,
    "userName": userName,
    "uploadProfileImgUrl": uploadProfileImgUrl,
    "storeType": storeType,
    "qulaificationCertImgUrl": qulaificationCertImgUrl,
    "businessForm": businessForm,
    "childrenMeasure": childrenMeasure,
    "coronaMeasure": coronaMeasure,
    "businessTrip": businessTrip,
    "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
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
    this.therapistId,
    this.ratingAvg,
  });

  int therapistId;
  String ratingAvg;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    therapistId: json["therapistId"],
    ratingAvg: json["ratingAvg"],
  );

  Map<String, dynamic> toJson() => {
    "therapistId": therapistId,
    "ratingAvg": ratingAvg,
  };
}
